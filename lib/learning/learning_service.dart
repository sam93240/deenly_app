import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'learning_models.dart';

// ─── Learning Service ─────────────────────────────────────────────
// Couche de persistance pour les stats, la maîtrise des versets et le streak.
// Utilise shared_preferences pour conserver les données entre les sessions.
class LearningService {
  LearningService._();

  /// Singleton
  static final LearningService instance = LearningService._();

  // ── Clés SharedPreferences ─────────────────────────────────────
  static const _kStats        = 'deenly_learning_stats_v1';
  static const _kMastery      = 'deenly_learning_mastery_v1';
  static const _kLastReviewed = 'deenly_learning_last_reviewed_v1';
  static const _kQuizDone     = 'deenly_learning_quiz_done_v1';

  // ── UserStats ──────────────────────────────────────────────────

  /// Charge les stats (avec remise à zéro de dailyXpToday si nouveau jour).
  Future<UserStats> loadStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kStats);
      if (raw == null) return UserStats();
      final stats = UserStats.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      return _applyDailyReset(stats, prefs);
    } catch (_) {
      return UserStats();
    }
  }

  Future<void> saveStats(UserStats stats) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kStats, jsonEncode(stats.toJson()));
  }

  UserStats _applyDailyReset(UserStats stats, SharedPreferences prefs) {
    if (stats.lastActivity == null) return stats;
    final now   = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last  = DateTime(
      stats.lastActivity!.year,
      stats.lastActivity!.month,
      stats.lastActivity!.day,
    );
    if (today.isAfter(last)) {
      stats.dailyXpToday = 0;
      // Sauvegarde silencieuse (fire-and-forget)
      prefs.setString(_kStats, jsonEncode(stats.toJson()));
    }
    return stats;
  }

  // ── Maîtrise des versets ───────────────────────────────────────
  // Clé : "<surahNumber>_<versetNumero>"  →  MasteryLevel.index (int)

  Future<Map<String, int>> _loadMasteryMap() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kMastery);
      if (raw == null) return {};
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return map.map((k, v) => MapEntry(k, (v as num).toInt()));
    } catch (_) {
      return {};
    }
  }

  Future<void> _saveMasteryMap(Map<String, int> map) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kMastery, jsonEncode(map));
  }

  /// Sauvegarde la maîtrise d'un verset unique.
  Future<void> saveVersetMastery(
    int surahNumber,
    int versetNumero,
    MasteryLevel level,
    DateTime? lastReviewed,
  ) async {
    final map = await _loadMasteryMap();
    map['${surahNumber}_$versetNumero'] = level.index;

    // Stocke également la date de dernière révision
    if (lastReviewed != null) {
      final prefs = await SharedPreferences.getInstance();
      final rawLR = prefs.getString(_kLastReviewed);
      final lrMap = rawLR != null
          ? Map<String, dynamic>.from(jsonDecode(rawLR) as Map)
          : <String, dynamic>{};
      lrMap['${surahNumber}_$versetNumero'] = lastReviewed.toIso8601String();
      await prefs.setString(_kLastReviewed, jsonEncode(lrMap));
    }

    await _saveMasteryMap(map);
  }

  /// Applique la maîtrise sauvegardée à une liste de leçons.
  /// Débloque aussi les leçons suivantes si la précédente est maîtrisée.
  Future<void> applyMasteryToLessons(List<LearningLesson> lessons) async {
    final masteryMap    = await _loadMasteryMap();
    final lastRevRaw    = await _loadLastReviewedMap();

    for (final lesson in lessons) {
      for (final v in lesson.versets) {
        final key = '${lesson.surahNumber}_${v.numero}';
        final idx = masteryMap[key];
        if (idx != null && idx >= 0 && idx < MasteryLevel.values.length) {
          v.mastery = MasteryLevel.values[idx];
        }
        final lrStr = lastRevRaw[key];
        if (lrStr != null) {
          v.lastReviewed = DateTime.tryParse(lrStr);
        }
      }
      // Marquer la leçon comme complète si tous les versets sont maîtrisés
      if (lesson.versets.isNotEmpty) {
        lesson.isCompleted = lesson.versets
            .every((v) => v.mastery == MasteryLevel.mastered);
      }
    }

    // Débloquer progressivement dans les parcours séquentiels
    for (int i = 0; i < lessons.length - 1; i++) {
      if (lessons[i].isCompleted) lessons[i + 1].isUnlocked = true;
    }
  }

  Future<Map<String, String>> _loadLastReviewedMap() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kLastReviewed);
      if (raw == null) return {};
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return map.map((k, v) => MapEntry(k, v.toString()));
    } catch (_) {
      return {};
    }
  }

  // ── Quiz complétés ─────────────────────────────────────────────
  // Clés :
  //   quiz intermédiaire : "q_<surahNum>_<quizIndex>"   (ex: "q_1_1")
  //   quiz final          : "fq_<surahNum>"              (ex: "fq_1")

  /// Charge l'ensemble des clés de quiz réussis.
  Future<Set<String>> loadCompletedQuizzes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list  = prefs.getStringList(_kQuizDone) ?? [];
      return list.toSet();
    } catch (_) {
      return {};
    }
  }

  /// Marque un quiz comme réussi.
  Future<void> saveQuizCompleted(String quizKey) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list  = (prefs.getStringList(_kQuizDone) ?? []).toSet();
      list.add(quizKey);
      await prefs.setStringList(_kQuizDone, list.toList());
    } catch (_) {}
  }

  /// Clé pour quiz intermédiaire (ex: surah 1, quiz #2 = "q_1_2")
  static String intermediateQuizKey(int surahNum, int quizIdx) => 'q_${surahNum}_$quizIdx';

  /// Clé pour quiz final (ex: surah 1 = "fq_1")
  static String finalQuizKey(int surahNum) => 'fq_$surahNum';

  // ── Réinitialisation (debug) ───────────────────────────────────

  /// Efface toutes les données persistées (utile en développement).
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kStats);
    await prefs.remove(_kMastery);
    await prefs.remove(_kLastReviewed);
    await prefs.remove(_kQuizDone);
  }
}
