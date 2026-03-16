// widgets/save_progress_popup.dart
// Popup "Sauvegarde ta progression" déclenché après engagement significatif
// (streak >= 3 jours OU >= 5 versets maîtrisés)

import 'package:flutter/material.dart';
import '../auth_screen.dart';
import '../app_locale.dart';

// ══════════════════════════════════════════════════════════════════════════
/// Affiche le popup en modal bottom sheet.
/// Retourne true si l'utilisateur s'est connecté.
Future<bool> showSaveProgressPopup(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context:           context,
    isScrollControlled: true,
    backgroundColor:   Colors.transparent,
    builder:           (_) => const _SaveProgressSheet(),
  );
  return result ?? false;
}

// ══════════════════════════════════════════════════════════════════════════
class _SaveProgressSheet extends StatelessWidget {
  const _SaveProgressSheet();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale();

    return Container(
      decoration: const BoxDecoration(
        color:        Color(0xFFF6F0E3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(
          24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Poignée ───────────────────────────────────────────────────
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
              color:        const Color(0xFFD6C9AF),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // ── Icône ─────────────────────────────────────────────────────
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1B4D38), Color(0xFF0A2018)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.cloud_upload_rounded,
                color: Color(0xFFC8933A), size: 30),
          ),
          const SizedBox(height: 18),

          // ── Titre ─────────────────────────────────────────────────────
          Text(
            locale.tr(
              'Ne perds pas ta progression !',
              "Don't lose your progress!",
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color:      Color(0xFF1A130A),
              fontSize:   20,
              fontWeight: FontWeight.w800,
              height:     1.3,
            ),
          ),
          const SizedBox(height: 10),

          // ── Description ───────────────────────────────────────────────
          Text(
            locale.tr(
              'Tu as déjà bien avancé dans ton parcours. Crée un compte gratuit pour sauvegarder ta progression, ta série et tes leçons sur tous tes appareils.',
              "You've already made great progress. Create a free account to save your progress, streak and lessons across all your devices.",
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color:    Color(0xFF5A4833),
              fontSize: 14,
              height:   1.6,
            ),
          ),
          const SizedBox(height: 28),

          // ── Stats mini ────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatChip(
                icon:  '🔥',
                label: locale.tr('Série active', 'Active streak'),
              ),
              const SizedBox(width: 12),
              _StatChip(
                icon:  '📖',
                label: locale.tr('Leçons complétées', 'Lessons done'),
              ),
              const SizedBox(width: 12),
              _StatChip(
                icon:  '⭐',
                label: locale.tr('XP accumulés', 'XP earned'),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // ── Bouton Créer un compte ────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final success = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder:          (_) => const AuthScreen.createAccount(),
                    fullscreenDialog: true,
                  ),
                );
                if (context.mounted) {
                  Navigator.pop(context, success ?? false);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B4D38),
                foregroundColor: Colors.white,
                padding:         const EdgeInsets.symmetric(vertical: 16),
                shape:           RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                locale.tr('Créer un compte gratuit', 'Create a free account'),
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // ── Bouton Connexion ──────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                final success = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder:          (_) => const AuthScreen.login(),
                    fullscreenDialog: true,
                  ),
                );
                if (context.mounted) {
                  Navigator.pop(context, success ?? false);
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1B4D38),
                side:            const BorderSide(color: Color(0xFF1B4D38)),
                padding:         const EdgeInsets.symmetric(vertical: 14),
                shape:           RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                locale.tr('J\'ai déjà un compte', 'I already have an account'),
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // ── Plus tard ─────────────────────────────────────────────────
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              locale.tr('Plus tard', 'Later'),
              style: const TextStyle(
                color:    Color(0xFF8A7863),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
class _StatChip extends StatelessWidget {
  final String icon;
  final String label;

  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color:        Colors.white,
        borderRadius: BorderRadius.circular(10),
        border:       Border.all(color: const Color(0xFFD6C9AF)),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color:    Color(0xFF5A4833),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
