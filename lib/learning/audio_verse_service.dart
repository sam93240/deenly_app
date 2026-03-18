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

// ── Sourates avec audio disponible (Mishary Alafasy) ─────────────
// Toutes les 114 sourates sont disponibles :
//   • Sourates locales (bundlées) : 1, 67, 78–114
//   • Sourates CDN (streaming + cache) : tout le reste (2–66 sauf 67, 68–77)
const _kSurahsWithAudio = <int>{
  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,
  11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
  41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
  51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
  61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
  71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
  81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
  91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
  101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
  111, 112, 113, 114,
};

// ── Sourates streamées depuis everyayah.com (non bundlées) ────────
// = toutes sauf les assets locaux : 1, 67, et Juz Amma 78–114.
// Mise en cache automatique après la 1ère écoute → offline-friendly.
// CDN : https://everyayah.com/data/Alafasy_128kbps/{surah3}{ayah3}.mp3
const _kCdnSurahs = <int>{
   2,  3,  4,  5,  6,  7,  8,  9,  10,
  11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
  41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
  51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
  61, 62, 63, 64, 65, 66,     68, 69, 70,
  71, 72, 73, 74, 75, 76, 77,
};

const _kCdnBaseUrl =
    'https://everyayah.com/data/Alafasy_128kbps/';

// ── Utilitaire existence fichier ──────────────────────────────────
// Sur web   : vérifie via la liste statique (pas de requête réseau).
//             Évite d'afficher un bouton pour des fichiers absents.
// Sur native:
//   - Sourates CDN → toujours disponibles (streamées à la demande).
//   - Sourates locales → vérifie via rootBundle.
Future<bool> audioFileExists(
    AudioConfig config, int surahNumber, int ayahNumber) async {
  if (!_kSurahsWithAudio.contains(surahNumber)) return false;
  if (_kCdnSurahs.contains(surahNumber)) return true;   // CDN always available
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

  /// Retourne soit un chemin asset local, soit une URL CDN everyayah.com.
  ///
  /// • Sourates CDN (_kCdnSurahs) → URL https://everyayah.com/…
  ///   Le player détecte le préfixe "http" et utilise LockCachingAudioSource.
  /// • Autres sourates → chemin asset local : assets/audio/alafasy/001_001.mp3
  String pathFor(int surahNumber, int ayahNumber) {
    final s = surahNumber.toString().padLeft(3, '0');
    final a = ayahNumber.toString().padLeft(3, '0');
    if (_kCdnSurahs.contains(surahNumber)) {
      // everyayah.com naming: 002001.mp3 (no underscore)
      return '$_kCdnBaseUrl$s$a.mp3';
    }
    return '$basePath/$reciter/${s}_$a.mp3';
  }

  /// URL complète pour le web : /assets/assets/audio/alafasy/001_001.mp3
  /// (Flutter web sert les assets sous /assets/<chemin-pubspec>)
  /// Pour les sourates CDN, retourne directement l'URL externe.
  String webUrlFor(int surahNumber, int ayahNumber) {
    if (_kCdnSurahs.contains(surahNumber)) {
      return pathFor(surahNumber, ayahNumber);
    }
    return '/assets/${pathFor(surahNumber, ayahNumber)}';
  }
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
