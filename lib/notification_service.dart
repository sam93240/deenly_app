// notification_service.dart
// Moteur de sélection intelligente des notifications — Application UpYourDeen

import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_data.dart';
import 'user_profile.dart';

class NotificationService {
  static const _kLastVisitKey = 'deenly_last_visit';
  static const _kNotifCountKey = 'deenly_notif_count';
  static const _kDismissedTodayKey = 'deenly_notif_dismissed_date';

  final _rng = Random();

  /// Sélectionne la notification la plus pertinente selon le contexte
  Future<DeenlyNotif?> pickNotification(UserProfile? profile) async {
    final prefs = await SharedPreferences.getInstance();

    // Vérifier si déjà dismissée aujourd'hui
    final dismissedDate = prefs.getString(_kDismissedTodayKey) ?? '';
    final today = _todayKey();
    if (dismissedDate == today) return null;

    // Calculer le contexte
    final now = DateTime.now();
    final lastVisitRaw = prefs.getString(_kLastVisitKey);
    final lastVisit = lastVisitRaw != null
        ? DateTime.tryParse(lastVisitRaw)
        : null;
    final joursAbsent = lastVisit != null
        ? now.difference(lastVisit).inDays
        : 0;
    final totalNotifs = prefs.getInt(_kNotifCountKey) ?? 0;

    // Enregistrer cette visite
    await prefs.setString(_kLastVisitKey, now.toIso8601String());
    await prefs.setInt(_kNotifCountKey, totalNotifs + 1);

    // ── Logique de sélection ──

    // 1. Comeback — absent depuis 3+ jours
    if (joursAbsent >= 3) {
      return _pick(kComebackNotifs)._fillTemplate(
        jours: joursAbsent,
        profile: profile,
      );
    }

    // 2. Streak en danger — série > 0 mais absent hier
    if (profile != null && profile.streak > 2 && joursAbsent >= 1) {
      // Indices 4-5 = alertes de danger
      final dangerNotifs = kStreakNotifs.sublist(4, 6);
      return _pick(dangerNotifs)._fillTemplate(
        streak: profile.streak,
        profile: profile,
      );
    }

    // 3. Streak perdu
    if (profile != null && profile.streak == 0 && joursAbsent >= 1 && lastVisit != null) {
      // Indices 6-7 = série perdue
      final lostNotifs = kStreakNotifs.sublist(6, 8);
      return _pick(lostNotifs)._fillTemplate(profile: profile);
    }

    // 4. Célébration — nouveaux paliers
    if (profile != null) {
      final celebNotif = _checkCelebration(profile, prefs);
      if (celebNotif != null) return celebNotif;
    }

    // 5. Sadaqa Jariya — tous les 15 lancements, max 1x par semaine
    if (totalNotifs > 0 && totalNotifs % 15 == 0) {
      final lastSadaqa = prefs.getString('deenly_last_sadaqa');
      final canShowSadaqa = lastSadaqa == null ||
          now.difference(DateTime.parse(lastSadaqa)).inDays >= 7;
      if (canShowSadaqa) {
        await prefs.setString('deenly_last_sadaqa', now.toIso8601String());
        return _pick(kSadaqaNotifs);
      }
    }

    // 6. Distribution pondérée pour le reste
    final hour = now.hour;
    final weights = <NotifType, int>{};

    // Matin : plus de rappels prière et défis
    if (hour >= 5 && hour < 12) {
      weights[NotifType.rappelPriere] = 3;
      weights[NotifType.defiJour] = 3;
      weights[NotifType.motivation] = 2;
      weights[NotifType.bienEtre] = 2;
    }
    // Après-midi : motivation et bien-être
    else if (hour >= 12 && hour < 18) {
      weights[NotifType.motivation] = 3;
      weights[NotifType.bienEtre] = 3;
      weights[NotifType.defiJour] = 2;
      weights[NotifType.rappelPriere] = 1;
    }
    // Soir : rappels et bien-être
    else if (hour >= 18 && hour < 22) {
      weights[NotifType.rappelPriere] = 3;
      weights[NotifType.bienEtre] = 3;
      weights[NotifType.motivation] = 2;
      weights[NotifType.defiJour] = 1;
    }
    // Nuit : doux et apaisant
    else {
      weights[NotifType.bienEtre] = 4;
      weights[NotifType.rappelPriere] = 2;
      weights[NotifType.motivation] = 2;
    }

    // Streak positif — plus de chances de félicitation
    if (profile != null && profile.streak >= 3) {
      weights[NotifType.streak] = 3;
    }

    final type = _weightedPick(weights);
    final notif = _pickByType(type);
    return notif?._fillTemplate(
      profile: profile,
      streak: profile?.streak ?? 0,
    );
  }

