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
  final _svc       = AudioVerseService.instance;
  AudioSpeed _speed = AudioSpeed.normal;
  bool _repeat      = false;
  bool _fileExists  = false;
  bool _checked     = false;

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
      _checked = false;
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

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: _fileExists
                ? LNColors.blueLight
                : LNColors.border.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _fileExists
                  ? LNColors.blue.withValues(alpha: 0.3)
                  : LNColors.border,
            ),
          ),
          child: Row(
            children: [
              // ── Bouton play / pause ──────────────────────────
              GestureDetector(
                // Désactivé si : pas de fichier OU chargement en cours
                onTap: (_fileExists && !loading) ? _toggle : null,
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: _fileExists ? LNColors.blue : LNColors.border,
                    shape: BoxShape.circle,
                  ),
                  child: loading
                      ? const Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : Icon(
                          playing
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
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
                      _fileExists
                          ? (playing
                              ? _s('Lecture en cours…', 'Playing…')
                              : _s('Écouter', 'Listen'))
                          : _s('Audio bientôt disponible', 'Audio coming soon'),
                      style: TextStyle(
                        color: _fileExists ? LNColors.blue : LNColors.textLight,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Mishary Alafasy',
                      style: TextStyle(
                          color: LNColors.textLight, fontSize: 11),
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
