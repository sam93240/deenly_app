// audio_verse_widget.dart
// Widget réutilisable — lecteur audio verset par verset (offline)
//
// Utilisation mode apprentissage :
//   AudioVerseWidget(surahNumber: v.surahNumber, ayahNumber: v.numero)
//
// Utilisation mode Quran :
//   AudioVerseWidget(
//     surahNumber: 2, ayahNumber: 255,
//     config: AudioConfig.quran(),
//   )

import 'package:flutter/material.dart';
import 'audio_verse_service.dart';
import 'learning_colors.dart';
import '../app_locale.dart';

String _s(String fr, String en) => AppLocale().isFrench ? fr : en;

// ══════════════════════════════════════════════════════════════════
// AudioVerseWidget
// ══════════════════════════════════════════════════════════════════

class AudioVerseWidget extends StatefulWidget {
  final int surahNumber;
  final int ayahNumber;
  final AudioConfig config;
  final VoidCallback? onCompleted;

  const AudioVerseWidget({
    super.key,
    required this.surahNumber,
    required this.ayahNumber,
    this.config = const AudioConfig(reciter: 'alafasy'),
    this.onCompleted,
  });

  @override
  State<AudioVerseWidget> createState() => _AudioVerseWidgetState();
}

class _AudioVerseWidgetState extends State<AudioVerseWidget> {
  final _svc        = AudioVerseService.instance;
  AudioSpeed _speed = AudioSpeed.normal;
  bool _repeat      = false;
  bool _fileExists  = false;
  bool _checked     = false;
  // Sur web, audioFileExists() retourne toujours true.
  // On utilise _errorCount pour détecter les fichiers réellement manquants :
  //   • 1er essai → on affiche quand même le bouton retry
  //   • 2e erreur → on bascule _fileExists = false (audio non disponible)
  int _errorCount   = 0;

  @override
  void initState() {
    super.initState();
    _checkFile();
  }

  @override
  void didUpdateWidget(AudioVerseWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.surahNumber != widget.surahNumber ||
        oldWidget.ayahNumber  != widget.ayahNumber) {
      _checked    = false;
      _errorCount = 0;
      _checkFile();
    }
  }

  Future<void> _checkFile() async {
    final exists = await audioFileExists(
        widget.config, widget.surahNumber, widget.ayahNumber);
    if (mounted) setState(() { _fileExists = exists; _checked = true; });
  }

  bool get _isThisAyah =>
      _svc.currentSurah == widget.surahNumber &&
      _svc.currentAyah  == widget.ayahNumber;

  // Lance/pause — ne bloque pas : l'UI se met à jour via ListenableBuilder
  void _toggle() {
    _svc.togglePlayPause(
      config:      widget.config,
      surahNumber: widget.surahNumber,
      ayahNumber:  widget.ayahNumber,
      speed:       _speed,
      repeat:      _repeat,
      onCompleted: widget.onCompleted,
    );
  }

  // Appelé quand une erreur est détectée pour CE verset.
  // Au 2e échec consécutif, on marque le fichier comme indisponible.
  void _onError() {
    if (!mounted) return;
    setState(() {
      _errorCount++;
      if (_errorCount >= 2) _fileExists = false; // plus de retry
    });
  }

  Future<void> _changeSpeed(AudioSpeed speed) async {
    setState(() => _speed = speed);
    if (_isThisAyah && _svc.isPlaying) {
      await _svc.setSpeed(speed);
    }
  }

  Future<void> _toggleRepeat() async {
    final next = !_repeat;
    setState(() => _repeat = next);
    if (_isThisAyah && (_svc.isPlaying || _svc.isPaused)) {
      await _svc.setRepeat(next);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_checked) return const SizedBox(height: 52);

    // ListenableBuilder reconstruit automatiquement quand le service
    // notifie un changement (play, pause, stop, loading, speed…)
    return ListenableBuilder(
      listenable: _svc,
      builder: (context, _) {
        final playing = _isThisAyah && _svc.isPlaying;
        final loading = _isThisAyah && _svc.isLoading;
        final error   = _isThisAyah && _svc.hasError;
        final errMsg  = error ? (_svc.errorMessage ?? _s('Erreur audio', 'Audio error')) : null;

        // Détecte les fichiers manquants sur web après 2 échecs
        if (error && _errorCount < 2) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _onError());
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: error
                ? Colors.red.shade50
                : (_fileExists
                    ? LNColors.blueLight
                    : LNColors.border.withValues(alpha: 0.25)),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: error
                  ? Colors.red.shade200
                  : (_fileExists
                      ? LNColors.blue.withValues(alpha: 0.3)
                      : LNColors.border),
            ),
          ),
          child: Row(
            children: [
              // ── Bouton play / pause / error ───────────────────
              GestureDetector(
                // Désactivé si : pas de fichier OU chargement en cours
                onTap: (_fileExists && !loading) ? _toggle : null,
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: error
                        ? Colors.red.shade400
                        : (_fileExists ? LNColors.blue : LNColors.border),
                    shape: BoxShape.circle,
                  ),
                  child: loading
                      ? const Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : Icon(
                          error
                              ? Icons.refresh_rounded
                              : (playing
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded),
                          color: Colors.white,
                          size: 26,
                        ),
                ),
              ),
              const SizedBox(width: 10),

              // ── Label ────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      error
                          ? errMsg!
                          : (_fileExists
                              ? (playing
                                  ? _s('Lecture en cours…', 'Playing…')
                                  : _s('Écouter', 'Listen'))
                              : _s('Audio bientôt disponible',
                                  'Audio coming soon')),
                      style: TextStyle(
                        color: error
                            ? Colors.red.shade700
                            : (_fileExists ? LNColors.blue : LNColors.textLight),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      error
                          ? _s('Appuyer pour réessayer', 'Tap to retry')
                          : 'Mishary Alafasy',
                      style: TextStyle(
                          color: error
                              ? Colors.red.shade400
                              : LNColors.textLight,
                          fontSize: 11),
                    ),
                  ],
                ),
              ),

              // ── Sélecteur de vitesse ─────────────────────────
              if (_fileExists)
                _SpeedSelector(
                  current: _speed,
                  onChanged: _changeSpeed,
                ),

              // ── Toggle repeat ────────────────────────────────
              if (_fileExists) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: _toggleRepeat,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _repeat ? LNColors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _repeat ? LNColors.blue : LNColors.border,
                      ),
                    ),
                    child: Icon(
                      Icons.repeat_rounded,
                      size: 16,
                      color: _repeat ? Colors.white : LNColors.textLight,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// _SpeedSelector — 0.5× / 0.75× / 1×
// ══════════════════════════════════════════════════════════════════

class _SpeedSelector extends StatelessWidget {
  final AudioSpeed current;
  final ValueChanged<AudioSpeed> onChanged;

  const _SpeedSelector({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: AudioSpeed.values.map((speed) {
        final selected = speed == current;
        return GestureDetector(
          onTap: () => onChanged(speed),
          child: Container(
            margin: const EdgeInsets.only(left: 4),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            decoration: BoxDecoration(
              color: selected ? LNColors.blue : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected ? LNColors.blue : LNColors.border,
              ),
            ),
            child: Text(
              speed.label,
              style: TextStyle(
                color: selected ? Colors.white : LNColors.textLight,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
