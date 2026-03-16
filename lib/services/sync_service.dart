// services/sync_service.dart
// Fusion intelligente local → Firebase après connexion
//
// Règles de merge :
//   xpTotal    → additionner  (local + firebase)
//   streak     → garder le plus élevé
//   versetsLus → garder le plus élevé
//   surahMastery → niveau le plus avancé verset par verset
//   Si Firebase vide → upload direct sans fusion

import 'package:firebase_auth/firebase_auth.dart';
import '../user_profile.dart';
import '../learning/learning_models.dart';
import '../learning/learning_service.dart';
import 'firestore_service.dart';

// ══════════════════════════════════════════════════════════════════════════
class SyncService {
  static final SyncService instance = SyncService._();
  SyncService._();

  final _fs = FirestoreService.instance;

  /// Appelé immédiatement après une connexion réussie.
  /// Fusionne les données locales avec Firebase puis sauvegarde le résultat.
  Future<void> syncAfterLogin({
    required User                user,
    required UserProfileProvider profileProvider,
  }) async {
    final local = profileProvider.profile;
    if (local == null) return;

    final localStats = await LearningService.instance.loadStats();
    final fireData   = await _fs.downloadData(user.uid);

    if (fireData == null) {
      // Première connexion : upload direct
      await _fs.uploadProfile(
        userId:  user.uid,
        profile: local,
        stats:   localStats,
      );
      return;
    }

    // ── Fusion XP ─────────────────────────────────────────────────────
    final fireXp    = (fireData['xpTotal']       as int?) ?? 0;
    final fireLXp   = (fireData['lessonsXp']     as int?) ?? 0;
    final mergedXp  = local.xpTotal + fireXp;
    final mergedLXp = localStats.xp + fireLXp;

    // ── Fusion streak ─────────────────────────────────────────────────
    final fireStreak  = (fireData['streak']        as int?) ?? 0;
    final fireLStreak = (fireData['lessonsStreak'] as int?) ?? 0;
    final mergedStreak  = local.streak  > fireStreak  ? local.streak  : fireStreak;
    final mergedLStreak = localStats.streak > fireLStreak ? localStats.streak : fireLStreak;

    // ── Fusion versetsLus ─────────────────────────────────────────────
    final fireVers   = (fireData['versetsLus'] as int?) ?? 0;
    final mergedVers = local.versetsLus > fireVers ? local.versetsLus : fireVers;

    // ── Fusion surahMastery (progression la plus avancée) ─────────────
    final rawMastery  = (fireData['surahMastery'] as Map<String, dynamic>?) ?? {};
    final fireMastery = rawMastery.map(
      (k, v) => MapEntry(int.tryParse(k) ?? 0, MasteryLevel.values[v as int]),
    );
    final mergedMastery = Map<int, MasteryLevel>.from(fireMastery);
    localStats.surahMastery.forEach((surah, level) {
      final fireLevel = mergedMastery[surah];
      if (fireLevel == null || level.index > fireLevel.index) {
        mergedMastery[surah] = level;
      }
    });

    // ── Appliquer la fusion localement ────────────────────────────────
    final mergedProfile = local.copyWith(
      xpTotal:    mergedXp,
      streak:     mergedStreak,
      versetsLus: mergedVers,
    );
    await profileProvider.save(mergedProfile);

    final mergedStats = UserStats(
      xp:               mergedLXp,
      streak:           mergedLStreak,
      level:            localStats.level,
      lastActivity:     localStats.lastActivity,
      surahMastery:     mergedMastery,
      totalExercises:   localStats.totalExercises,
      correctExercises: localStats.correctExercises,
      dailyXpGoal:      localStats.dailyXpGoal,
      dailyXpToday:     localStats.dailyXpToday,
      lastLessonSurahNum: localStats.lastLessonSurahNum,
      lastPathTypeName:   localStats.lastPathTypeName,
    );
    await LearningService.instance.saveStats(mergedStats);

    // ── Upload le résultat fusionné sur Firebase ───────────────────────
    await _fs.uploadProfile(
      userId:  user.uid,
      profile: mergedProfile,
      stats:   mergedStats,
    );
  }
}
