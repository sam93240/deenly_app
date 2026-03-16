// services/engagement_service.dart
// Suivi de l'engagement utilisateur pour déclencher le popup Firebase
// au bon moment (sans être intrusif).
//
// Conditions de déclenchement :
//   • streak >= 3 jours consécutifs  OU
//   • >= 5 versets maîtrisés dans la section apprentissage
//
// Le popup ne s'affiche qu'une seule fois (même s'il clique "Plus tard").
// La bannière sur le Home peut être fermée définitivement.

import 'package:shared_preferences/shared_preferences.dart';
import '../learning/learning_models.dart';
import '../learning/learning_service.dart';
import '../user_profile.dart';
import 'auth_service.dart';

// ══════════════════════════════════════════════════════════════════════════
class EngagementService {
  static final EngagementService instance = EngagementService._();
  EngagementService._();

  static const _kPopupShown      = 'deenly_firebase_popup_shown';
  static const _kBannerDismissed = 'deenly_firebase_banner_dismissed';

  // ── Popup ─────────────────────────────────────────────────────────────

  /// Retourne true si le popup "Sauvegarde ta progression" doit s'afficher.
  Future<bool> shouldShowPopup({required UserProfile? profile}) async {
    // Déjà connecté → pas besoin
    if (AuthService.instance.isLoggedIn) return false;

    // Déjà montré → ne plus déranger
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_kPopupShown) ?? false) return false;

    // Condition 1 : streak >= 3 jours
    final streak = profile?.streak ?? 0;
    if (streak >= 3) return true;

    // Condition 2 : >= 5 versets maîtrisés
    final stats = await LearningService.instance.loadStats();
    final mastered = stats.surahMastery.values
        .where((m) => m == MasteryLevel.mastered)
        .length;
    if (mastered >= 5) return true;

    return false;
  }

  /// Marque le popup comme affiché (ne plus jamais le montrer).
  Future<void> markPopupShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kPopupShown, true);
  }

  // ── Bannière Home ─────────────────────────────────────────────────────

  /// True si l'utilisateur a fermé la bannière.
  Future<bool> isBannerDismissed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kBannerDismissed) ?? false;
  }

  /// Ferme la bannière définitivement.
  Future<void> dismissBanner() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kBannerDismissed, true);
  }
}
