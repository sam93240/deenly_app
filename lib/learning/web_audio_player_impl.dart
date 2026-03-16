// web_audio_player_impl.dart
// Implémentation WEB — dart:html AudioElement.
//
// Pourquoi pas just_audio_web ?
//   just_audio_web v0.4.x appelle _setupAudioElement() qui attend
//   l'événement "canPlayThrough" via un Completer interne. Sur GitHub Pages
//   (et certains CDN), cet événement ne se déclenche jamais → spinner bloqué
//   indéfiniment. dart:html AudioElement.play() déclenche "onPlay" dès que la
//   lecture commence, ce qui est fiable et immédiat.
//
// Note : dart:html est un correctif rapide. Migration future :
//   package:web + dart:js_interop (Dart 3.x recommandé).

import 'dart:async';
import 'dart:html' as html;

import 'abstract_audio_player.dart';
import 'audio_player_state.dart';

class WebAudioPlayerImpl extends AbstractAudioPlayer {
  html.AudioElement?  _audio;
  StreamSubscription? _endedSub;
  StreamSubscription? _errorSub;
  StreamSubscription? _playSub;
  Timer?              _timeoutTimer;
  bool                _disposed = false;

  AudioPlayerState  _state = AudioPlayerState.idle;
  AudioPlayerError? _error;

  @override AudioPlayerState  get playerState => _state;
  @override AudioPlayerError? get error        => _error;

  // ── Transition d'état ─────────────────────────────────────────
  // Guard _disposed : empêche notifyListeners() après dispose().
  void _setState(AudioPlayerState s, {AudioPlayerError? err}) {
    if (_disposed) return;
    _state = s;
    _error = err;
    notifyListeners();
  }

  // ── play() ────────────────────────────────────────────────────
  @override
  Future<void> play(String url, double speed, {bool repeat = false}) async {
    // Nettoie le player précédent SANS await lourd — synchrone.
    _cleanup();
    _setState(AudioPlayerState.loading);

    _audio = html.AudioElement(url)
      ..loop         = repeat
      ..playbackRate = speed
      ..preload      = 'auto';

    // Completer résolu sur "lecture démarrée" ou rejeté sur erreur/timeout.
    final completer = Completer<void>();

    // ── Écoute "lecture démarrée" ─────────────────────────────
    _playSub = _audio!.onPlay.listen((_) {
      if (!completer.isCompleted) completer.complete();
    });

    // ── Écoute erreur HTML audio ──────────────────────────────
    // Deux phases :
    //   • Pendant le chargement (completer ouvert)  → rejette le completer.
    //   • Pendant la lecture (completer déjà résolu) → set état error direct.
    _errorSub = _audio!.onError.listen((_) {
      if (!completer.isCompleted) {
        completer.completeError(
          const AudioPlayerError(message: 'Fichier audio introuvable ou corrompu'),
        );
      } else if (_state == AudioPlayerState.playing ||
                 _state == AudioPlayerState.paused) {
        _cleanup();
        _setState(
          AudioPlayerState.error,
          err: const AudioPlayerError(message: 'Erreur audio pendant la lecture'),
        );
      }
    });

    // ── Écoute fin naturelle ──────────────────────────────────
    if (!repeat) {
      _endedSub = _audio!.onEnded.listen((_) {
        _cleanup();
        _setState(AudioPlayerState.completed);
        onCompleted?.call();
      });
    }

    // ── Timeout 5 s — garantit la sortie du spinner ───────────
    _timeoutTimer = Timer(const Duration(seconds: 5), () {
      if (!completer.isCompleted) {
        completer.completeError(
          const AudioPlayerError(message: 'Délai dépassé — connexion lente ?'),
        );
      }
    });

    // ── Appel play() ─────────────────────────────────────────
    // Aucun await entre ici et le geste utilisateur → contexte autoplay conservé.
    try {
      _audio!.play();
    } catch (e) {
      _cleanup();
      _setState(
        AudioPlayerState.error,
        err: AudioPlayerError(message: 'Lecture bloquée par le navigateur', cause: e),
      );
      return;
    }

    // ── Attendre démarrage (ou erreur / timeout) ──────────────
    try {
      await completer.future;
      // Succès : annuler uniquement les subs de démarrage.
      // _errorSub et _endedSub restent actifs pendant la lecture.
      _timeoutTimer?.cancel(); _timeoutTimer = null;
      _playSub?.cancel();      _playSub      = null;
      _setState(AudioPlayerState.playing);
    } catch (e) {
      // Erreur ou timeout : nettoyage complet.
      _cleanup();
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
  @override void setSpeed(double speed) { _audio?.playbackRate = speed; }
  @override void setRepeat(bool repeat) { _audio?.loop         = repeat; }

  // ── Nettoyage complet de toutes les ressources ────────────────
  // Annule : timer, tous les subs, pause et null l'AudioElement.
  void _cleanup() {
    _timeoutTimer?.cancel(); _timeoutTimer = null;
    _playSub?.cancel();      _playSub      = null;
    _endedSub?.cancel();     _endedSub     = null;
    _errorSub?.cancel();     _errorSub     = null;
    _audio?.pause();
    _audio?.src = '';   // libère la ressource réseau (buffer + download)
    _audio = null;
  }

  // ── dispose() ────────────────────────────────────────────────
  // _disposed bloque tout setState() ultérieur (évite notifyListeners
  // sur un ChangeNotifier déjà disposé).
  @override
  void dispose() {
    _disposed = true;
    _cleanup();
    super.dispose();
  }
}
