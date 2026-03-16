// Implémentation WEB uniquement — utilise dart:html AudioElement
// directement pour éviter les bugs de just_audio_web avec l'autoplay.
import 'dart:html' as html;
import 'dart:async';

class WebAudioHelper {
  html.AudioElement? _audio;
  StreamSubscription? _endedSub;

  /// Lance la lecture. Retourne true si succès.
  Future<bool> playUrl(String url, double speed, bool loop) async {
    await stop();
    _audio = html.AudioElement(url)
      ..loop = loop
      ..playbackRate = speed;
    try {
      await _audio!.play();
      return true;
    } catch (_) {
      _audio = null;
      return false;
    }
  }

  /// Appeler après playUrl() pour être notifié de la fin.
  void listenEnd(void Function() onEnd) {
    _endedSub?.cancel();
    _endedSub = null;
    if (_audio != null && !(_audio!.loop)) {
      _endedSub = _audio!.onEnded.listen((_) => onEnd());
    }
  }

  Future<void> pause() async => _audio?.pause();

  Future<void> resume() async {
    try {
      await _audio?.play();
    } catch (_) {}
  }

  Future<void> stop() async {
    await _endedSub?.cancel();
    _endedSub = null;
    _audio?.pause();
    _audio = null;
  }

  void setSpeed(double speed) {
    if (_audio != null) _audio!.playbackRate = speed;
  }

  void setLoop(bool loop) {
    if (_audio != null) _audio!.loop = loop;
  }
}
