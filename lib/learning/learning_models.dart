import 'dart:convert';
import '../app_locale.dart';

// ─── Enums ────────────────────────────────────────────────────────

/// Niveau de maîtrise d'un verset (répétition espacée)
enum MasteryLevel { notSeen, learning, reviewing, mastered }

/// Types d'exercices disponibles
enum ExerciseType {
  listenChoose,    // Voir arabe → choisir la traduction
  fillBlank,       // Voir arabe → choisir la phonétique
  translateChoice, // Voir traduction → choisir le texte arabe
  arrange,         // Remettre les mots de la phonétique dans l'ordre
}

/// 5 étapes pédagogiques d'une leçon
enum LessonStep { discover, pronounce, understand, practice, validate }

// ─── Modèle Verset Apprentissage ─────────────────────────────────
class LearningVerset {
  final int    surahNumber;  // Numéro de la sourate (pour la persistance)
  final int    numero;       // Numéro du verset dans la sourate
  final String arabe;
  final String phonetique;
  final String francais;
  final String anglais;

  /// Returns the correct translation based on current locale
  String get traduction => AppLocale().isFrench ? francais : (anglais.isNotEmpty ? anglais : francais);

  MasteryLevel mastery;
  int          reviewCount;
  DateTime?    lastReviewed;

  LearningVerset({
    this.surahNumber    = 0,
    required this.numero,
    required this.arabe,
    required this.phonetique,
    required this.francais,
    this.anglais        = '',
    this.mastery        = MasteryLevel.notSeen,
    this.reviewCount    = 0,
    this.lastReviewed,
  });

  /// Répétition espacée : intervalles 4h / 24h / 7 jours
  bool get needsReview {
    if (mastery == MasteryLevel.notSeen) return false;
    if (lastReviewed == null) return true;
    final hours = DateTime.now().difference(lastReviewed!).inHours;
    return switch (mastery) {
      MasteryLevel.learning  => hours >= 4,
      MasteryLevel.reviewing => hours >= 24,
      MasteryLevel.mastered  => hours >= 168,
      _                      => false,
    };
  }
}

// ─── Modèle Leçon ────────────────────────────────────────────────
// 1 verset = 1 leçon
class LearningLesson {
  final int    surahNumber;
  final int    versetNumero;   // Numéro du verset dans la sourate
  final String surahName;
  final String surahNameFr;
  final String signification;
  final String significationEn;
  final String icon;
  final List<LearningVerset> versets;  // Toujours 1 élément

  bool isUnlocked;
  bool isCompleted;
  int  xpReward;

  LearningLesson({
    required this.surahNumber,
    this.versetNumero  = 1,
    required this.surahName,
    required this.surahNameFr,
    required this.signification,
    this.significationEn = '',
    required this.icon,
    required this.versets,
    this.isUnlocked  = false,
    this.isCompleted = false,
    this.xpReward    = 15,
  });

  // Avec 1 verset par leçon, la leçon est maîtrisée si le verset l'est
  bool   get isMastered       => versets.isNotEmpty && versets.first.mastery == MasteryLevel.mastered;
  int    get completedVersets => isMastered ? 1 : 0;
  double get progress         => isMastered ? 1.0 : 0.0;

  // Clé unique pour la persistance : "surahNum-versetNum"
  String get masteryKey       => '$surahNumber-$versetNumero';
}

// ─── Modèle Exercice ─────────────────────────────────────────────
class Exercise {
  final ExerciseType type;
  final LearningVerset verset;
  /// MCQ : 4 choix de réponse. Arrange : mots mélangés.
  final List<String> options;
  final String correctAnswer;
  /// Pour fillBlank : la phonétique avec "___" à la place du mot manquant.
  final String? hint;

  const Exercise({
    required this.type,
    required this.verset,
    required this.options,
    required this.correctAnswer,
    this.hint,
  });
}

// ─── Stats Utilisateur ───────────────────────────────────────────
class UserStats {
  int      xp;
  int      streak;
  int      level;
  DateTime? lastActivity;

  Map<int, MasteryLevel> surahMastery;
  int      totalExercises;
  int      correctExercises;

  // Objectif journalier
  int      dailyXpGoal;
  int      dailyXpToday;

  // Reprise automatique
  int?     lastLessonSurahNum;
  String?  lastPathTypeName;

