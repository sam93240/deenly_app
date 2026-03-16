// audio_verse_service.dart
// Service audio offline – lecture verset par verset
//
// Architecture réutilisable :
//   • Mode apprentissage  → AudioConfig.learning()
//   • Mode Quran          → AudioConfig.quran(reciter: '...')
//
// Sur WEB    : utilise dart:html AudioElement directement (fiable, autoplay OK)
// Sur NATIVE : utilise just_audio (meilleure gestion buffering hors-ligne)

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import 'web_audio_helper.dart'; // conditional export web / stub

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
// Utilitaire — vérifie si un fichier audio existe (native only)
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
// ══════════════════════════════════════════════════════════════════

class AudioVerseService extends ChangeNotifier {
  AudioVerseService._();
  static final AudioVerseService instance = AudioVerseService._();

  // ── Players selon plateforme ──────────────────────────────────
  // Web   : WebAudioHelper (dart:html)
  // Native: just_audio
  final WebAudioHelper _webPlayer = WebAudioHelper();
  final AudioPlayer    _nativePlayer = AudioPlayer();

  bool         _isPlaying = false;
  bool         _isLoading = false;
  bool         _isPaused  = false;
  int?         _currentSurah;
  int?         _currentAyah;
  AudioConfig? _currentConfig;
  AudioSpeed   _speed     = AudioSpeed.normal;
  bool         _repeat    = false;

  StreamSubscription<PlayerState>? _nativeCompletionSub;
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

    if (kIsWeb) {
      // ── WEB : dart:html AudioElement ──────────────────────────
      // play() est appelé directement sans await intermédiaires,
      // ce qui maintient le contexte de geste utilisateur.
      final url = '/assets/${config.pathFor(surahNumber, ayahNumber)}';
      final ok  = await _webPlayer.playUrl(url, speed.value, repeat);
      if (!ok) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      _isLoading = false;
      _isPlaying = true;
      notifyListeners();
      if (!repeat) {
        _webPlayer.listenEnd(() {
          _isPlaying = false;
          _isPaused  = false;
          notifyListeners();
          _onAyahCompleted?.call();
        });
      }
    } else {
      // ── NATIVE : just_audio ───────────────────────────────────
      final exists = await audioFileExists(config, surahNumber, ayahNumber);
      if (!exists) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      try {
        await _nativePlayer.setAsset(config.pathFor(surahNumber, ayahNumber));
        await _nativePlayer.setLoopMode(repeat ? LoopMode.one : LoopMode.off);
        await _nativePlayer.setSpeed(speed.value);

        _isLoading = false;
        _isPlaying = true;
        notifyListeners();

        if (!repeat) {
          _nativeCompletionSub =
              _nativePlayer.playerStateStream.listen((state) {
            if (state.processingState == ProcessingState.completed) {
              _isPlaying = false;
              _isPaused  = false;
              _cancelNativeCompletionSub();
              notifyListeners();
              _onAyahCompleted?.call();
            }
          });
        }
        await _nativePlayer.play();
      } catch (_) {
        _isLoading = false;
        _isPlaying = false;
        _isPaused  = false;
        _cancelNativeCompletionSub();
        notifyListeners();
      }
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
      await pause();
    } else if (isSameAyah && _isPaused) {
      if (_speed != speed) {
        _speed = speed;
        if (kIsWeb) {
          _webPlayer.setSpeed(speed.value);
        } else {
          await _nativePlayer.setSpeed(speed.value);
        }
      }
      if (repeat != _repeat) {
        _repeat = repeat;
        if (kIsWeb) {
          _webPlayer.setLoop(repeat);
        } else {
          await _nativePlayer.setLoopMode(
              repeat ? LoopMode.one : LoopMode.off);
        }
      }
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

  // ── Changer la vitesse à la volée ────────────────────────────
  Future<void> setSpeed(AudioSpeed speed) async {
    _speed = speed;
    if (kIsWeb) {
      _webPlayer.setSpeed(speed.value);
    } else {
      await _nativePlayer.setSpeed(speed.value);
    }
    notifyListeners();
  }

  // ── Activer / désactiver le loop à la volée ──────────────────
  Future<void> setRepeat(bool repeat) async {
    _repeat = repeat;
    if (kIsWeb) {
      _webPlayer.setLoop(repeat);
    } else {
      await _nativePlayer.setLoopMode(repeat ? LoopMode.one : LoopMode.off);
    }
    notifyListeners();
  }

  // ── Pause ─────────────────────────────────────────────────────
  Future<void> pause() async {
    if (_isPlaying) {
      if (kIsWeb) {
        await _webPlayer.pause();
      } else {
        await _nativePlayer.pause();
      }
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
      if (kIsWeb) {
        await _webPlayer.resume();
      } else {
        await _nativePlayer.play();
      }
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
    await _nativePlayer.dispose();
    super.dispose();
  }

  // ── Privé ─────────────────────────────────────────────────────
  Future<void> _cancelAndStop() async {
    _cancelNativeCompletionSub();
    _isPlaying = false;
    _isPaused  = false;
    _isLoading = false;
    if (kIsWeb) {
      await _webPlayer.stop();
    } else {
      await _nativePlayer.stop();
    }
  }

  void _cancelNativeCompletionSub() {
    _nativeCompletionSub?.cancel();
    _nativeCompletionSub = null;
  }
}
