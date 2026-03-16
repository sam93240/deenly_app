// abstract_audio_player.dart
// Interface commune web + native.
// L'UI écoute UNIQUEMENT via ChangeNotifier — jamais de logique d'état dispersée.

import 'package:flutter/foundation.dart';
import 'audio_player_state.dart';

abstract class AbstractAudioPlayer extends ChangeNotifier {
  // ── État observable ────────────────────────────────────────────
  AudioPlayerState  get playerState;
  AudioPlayerError? get error;

  bool get isIdle      => playerState == AudioPlayerState.idle;
  bool get isLoading   => playerState == AudioPlayerState.loading;
  bool get isPlaying   => playerState == AudioPlayerState.playing;
  bool get isPaused    => playerState == AudioPlayerState.paused;
  bool get isCompleted => playerState == AudioPlayerState.completed;
  bool get hasError    => playerState == AudioPlayerState.error;

  // ── Callback fin de lecture ───────────────────────────────────
  // Déclenché quand la lecture se termine naturellement (pas sur stop/error).
  VoidCallback? onCompleted;

  // ── API commune ───────────────────────────────────────────────
  //
  // [url]    : chemin complet servi par le serveur (web) ou nom d'asset (native)
  // [speed]  : vitesse (0.5 – 1.0 – 2.0…)
  // [repeat] : boucle infinie si true
  //
  // Garanties :
  //   • playerState passe à loading AVANT le premier await
  //   • playerState passe à playing/error dans les 5 secondes
  //   • playerState ne reste JAMAIS bloqué à loading
  Future<void> play(String url, double speed, {bool repeat = false});
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();

  // Changements à la volée — pas besoin d'await, effet immédiat.
  void setSpeed(double speed);
  void setRepeat(bool repeat);

  @override
  void dispose();
}
