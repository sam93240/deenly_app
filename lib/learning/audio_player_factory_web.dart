// audio_player_factory_web.dart — utilisé sur le web
import 'abstract_audio_player.dart';
import 'web_audio_player_impl.dart';

AbstractAudioPlayer createAudioPlayer() => WebAudioPlayerImpl();