  /// Marquer la notification comme lue/dismissée pour aujourd'hui
  Future<void> dismiss() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kDismissedTodayKey, _todayKey());
  }

  /// Salutation contextuelle selon l'heure
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return kMorningGreetings[_rng.nextInt(kMorningGreetings.length)];
    } else if (hour >= 12 && hour < 18) {
      return kAfternoonGreetings[_rng.nextInt(kAfternoonGreetings.length)];
    } else if (hour >= 18 && hour < 22) {
      return kEveningGreetings[_rng.nextInt(kEveningGreetings.length)];
    } else {
      return kNightGreetings[_rng.nextInt(kNightGreetings.length)];
    }
  }

  // ── Helpers privés ──

  String _todayKey() {
    final d = DateTime.now();
    return '${d.year}-${d.month}-${d.day}';
  }

  DeenlyNotif _pick(List<DeenlyNotif> list) {
    return list[_rng.nextInt(list.length)];
  }

  NotifType _weightedPick(Map<NotifType, int> weights) {
    final entries = weights.entries.toList();
    final total = entries.fold<int>(0, (s, e) => s + e.value);
    var r = _rng.nextInt(total);
    for (final e in entries) {
      r -= e.value;
      if (r < 0) return e.key;
    }
    return entries.last.key;
  }

  DeenlyNotif? _pickByType(NotifType type) {
    switch (type) {
      case NotifType.motivation:
        return _pick(kMotivationNotifs);
      case NotifType.streak:
        return _pick(kStreakNotifs.sublist(0, 4)); // positives only (indices 0-3)
      case NotifType.bienEtre:
        return _pick(kBienEtreNotifs);
      case NotifType.defiJour:
        return _pick(kDefiNotifs);
      case NotifType.rappelPriere:
        return _pick(kRappelNotifs);
      case NotifType.comeback:
        return _pick(kComebackNotifs);
      case NotifType.sadaqaJariya:
        return _pick(kSadaqaNotifs);
      case NotifType.celebration:
        return _pick(kCelebrationNotifs);
    }
  }

  DeenlyNotif? _checkCelebration(UserProfile profile, SharedPreferences prefs) {
    // Vérifier paliers XP
    final xpMilestones = [100, 250, 500, 1000, 1500, 2000, 3000, 5000];
    for (final m in xpMilestones.reversed) {
      final key = 'deenly_celebrated_xp_$m';
      if (profile.xpTotal >= m && !(prefs.getBool(key) ?? false)) {
        prefs.setBool(key, true);
        return kCelebrationNotifs[0]._fillTemplate(
          xp: m,
          profile: profile,
        );
      }
    }

    // Vérifier paliers versets
    final versetMilestones = [10, 50, 100, 250, 500];
    for (final m in versetMilestones.reversed) {
      final key = 'deenly_celebrated_versets_$m';
      if (profile.versetsLus >= m && !(prefs.getBool(key) ?? false)) {
        prefs.setBool(key, true);
        return kCelebrationNotifs[2]._fillTemplate(
          versets: m,
          profile: profile,
        );
      }
    }

    return null;
  }
}

// ── Extension pour remplir les templates ──
extension _NotifTemplate on DeenlyNotif {
  DeenlyNotif _fillTemplate({
    UserProfile? profile,
    int? streak,
    int? jours,
    int? xp,
    int? versets,
    String? badge,
  }) {
    var msg = message;
    var tit = titre;
    var msgEn = messageEn;
    var titEn = titreEn;

    if (streak != null) {
      msg = msg.replaceAll('{streak}', '$streak');
      tit = tit.replaceAll('{streak}', '$streak');
      if (msgEn != null) msgEn = msgEn.replaceAll('{streak}', '$streak');
      if (titEn != null) titEn = titEn.replaceAll('{streak}', '$streak');
    }
    if (jours != null) {
      msg = msg.replaceAll('{jours}', '$jours');
      tit = tit.replaceAll('{jours}', '$jours');
      if (msgEn != null) msgEn = msgEn.replaceAll('{jours}', '$jours');
      if (titEn != null) titEn = titEn.replaceAll('{jours}', '$jours');
    }
    if (xp != null) {
      msg = msg.replaceAll('{xp}', '$xp');
      tit = tit.replaceAll('{xp}', '$xp');
      if (msgEn != null) msgEn = msgEn.replaceAll('{xp}', '$xp');
      if (titEn != null) titEn = titEn.replaceAll('{xp}', '$xp');
    }
    if (versets != null) {
      msg = msg.replaceAll('{versets}', '$versets');
      tit = tit.replaceAll('{versets}', '$versets');
      if (msgEn != null) msgEn = msgEn.replaceAll('{versets}', '$versets');
      if (titEn != null) titEn = titEn.replaceAll('{versets}', '$versets');
    }
    if (badge != null) {
      msg = msg.replaceAll('{badge}', badge);
      tit = tit.replaceAll('{badge}', badge);
      if (msgEn != null) msgEn = msgEn.replaceAll('{badge}', badge);
      if (titEn != null) titEn = titEn.replaceAll('{badge}', badge);
    }
    if (profile != null) {
      msg = msg.replaceAll('{prenom}', profile.prenom);
      tit = tit.replaceAll('{prenom}', profile.prenom);
      if (msgEn != null) msgEn = msgEn.replaceAll('{prenom}', profile.prenom);
      if (titEn != null) titEn = titEn.replaceAll('{prenom}', profile.prenom);
    }

    return DeenlyNotif(
      type: type,
      emoji: emoji,
      titre: tit,
      message: msg,
      actionLabel: actionLabel,
      actionRoute: actionRoute,
      titreEn: titEn,
      messageEn: msgEn,
      actionLabelEn: actionLabelEn,
    );
  }
}
