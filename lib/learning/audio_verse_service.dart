// audio_verse_service.dart
// Service audio offline – lecture verset par verset avec just_audio
//
// Architecture réutilisable :
//   • Mode apprentissage  → AudioConfig.learning()
//   • Mode Quran          → AudioConfig.quran(reciter: '...')

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

// ══════════════════════════════════════════════════════════════════
// AudioConfig — décrit où chercher les fichiers audio
// ══════════════════════════════════════════════════════════════════

class AudioConfig {
  final String reciter;
  final String basePath;

  const AudioConfig({
    required this.reciter,
    this.basePath = 'assets/audio',
  });

  /// Mode apprentissage – Mishary Alafasy, sourates offline
  factory AudioConfig.learning() => const AudioConfig(reciter: 'alafasy');

  /// Mode Quran (mêmes assets, même réciteur)
  factory AudioConfig.quran({String reciter = 'alafasy'}) =>
      AudioConfig(reciter: reciter);

  /// Chemin asset : assets/audio/alafasy/001_001.mp3
  String pathFor(int surahNumber, int ayahNumber) =>
      '$basePath/$reciter/'
      '${surahNumber.toString().padLeft(3, '0')}_'
      '${ayahNumber.toString().padLeft(3, '0')}.mp3';
}

// ══════════════════════════════════════════════════════════════════
// AudioSpeed — vitesses de lecture
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
// Utilitaire — vérifie si un fichier audio existe et n'est pas vide
// ══════════════════════════════════════════════════════════════════

Future<bool> audioFileExists(
    AudioConfig config, int surahNumber, int ayahNumber) async {
  try {
    final data =
        await rootBundle.load(config.pathFor(surahNumber, ayahNumber));
    return data.lengthInBytes > 0;
  } catch (_) {
    return false;
  }
}

// ══════════════════════════════════════════════════════════════════
// AudioVerseService — singleton partagé Learning + Quran
//
// Étend ChangeNotifier : les widgets reconstruisent automatiquement
// à chaque changement d'état (play/pause/stop/speed/loading).
// ══════════════════════════════════════════════════════════════════

class AudioVerseService extends ChangeNotifier {
  AudioVerseService._();
  static final AudioVerseService instance = AudioVerseService._();

  final AudioPlayer _player = AudioPlayer();

  bool         _isPlaying = false;
  bool         _isLoading = false;
  // _isPaused = true  → en pause mid-lecture (reprise possible)
  // _isPaused = false → arrêté ou terminé (prochain tap = nouveau départ)
  bool         _isPaused  = false;
  int?         _currentSurah;
  int?         _currentAyah;
  AudioConfig? _currentConfig;
  AudioSpeed   _speed     = AudioSpeed.normal;
  bool         _repeat    = false;

  StreamSubscription<PlayerState>? _completionSub;
  VoidCallback? _onAyahCompleted;

  bool        get isPlaying    => _isPlaying;
  bool        get isLoading    => _isLoading;
  bool        get isPaused     => _isPaused;
  int?        get currentSurah => _currentSurah;
  int?        get currentAyah  => _currentAyah;
  AudioSpeed  get speed        => _speed;

