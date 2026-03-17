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
  //
  // Refactorisé : on await _audio!.play() directement.
  //   • La Promise JS est bien catchée → plus de rejets silencieux.
  //   • _errorSub couvre uniquement les erreurs PENDANT la lecture.
  //   • Le timeout couvre les cas où play() ne résout jamais (réseau lent).
  @override
  Future<void> play(String url, double speed, {bool repeat = false}) async {
    _cleanup();
    if (_disposed) return;
    _setState(AudioPlayerState.loading);

    _audio = html.AudioElement(url)
      ..loop         = repeat
      ..playbackRate = speed
      ..preload      = 'auto';

    // ── Écoute erreur PENDANT la lecture ──────────────────────
    // Ce listener ne s'active qu'après que play() a résolu (état playing).
    _errorSub = _audio!.onError.listen((_) {
      if (_disposed) return;
      if (_state == AudioPlayerState.playing ||
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
        if (_disposed) return;
        _cleanup();
        _setState(AudioPlayerState.completed);
        onCompleted?.call();
      });
    }

    // ── Timeout 8 s — garantit la sortie du spinner ───────────
    _timeoutTimer = Timer(const Duration(seconds: 8), () {
      if (_disposed) return;
      if (_state == AudioPlayerState.loading) {
        _cleanup();
        _setState(
          AudioPlayerState.error,
          err: const AudioPlayerError(message: 'Délai dépassé — connexion lente ?'),
        );
      }
    });

    // ── Appel play() avec await ───────────────────────────────
    // IMPORTANT : await intercepte les rejets de la Promise JS.
    // Sans await, un rejet (404, autoplay bloqué) disparaît silencieusement
    // et l'état reste bloqué sur "error" indéfiniment.
    try {
      await _audio!.play();
      // La Promise a résolu → la lecture a démarré.
      _timeoutTimer?.cancel(); _timeoutTimer = null;
      if (!_disposed) _setState(AudioPlayerState.playing);
    } catch (e) {
      // Rejet Promise : 404, autoplay bloqué, erreur réseau, etc.
      _cleanup();
      _setState(
        AudioPlayerState.error,
        err: AudioPlayerError(message: 'Lecture bloquée par le navigateur', cause: e),
      );
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
