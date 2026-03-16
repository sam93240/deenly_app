// audio_verse_service.dart
// Service audio offline – lecture verset par verset.
//
// Architecture :
//   AudioVerseService  (ChangeNotifier)
//     └── AbstractAudioPlayer
//           ├── WebAudioPlayerImpl   (dart:html)   ← web
//           └── NativeAudioPlayerImpl (just_audio) ← iOS / Android
//
// L'UI écoute UNIQUEMENT AudioVerseService.
// L'état du spinner provient de AbstractAudioPlayer.isLoading — jamais de
// variables booléennes dispersées.

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'abstract_audio_player.dart';
import 'audio_player_factory.dart';   // createAudioPlayer() — conditionnel
import 'audio_player_state.dart';

export 'audio_player_state.dart';     // re-export pour les widgets

// ── Utilitaire existence fichier ──────────────────────────────────
// Sur web  : toujours true (les assets sont packagés dans le build web,
//            vérifier via rootBundle téléchargerait tout le fichier audio).
// Sur native: vérifie via rootBundle (lecture locale depuis les assets).
Future<bool> audioFileExists(
    AudioConfig config, int surahNumber, int ayahNumber) async {
  if (kIsWeb) return true;
  try {
    final data = await rootBundle.load(config.pathFor(surahNumber, ayahNumber));
    return data.lengthInBytes > 0;
  } catch (_) {
    return false;
  }
}

// ══════════════════════════════════════════════════════════════════
// AudioConfig
// ══════════════════════════════════════════════════════════════════

class AudioConfig {
  final String reciter;
  final String basePath;

  const AudioConfig({
    required this.reciter,
    this.basePath = 'assets/audio',
  });

  factory AudioConfig.learning() => const AudioConfig(reciter: 'alafasy');
  factory AudioConfig.quran({String reciter = 'alafasy'}) =>
      AudioConfig(reciter: reciter);

  /// Chemin relatif de l'asset : assets/audio/alafasy/001_001.mp3
  String pathFor(int surahNumber, int ayahNumber) =>
      '$basePath/$reciter/'
      '${surahNumber.toString().padLeft(3, '0')}_'
      '${ayahNumber.toString().padLeft(3, '0')}.mp3';

  /// URL complète pour le web : /assets/assets/audio/alafasy/001_001.mp3
  /// (Flutter web sert les assets sous /assets/<chemin-pubspec>)
  String webUrlFor(int surahNumber, int ayahNumber) =>
      '/assets/${pathFor(surahNumber, ayahNumber)}';
}

// ══════════════════════════════════════════════════════════════════
// AudioSpeed
// ══════════════════════════════════════════════════════════════════

enum AudioSpeed { half, threeQuarters, normal }

extension AudioSpeedExt on AudioSpeed {
  double get value {
    switch (this) {
      case AudioSpeed.half:          return 0.5;
      case AudioSpeed.threeQuarters: return 0.75;
      case AudioSpeed.normal:        return 1.0;
    }
  }
  String get label {
    switch (this) {
      case AudioSpeed.half:          return '0.5×';
      case AudioSpeed.threeQuarters: return '0.75×';
      case AudioSpeed.normal:        return '1×';
    }
  }
}

// ══════════════════════════════════════════════════════════════════
// AudioVerseService
// ══════════════════════════════════════════════════════════════════

class AudioVerseService extends ChangeNotifier {
  AudioVerseService._() {
    // Propagage les changements d'état du player vers les widgets.
    _player.addListener(_onPlayerChanged);
  }

  static final AudioVerseService instance = AudioVerseService._();

  // ── Player (web ou native, selon la plateforme) ───────────────
  final AbstractAudioPlayer _player = createAudioPlayer();

  // ── Contexte de lecture ───────────────────────────────────────
  int?         _currentSurah;
  int?         _currentAyah;
  AudioConfig? _currentConfig;
  AudioSpeed   _speed  = AudioSpeed.normal;
  bool         _repeat = false;

  // ── API état (délèguent au player) ───────────────────────────
  // L'UI n'accède jamais directement au player.
  AudioPlayerState  get playerState   => _player.playerState;
  bool              get isLoading     => _player.isLoading;
  bool              get isPlaying     => _player.isPlaying;
  bool              get isPaused      => _player.isPaused;
  bool              get hasError      => _player.hasError;
  /// Message d'erreur prêt à être affiché dans l'UI.
  String?           get errorMessage  => _player.error?.message;

  int?         get currentSurah  => _currentSurah;
  int?         get currentAyah   => _currentAyah;
  AudioSpeed   get speed         => _speed;

  // ── playAyah ─────────────────────────────────────────────────
  Future<void> playAyah({
    required AudioConfig  config,
    required int          surahNumber,
    required int          ayahNumber,
    AudioSpeed            speed       = AudioSpeed.normal,
    bool                  repeat      = false,
    VoidCallback?         onCompleted,
  }) async {
    _currentConfig   = config;
    _currentSurah    = surahNumber;
    _currentAyah     = ayahNumber;
    _speed           = speed;
    _repeat          = repeat;
    _player.onCompleted = onCompleted;

    final url = kIsWeb
        ? config.webUrlFor(surahNumber, ayahNumber)
        : config.pathFor(surahNumber, ayahNumber);

    await _player.play(url, speed.value, repeat: repeat);
  }

  // ── togglePlayPause ──────────────────────────────────────────
  Future<void> togglePlayPause({
    required AudioConfig  config,
    required int          surahNumber,
    required int          ayahNumber,
    AudioSpeed            speed       = AudioSpeed.normal,
    bool                  repeat      = false,
    VoidCallback?         onCompleted,
  }) async {
    final isSame = _currentSurah == surahNumber && _currentAyah == ayahNumber;

    if (isSame && _player.isPlaying) {
      await pause();
    } else if (isSame && _player.isPaused) {
      if (_speed != speed) { _speed = speed; _player.setSpeed(speed.value); }
      if (_repeat != repeat) { _repeat = repeat; _player.setRepeat(repeat); }
      await resume();
    } else {
      await playAyah(
        config:      config,
        surahNumber: surahNumber,
        ayahNumber:  ayahNumber,
        speed:       speed,
        repeat:      repeat,
        onCompleted: onCompleted,
      );
    }
  }

  // ── Contrôles ────────────────────────────────────────────────
  Future<void> pause()  async => _player.pause();
  Future<void> resume() async => _player.resume();
  Future<void> stop()   async => _player.stop();

  Future<void> setSpeed(AudioSpeed speed) async {
    _speed = speed;
    _player.setSpeed(speed.value);
    notifyListeners();
  }

  Future<void> setRepeat(bool repeat) async {
    _repeat = repeat;
    _player.setRepeat(repeat);
    notifyListeners();
  }

  // ── Privé ─────────────────────────────────────────────────────
  void _onPlayerChanged() => notifyListeners();

  @override
  void dispose() {
    _player.removeListener(_onPlayerChanged);
    _player.dispose();
    super.dispose();
  }
}