  UserStats({
    this.xp               = 0,
    this.streak           = 0,
    this.level            = 1,
    this.lastActivity,
    Map<int, MasteryLevel>? surahMastery,
    this.totalExercises   = 0,
    this.correctExercises = 0,
    this.dailyXpGoal      = 50,
    this.dailyXpToday     = 0,
    this.lastLessonSurahNum,
    this.lastPathTypeName,
  }) : surahMastery = surahMastery ?? {};

  // ── Calculs ────────────────────────────────────────────────────
  double get accuracy          => totalExercises == 0 ? 0 : correctExercises / totalExercises;
  int    get xpForNextLevel    => level * 500;
  int    get xpForCurrentLevel => (level - 1) * 500;
  double get levelProgress     => ((xp - xpForCurrentLevel) / (xpForNextLevel - xpForCurrentLevel)).clamp(0.0, 1.0);

  bool   get dailyGoalReached  => dailyXpToday >= dailyXpGoal;
  double get dailyGoalProgress => (dailyXpToday / dailyXpGoal).clamp(0.0, 1.0);

  int get masteredVersets => surahMastery.values.where((m) => m == MasteryLevel.mastered).length;

  String get levelTitle {
    if (AppLocale().isFrench) {
      if (level <= 2) return 'Débutant';
      if (level <= 4) return 'Récitant';
      if (level <= 6) return 'Mémorisateur';
      if (level <= 9) return 'Hafidh Junior';
      return 'Hafidh';
    } else {
      if (level <= 2) return 'Beginner';
      if (level <= 4) return 'Reciter';
      if (level <= 6) return 'Memorizer';
      if (level <= 9) return 'Hafidh Junior';
      return 'Hafidh';
    }
  }

  // ── Mutations ─────────────────────────────────────────────────
  void addXP(int amount) {
    xp            += amount;
    dailyXpToday  += amount;
    while (xp >= xpForNextLevel) {
      level++;
    }
  }

  void updateStreak() {
    final now   = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (lastActivity == null) {
      streak = 1;
    } else {
      final last = DateTime(lastActivity!.year, lastActivity!.month, lastActivity!.day);
      final diff = today.difference(last).inDays;
      if (diff == 0) return;
      streak = diff == 1 ? streak + 1 : 1;
    }
    lastActivity = now;
  }

  // ── Sérialisation JSON ─────────────────────────────────────────
  Map<String, dynamic> toJson() => {
    'xp':                  xp,
    'streak':              streak,
    'level':               level,
    'lastActivity':        lastActivity?.toIso8601String(),
    'totalExercises':      totalExercises,
    'correctExercises':    correctExercises,
    'dailyXpGoal':         dailyXpGoal,
    'dailyXpToday':        dailyXpToday,
    'lastLessonSurahNum':  lastLessonSurahNum,
    'lastPathTypeName':    lastPathTypeName,
    'surahMastery':        surahMastery.map((k, v) => MapEntry(k.toString(), v.index)),
  };

  factory UserStats.fromJson(Map<String, dynamic> json) {
    final mastery = <int, MasteryLevel>{};
    if (json['surahMastery'] is Map) {
      (json['surahMastery'] as Map).forEach((k, v) {
        final key = int.tryParse(k.toString()) ?? 0;
        final idx = (v as int).clamp(0, MasteryLevel.values.length - 1);
        mastery[key] = MasteryLevel.values[idx];
      });
    }
    return UserStats(
      xp:                  json['xp']               ?? 0,
      streak:              json['streak']            ?? 0,
      level:               json['level']             ?? 1,
      lastActivity:        json['lastActivity'] != null ? DateTime.tryParse(json['lastActivity']) : null,
      totalExercises:      json['totalExercises']    ?? 0,
      correctExercises:    json['correctExercises']  ?? 0,
      dailyXpGoal:         json['dailyXpGoal']       ?? 50,
      dailyXpToday:        json['dailyXpToday']      ?? 0,
      lastLessonSurahNum:  json['lastLessonSurahNum'],
      lastPathTypeName:    json['lastPathTypeName'],
      surahMastery:        mastery,
    );
  }

  // ignore: unused_element
  static UserStats _fromJsonStr(String s) => UserStats.fromJson(jsonDecode(s));
}
