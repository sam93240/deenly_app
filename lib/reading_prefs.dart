// reading_prefs.dart
// Préférences de lecture (taille de texte) — partagées entre tous les écrans
// d'histoires (prophètes, coraniques, bonsoir).
//
// Utilisation :
//   final prefs = ReadingPrefs.of(context);
//   prefs.fontSize   // double : taille actuelle
//   prefs.increase() / prefs.decrease()

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Tailles disponibles ───────────────────────────────────────────
const List<double> kReadingSizes = [13.0, 15.0, 17.0, 20.0];
const int          _kDefaultIdx  = 1; // 15 px par défaut
const String       _kPrefKey     = 'reading_font_size_idx';

// ══════════════════════════════════════════════════════════════════
// ReadingPrefs — ChangeNotifier léger
// ══════════════════════════════════════════════════════════════════

class ReadingPrefs extends ChangeNotifier {
  static final ReadingPrefs _instance = ReadingPrefs._();
  static ReadingPrefs get instance => _instance;
  ReadingPrefs._();

  int _idx = _kDefaultIdx;

  double get fontSize  => kReadingSizes[_idx];
  bool   get canIncrease => _idx < kReadingSizes.length - 1;
  bool   get canDecrease => _idx > 0;

  /// À appeler une fois au démarrage de l'app (dans main.dart).
  Future<void> load() async {
    final sp  = await SharedPreferences.getInstance();
    final idx = sp.getInt(_kPrefKey) ?? _kDefaultIdx;
    _idx = idx.clamp(0, kReadingSizes.length - 1);
    notifyListeners();
  }

  Future<void> increase() async {
    if (!canIncrease) return;
    _idx++;
    notifyListeners();
    await _save();
  }

  Future<void> decrease() async {
    if (!canDecrease) return;
    _idx--;
    notifyListeners();
    await _save();
  }

  Future<void> _save() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(_kPrefKey, _idx);
  }
}

// ══════════════════════════════════════════════════════════════════
// ReadingToolbar — barre A− / A+ / plein écran réutilisable
// ══════════════════════════════════════════════════════════════════

class ReadingToolbar extends StatelessWidget {
  /// Callback pour basculer le mode plein écran (null = pas de bouton).
  final VoidCallback? onToggleFullscreen;
  final bool          isFullscreen;
  final Color         buttonColor;
  final Color         iconColor;

  const ReadingToolbar({
    super.key,
    this.onToggleFullscreen,
    this.isFullscreen = false,
    this.buttonColor  = const Color(0xFFEEEEEE),
    this.iconColor    = const Color(0xFF555555),
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ReadingPrefs.instance,
      builder: (context, _) {
        final prefs = ReadingPrefs.instance;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // A−
            _Btn(
              label: 'A−',
              fontSize: 12,
              enabled: prefs.canDecrease,
              color: buttonColor,
              textColor: iconColor,
              onTap: prefs.decrease,
            ),
            const SizedBox(width: 6),
            // A+
            _Btn(
              label: 'A+',
              fontSize: 15,
              enabled: prefs.canIncrease,
              color: buttonColor,
              textColor: iconColor,
              onTap: prefs.increase,
            ),
            // Plein écran
            if (onToggleFullscreen != null) ...[
              const SizedBox(width: 6),
              _IconBtn(
                icon: isFullscreen
                    ? Icons.fullscreen_exit_rounded
                    : Icons.fullscreen_rounded,
                color: buttonColor,
                iconColor: iconColor,
                onTap: onToggleFullscreen!,
              ),
            ],
          ],
        );
      },
    );
  }
}

// ── Bouton texte (A− / A+) ────────────────────────────────────────
class _Btn extends StatelessWidget {
  final String       label;
  final double       fontSize;
  final bool         enabled;
  final Color        color;
  final Color        textColor;
  final VoidCallback onTap;

  const _Btn({
    required this.label,
    required this.fontSize,
    required this.enabled,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color.withValues(alpha: enabled ? 1.0 : 0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: textColor.withValues(alpha: enabled ? 1.0 : 0.35),
          ),
        ),
      ),
    );
  }
}

// ── Bouton icône (plein écran) ─────────────────────────────────────
class _IconBtn extends StatelessWidget {
  final IconData     icon;
  final Color        color;
  final Color        iconColor;
  final VoidCallback onTap;

  const _IconBtn({
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }
}
