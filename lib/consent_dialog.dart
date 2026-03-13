// consent_dialog.dart
// Popup de consentement analytics — Application Deenly

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kGreen = Color(0xFF1B4D38);
const _kGold = Color(0xFFC8933A);

/// Vérifie si le consentement a déjà été demandé.
/// Si non, affiche le popup. Appelé une seule fois au premier lancement.
Future<void> showConsentIfNeeded(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final alreadyAsked = prefs.getBool('deenly_consent_asked') ?? false;

  if (alreadyAsked || !context.mounted) return;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => _ConsentDialog(),
  );
}

class _ConsentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final txtDk = isDark ? Colors.white : const Color(0xFF1A130A);
    final txtMd = isDark ? Colors.white70 : const Color(0xFF5A4833);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icône
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(
                color: _kGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.shield_rounded, color: _kGreen, size: 28),
            ),
            const SizedBox(height: 16),

            // Titre
            Text(
              'Ta vie privée compte',
              style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: txtDk,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Explication
            Text(
              'As-salamu alaykum !\n\n'
              'Pour améliorer Deenly, on aimerait collecter '
              'des données d\'utilisation anonymes (écrans visités, '
              'fonctionnalités utilisées). Aucune donnée personnelle '
              'n\'est collectée.\n\n'
              'Tu peux changer d\'avis à tout moment dans les Paramètres.',
              style: TextStyle(
                fontSize: 13, color: txtMd, height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Bouton accepter
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _respond(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('J\'accepte',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 10),

            // Bouton refuser
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => _respond(context, false),
                style: TextButton.styleFrom(
                  foregroundColor: txtMd,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Non merci',
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _respond(BuildContext context, bool accepted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('deenly_consent_asked', true);
    await prefs.setBool('deenly_analytics_consent', accepted);
    if (context.mounted) Navigator.pop(context);
  }
}
