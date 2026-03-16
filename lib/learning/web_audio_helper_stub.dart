// Stub non-web — jamais utilisé à l'exécution (guard kIsWeb dans le service).
class WebAudioHelper {
  Future<bool> playUrl(String url, double speed, bool loop) async => false;
  void listenEnd(void Function() onEnd) {}
  Future<void> pause() async {}
  Future<void> resume() async {}
  Future<void> stop() async {}
  void setSpeed(double speed) {}
  void setLoop(bool loop) {}
}