  // ── Jouer un ayah ─────────────────────────────────────────────
  Future<void> playAyah({
    required AudioConfig config,
    required int surahNumber,
    required int ayahNumber,
    AudioSpeed   speed      = AudioSpeed.normal,
    bool         repeat     = false,
    VoidCallback? onCompleted,
  }) async {
    await _cancelAndStop();

    // Sur web, pas besoin de vérifier via rootBundle (ajoute de la latence
    // et peut faire expirer le contexte de geste utilisateur).
    if (!kIsWeb) {
      final exists = await audioFileExists(config, surahNumber, ayahNumber);
      if (!exists) return;
    }

    _currentConfig   = config;
    _currentSurah    = surahNumber;
    _currentAyah     = ayahNumber;
    _speed           = speed;
    _repeat          = repeat;
    _onAyahCompleted = onCompleted;
    _isLoading       = true;
    _isPlaying       = false;
    _isPaused        = false;
    notifyListeners();

    try {
      // Sur web : setUrl() avec chemin direct évite les problèmes de
      // contexte utilisateur liés à setAsset() + rootBundle.load().
      if (kIsWeb) {
        await _player
            .setUrl('/assets/${config.pathFor(surahNumber, ayahNumber)}');
      } else {
        await _player.setAsset(config.pathFor(surahNumber, ayahNumber));
      }
      await _player.setLoopMode(repeat ? LoopMode.one : LoopMode.off);
      await _player.setSpeed(speed.value);

      _isLoading = false;
      _isPlaying = true;
      notifyListeners();

      // Écoute la fin AVANT play() pour éviter toute race condition
      if (!repeat) {
        _completionSub = _player.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed) {
            _isPlaying = false;
            _isPaused  = false;
            _cancelCompletionSub();
            notifyListeners();
            _onAyahCompleted?.call();
          }
        });
      }

      // await play() dans le try-catch pour capturer les erreurs web
      await _player.play();
    } catch (_) {
      _isLoading = false;
      _isPlaying = false;
      _isPaused  = false;
      _cancelCompletionSub();
      notifyListeners();
    }
  }

  // ── Play / Pause intelligent ──────────────────────────────────
  Future<void> togglePlayPause({
    required AudioConfig config,
    required int surahNumber,
    required int ayahNumber,
    AudioSpeed   speed      = AudioSpeed.normal,
    bool         repeat     = false,
    VoidCallback? onCompleted,
  }) async {
    final isSameAyah = _currentSurah == surahNumber &&
        _currentAyah  == ayahNumber;

    if (isSameAyah && _isPlaying) {
      // → Mettre en pause
      await pause();

    } else if (isSameAyah && _isPaused) {
      // → Reprendre depuis la pause (l'audio n'est pas terminé)
      // Applique vitesse/repeat si changés pendant la pause
      if (_speed != speed) {
        _speed = speed;
        await _player.setSpeed(speed.value);
      }
      if (repeat != _repeat) {
        _repeat = repeat;
        await _player.setLoopMode(repeat ? LoopMode.one : LoopMode.off);
      }
      await resume();

    } else {
      // → Démarrage fresh : autre verset OU audio terminé (_isPaused=false)
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

  // ── Changer la vitesse à la volée ────────────────────────────
  Future<void> setSpeed(AudioSpeed speed) async {
    _speed = speed;
    await _player.setSpeed(speed.value);
    notifyListeners();
  }

  // ── Activer / désactiver le loop à la volée ──────────────────
  Future<void> setRepeat(bool repeat) async {
    _repeat = repeat;
    await _player.setLoopMode(repeat ? LoopMode.one : LoopMode.off);
    notifyListeners();
  }

  // ── Pause ─────────────────────────────────────────────────────
  Future<void> pause() async {
    if (_isPlaying) {
      await _player.pause();
      _isPlaying = false;
      _isPaused  = true;
      notifyListeners();
    }
  }

  // ── Reprise ───────────────────────────────────────────────────
  Future<void> resume() async {
    if (_isPaused) {
      _isPlaying = true;
      _isPaused  = false;
      notifyListeners();
      unawaited(_player.play());
    }
  }

  // ── Stop complet ──────────────────────────────────────────────
  Future<void> stop() async {
    await _cancelAndStop();
    notifyListeners();
  }

  // ── Dispose ──────────────────────────────────────────────────
  @override
  Future<void> dispose() async {
    await _cancelAndStop();
    await _player.dispose();
    super.dispose();
  }

  // ── Privé ─────────────────────────────────────────────────────
  Future<void> _cancelAndStop() async {
    _cancelCompletionSub();
    _isPlaying = false;
    _isPaused  = false;
    _isLoading = false;
    await _player.stop();
  }

  void _cancelCompletionSub() {
    _completionSub?.cancel();
    _completionSub = null;
  }
}
