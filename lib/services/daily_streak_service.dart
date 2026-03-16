// services/daily_streak_service.dart
// Gestion automatique du streak quotidien — UpYourDeen
//
// Logique :
//   • Première ouverture du jour  → streak + 1  (+ XP bonus)
//   • Même jour, réouverture      → rien (déjà compté)
//   • Manque 1 jour               → streak remis à 1 (recommence)
//   • Badges attribués automatiquement à 7 / 30 / 100 jours

import 'package:shared_preferences/shared_preferences.dart';
import '../user_profile.dart';
import 'local_notif_service.dart';

class DailyStreakService {
  static final DailyStreakService instance = DailyStreakService._();
  DailyStreakService._();

  static const _kLastOpenKey = 'deenly_last_open_date';

  // ── Appeler à chaque lancement depuis main() ou HomeScreen ────────────
  /// Retourne true si c'est la première ouverture du jour (streak incrémenté).
  Future<bool> checkAndIncrementStreak(UserProfileProvider provider) async {
    if (!provider.hasProfile) return false;

    final prefs = await SharedPreferences.getInstance();
    final profile = provider.profile!;

    final todayKey = _dateKey(DateTime.now());
    final lastOpenKey = prefs.getString(_kLastOpenKey) ?? '';

    // Déjà compté aujourd'hui → rien à faire
    if (lastOpenKey == todayKey) return false;

    await prefs.setString(_kLastOpenKey, todayKey);

    // Calculer si le streak continue ou repart
    final yesterday = _dateKey(DateTime.now().subtract(const Duration(days: 1)));
    final streakContinues = lastOpenKey == yesterday;

    final newStreak = streakContinues ? profile.streak + 1 : 1;
    final xpGain    = _xpForStreak(newStreak);

    await provider.save(profile.copyWith(
      streak:    newStreak,
      xpTotal:   profile.xpTotal + xpGain,
      joursActif: profile.joursActif + 1,
    ));

    // Badges de streak
    await _checkStreakBadges(provider, newStreak);

    // Notifications locales : programmer + annuler le rappel streak
    final notifSvc = LocalNotifService.instance;
    await notifSvc.scheduleDailyNotifications(profile: provider.profile);
    await notifSvc.cancelStreakReminder();                 // ouverture du jour → plus de danger
    if (newStreak >= 3) {
      await notifSvc.scheduleStreakReminder(streak: newStreak);  // pour demain si absent
    }

    return true; // première ouverture du jour
  }

  // ── XP progressif selon la longueur du streak ─────────────────────────
  int _xpForStreak(int streak) {
    if (streak >= 100) return 50;
    if (streak >= 30)  return 30;
    if (streak >= 7)   return 20;
    return 10;
  }

  // ── Badges automatiques ────────────────────────────────────────────────
  Future<void> _checkStreakBadges(
    UserProfileProvider provider,
    int streak,
  ) async {
    final badges = <String>[];
    if (streak >= 7)   badges.add('assidu_7');
    if (streak >= 30)  badges.add('assidu_30');
    if (streak >= 100) badges.add('assidu_100');

    for (final badge in badges) {
      await provider.addBadge(badge);
    }
  }

  // ── Clé de date locale (YYYY-MM-DD) ───────────────────────────────────
  String _dateKey(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-'
      '${dt.day.toString().padLeft(2, '0')}';
}
