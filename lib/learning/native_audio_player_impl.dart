// native_audio_player_impl.dart
// Implémentation NATIVE — just_audio (Android / iOS / macOS…)

import 'dart:async';
import 'package:just_audio/just_audio.dart';

import 'abstract_audio_player.dart';
import 'audio_player_state.dart';

class NativeAudioPlayerImpl extends AbstractAudioPlayer {
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<PlayerState>? _completionSub;
  bool _disposed = false;

  AudioPlayerState  _state = AudioPlayerState.idle;
  AudioPlayerError? _error;

  @override AudioPlayerState  get playerState => _state;
  @override AudioPlayerError? get error        => _error;

  // Guard _disposed : empêche notifyListeners() après dispose().
  void _setState(AudioPlayerState s, {AudioPlayerError? err}) {
    if (_disposed) return;
    _state = s;
    _error = err;
    notifyListeners();
  }

  // ── play() ────────────────────────────────────────────────────
  // `assetPath` peut être :
  //   • Un chemin asset local  (ex: "assets/audio/alafasy/001_001.mp3")
  //   • Une URL CDN http(s)    (ex: "https://everyayah.com/…")
  //     → LockCachingAudioSource : téléchargement + mise en cache automatique.
  //       Dès la 2e écoute, l'audio est disponible hors-ligne.
  @override
  Future<void> play(String assetPath, double speed, {bool repeat = false}) async {
    await stop();
    _setState(AudioPlayerState.loading);

    final bool isCdn = assetPath.startsWith('http');
    // CDN : timeout plus long (buffering initial réseau)
    final Duration timeout =
        isCdn ? const Duration(seconds: 30) : const Duration(seconds: 10);

    try {
      if (isCdn) {
        // Streaming CDN avec cache local automatique.
        // LockCachingAudioSource met en cache après le premier téléchargement :
        // les écoutes suivantes sont offline-friendly.
        await _player
            .setAudioSource(LockCachingAudioSource(Uri.parse(assetPath)))
            .timeout(timeout);
      } else {
        // Asset local bundlé dans l'APK/IPA.
        await _player
            .setAsset(assetPath)
            .timeout(timeout);
      }

      await _player.setLoopMode(repeat ? LoopMode.one : LoopMode.off);
      await _player.setSpeed(speed);

      // Listener de complétion + erreurs stream.
      if (!repeat) {
        _completionSub = _player.playerStateStream.listen(
          (s) {
            if (s.processingState == ProcessingState.completed) {
              _cancelSub();
              _setState(AudioPlayerState.completed);
              onCompleted?.call();
            }
          },
          onError: (e) {
            _cancelSub();
            _setState(
              AudioPlayerState.error,
              err: AudioPlayerError(message: 'Erreur pendant la lecture', cause: e),
            );
          },
        );
      }

      // Optimistic : passe à "playing" avant le await — l'UI doit
      // afficher la lecture dès que just_audio accepte la commande.
      _setState(AudioPlayerState.playing);

      // play() bloque jusqu'à fin naturelle ou stop()/pause() :
      // la complétion est gérée par le stream listener ci-dessus.
      await _player.play();
    } on TimeoutException {
      _cancelSub();
      _setState(
        AudioPlayerState.error,
        err: AudioPlayerError(
          message: isCdn
              ? 'Délai dépassé — vérifie ta connexion internet'
              : 'Délai dépassé (10s) — audio introuvable ?',
        ),
      );
    } catch (e) {
      _cancelSub();
      _setState(
        AudioPlayerState.error,
        err: AudioPlayerError(message: 'Erreur de lecture native', cause: e),
      );
    }
  }

  // ── pause() ───────────────────────────────────────────────────
  @override
  Future<void> pause() async {
    if (_state == AudioPlayerState.playing) {
      await _player.pause();
      _setState(AudioPlayerState.paused);
    }
  }

  // ── resume() ─────────────────────────────────────────────────
  @override
  Future<void> resume() async {
    if (_state == AudioPlayerState.paused) {
      try {
        _setState(AudioPlayerState.playing);
        await _player.play();
      } catch (e) {
        _setState(
          AudioPlayerState.error,
          err: AudioPlayerError(message: 'Impossible de reprendre', cause: e),
        );
      }
    }
  }

  // ── stop() ────────────────────────────────────────────────────
  @override
  Future<void> stop() async {
    _cancelSub();
    try { await _player.stop(); } catch (_) {}
    _setState(AudioPlayerState.idle);
  }

  // ── setSpeed() / setRepeat() ──────────────────────────────────
  @override
  void setSpeed(double speed) { _player.setSpeed(speed); }

  @override
  void setRepeat(bool repeat) {
    _player.setLoopMode(repeat ? LoopMode.one : LoopMode.off);
  }

  // ── Privé ─────────────────────────────────────────────────────
  void _cancelSub() {
    _completionSub?.cancel();
    _completionSub = null;
  }

  // ── dispose() ────────────────────────────────────────────────
  @override
  void dispose() {
    _disposed = true;
    _cancelSub();
    _player.dispose();
    super.dispose();
  }
}
