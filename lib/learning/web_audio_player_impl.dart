// web_audio_player_impl.dart
// Implémentation WEB — dart:html AudioElement.
//
// Pourquoi pas just_audio_web ?
//   just_audio_web v0.4.x appelle _setupAudioElement() qui attend
//   l'événement "canPlayThrough" via un Completer interne. Sur GitHub Pages
//   (et certains CDN), cet événement ne se déclenche jamais → spinner bloqué
//   indéfiniment. dart:html AudioElement.play() déclenche "onPlay" dès que la
//   lecture commence, ce qui est fiable et immédiat.

import 'dart:async';
import 'dart:html' as html;

import 'abstract_audio_player.dart';
import 'audio_player_state.dart';

class WebAudioPlayerImpl extends AbstractAudioPlayer {
  html.AudioElement?    _audio;
  StreamSubscription?   _endedSub;
  StreamSubscription?   _errorSub;
  StreamSubscription?   _playSub;
  Timer?                _timeoutTimer;

  AudioPlayerState  _state = AudioPlayerState.idle;
  AudioPlayerError? _error;

  @override AudioPlayerState  get playerState => _state;
  @override AudioPlayerError? get error        => _error;

  // ── Transition d'état ─────────────────────────────────────────
  void _setState(AudioPlayerState s, {AudioPlayerError? err}) {
    _state = s;
    _error = err;
    notifyListeners();
  }

  // ── play() ────────────────────────────────────────────────────
  @override
  Future<void> play(String url, double speed, {bool repeat = false}) async {
    // 1. Nettoyer le player précédent (pas d'await lourd ici)
    _cleanup();
    _setState(AudioPlayerState.loading);

    // 2. Créer l'élément audio
    _audio = html.AudioElement(url)
      ..loop           = repeat
      ..playbackRate   = speed
      ..preload        = 'auto';

    // 3. Completer qui se résout sur "play started" ou rejette sur erreur
    final completer = Completer<void>();

    // Écoute "lecture démarrée"
    _playSub = _audio!.onPlay.listen((_) {
      if (!completer.isCompleted) completer.complete();
    });

    // Écoute erreur de chargement/décodage
    _errorSub = _audio!.onError.listen((_) {
      if (!completer.isCompleted) {
        completer.completeError(
          AudioPlayerError(message: 'Fichier audio introuvable ou corrompu'),
        );
      }
    });

    // Écoute fin naturelle (si pas repeat)
    if (!repeat) {
      _endedSub = _audio!.onEnded.listen((_) {
        _cleanup();
        _setState(AudioPlayerState.completed);
        onCompleted?.call();
      });
    }

    // 4. Timeout 5 s — le spinner ne restera JAMAIS bloqué
    _timeoutTimer = Timer(const Duration(seconds: 5), () {
      if (!completer.isCompleted) {
        completer.completeError(
          AudioPlayerError(message: 'Délai dépassé — connexion lente ?'),
        );
      }
    });

    // 5. Appel play() — pas d'await entre le geste utilisateur et ici
    try {
      _audio!.play();
    } catch (e) {
      _cleanup();
      _setState(
        AudioPlayerState.error,
        err: AudioPlayerError(
          message: 'Lecture bloquée par le navigateur',
          cause: e,
        ),
      );
      return;
    }

    // 6. Attendre que la lecture démarre (ou erreur/timeout)
    try {
      await completer.future;
      _timeoutTimer?.cancel();
      _timeoutTimer = null;
      _playSub?.cancel();
      _playSub = null;
      _setState(AudioPlayerState.playing);
    } catch (e) {
      _cleanup();
      _audio?.pause();
      _audio = null;
      final err = e is AudioPlayerError
          ? e
          : AudioPlayerError(message: 'Erreur de lecture', cause: e);
      _setState(AudioPlayerState.error, err: err);
    }
  }

  // ── pause() ───────────────────────────────────────────────────
  @override
  Future<void> pause() async {
    if (_state == AudioPlayerState.playing) {
      _audio?.pause();
      _setState(AudioPlayerState.paused);
    }
  }

  // ── resume() ─────────────────────────────────────────────────
  @override
  Future<void> resume() async {
    if (_state == AudioPlayerState.paused && _audio != null) {
      try {
        _audio!.play();
        _setState(AudioPlayerState.playing);
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
    _cleanup();
    _setState(AudioPlayerState.idle);
  }

  // ── setSpeed() / setRepeat() ──────────────────────────────────
  @override void setSpeed(double speed)  { _audio?.playbackRate = speed; }
  @override void setRepeat(bool repeat)  { _audio?.loop = repeat; }

  // ── Privé ─────────────────────────────────────────────────────
  void _cleanup() {
    _timeoutTimer?.cancel(); _timeoutTimer = null;
    _playSub?.cancel();      _playSub      = null;
    _endedSub?.cancel();     _endedSub     = null;
    _errorSub?.cancel();     _errorSub     = null;
    _audio?.pause();
    _audio = null;
  }

  @override
  void dispose() {
    _cleanup();
    super.dispose();
  }
}
