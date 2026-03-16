// audio_player_factory_native.dart — utilisé sur Android / iOS / macOS
import 'abstract_audio_player.dart';
import 'native_audio_player_impl.dart';

AbstractAudioPlayer createAudioPlayer() => NativeAudioPlayerImpl();
