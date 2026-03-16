import 'package:flutter/material.dart';

// ─── Design System Centralisé — Module Apprentissage ──────────────
// Un seul endroit pour toutes les couleurs du module.
// Usage : import 'learning_colors.dart';  puis LNColors.green
abstract class LNColors {
  // Fonds & surfaces
  static const bg          = Color(0xFFFFFEF7);
  static const white       = Color(0xFFFFFFFF);
  static const border      = Color(0xFFE5E5E5);

  // Texte
  static const text        = Color(0xFF3C3C3C);
  static const textLight   = Color(0xFF777777);

  // Vert (succès / correct)
  static const green       = Color(0xFF58C900);
  static const greenDark   = Color(0xFF3DAA00);
  static const greenLight  = Color(0xFFE8F9D0);

  // Rouge (erreur)
  static const red         = Color(0xFFFF4B4B);
  static const redLight    = Color(0xFFFFEBEB);

  // Or (XP / rewards)
  static const gold        = Color(0xFFFFB020);
  static const goldLight   = Color(0xFFFFF4DC);

  // Bleu (phonétique / info)
  static const blue        = Color(0xFF1CB0F6);
  static const blueLight   = Color(0xFFE7F7FF);

  // Orange (streak / urgence)
  static const orange      = Color(0xFFFF9600);
  static const orangeLight = Color(0xFFFFF0D0);

  // Violet (niveau / parcours libre)
  static const purple      = Color(0xFF8549BA);
  static const purpleLight = Color(0xFFF0E8FF);
}
