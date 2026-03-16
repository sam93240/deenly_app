// native_audio_player_impl.dart
// Implémentation NATIVE — just_audio (Android / iOS / macOS…)

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import 'abstract_audio_player.dart';
import 'audio_player_state.dart';

class NativeAudioPlayerImpl extends AbstractAudioPlayer {
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<PlayerState>? _completionSub;

  AudioPlayerState  _state = AudioPlayerState.idle;
  AudioPlayerError? _error;

  @override AudioPlayerState  get playerState => _state;
  @override AudioPlayerError? get error        => _error;

  void _setState(AudioPlayerState s, {AudioPlayerError? err}) {
    _state = s;
    _error = err;
    notifyListeners();
  }

  // ── play() ────────────────────────────────────────────────────
  @override
  Future<void> play(String assetPath, double speed, {bool repeat = false}) async {
    await stop();
    _setState(AudioPlayerState.loading);

    // Vérifier que l'asset existe avant de lancer just_audio
    try {
      final data = await rootBundle.load(assetPath);
      if (data.lengthInBytes == 0) throw Exception('Asset vide');
    } catch (_) {
      _setState(
        AudioPlayerState.error,
        err: AudioPlayerError(message: 'Fichier audio introuvable : $assetPath'),
      );
      return;
    }

    try {
      await _player.setAsset(assetPath);
      await _player.setLoopMode(repeat ? LoopMode.one : LoopMode.off);
      await _player.setSpeed(speed);

      if (!repeat) {
        _completionSub = _player.playerStateStream.listen((s) {
          if (s.processingState == ProcessingState.completed) {
            _cancelSub();
            _setState(AudioPlayerState.completed);
            onCompleted?.call();
          }
        });
      }

      _setState(AudioPlayerState.playing);
      await _player.play();
    } catch (e) {
      _cancelSub();
      _setState(
        AudioPlayerState.error,
        err: AudioPlayerError(message: 'Erreur de lecture native', cause: e),
      );
    }
  }

  @override
  Future<void> pause() async {
    if (_state == AudioPlayerState.playing) {
      await _player.pause();
      _setState(AudioPlayerState.paused);
    }
  }

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

  @override
  Future<void> stop() async {
    _cancelSub();
    await _player.stop();
    _setState(AudioPlayerState.idle);
  }

  @override
  Future<void> setSpeed(double speed) async => _player.setSpeed(speed);

  @override
  Future<void> setRepeat(bool repeat) async =>
      _player.setLoopMode(repeat ? LoopMode.one : LoopMode.off);

  void _cancelSub() {
    _completionSub?.cancel();
    _completionSub = null;
  }

  @override
  void dispose() {
    _cancelSub();
    _player.dispose();
    super.dispose();
  }
}
