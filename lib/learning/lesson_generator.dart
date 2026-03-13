import '../sourates_data.dart';
import 'learning_models.dart';

// ─── Path Types ───────────────────────────────────────────────────
enum LearningPathType { debutant, priere, protection, importantes, juzAmma, libre }

// ─── Lesson Generator ─────────────────────────────────────────────
// Transforme les sourates existantes en leçons pédagogiques.
class LessonGenerator {

  // ── Numéros de sourates par parcours ─────────────────────────
  static const _debutantNums = [
    1,   // Al-Fatiha  — la base, récitée dans chaque prière
    112, // Al-Ikhlas  — le monothéisme pur
    113, // Al-Falaq   — protection
    114, // An-Nas     — protection
    108, // Al-Kawthar — très courte
    109, // Al-Kafirun — important
    103, // Al-Asr     — très court, essentiel
    110, // An-Nasr
    107, // Al-Ma'un
    106, // Quraysh
    105, // Al-Fil
    104, // Al-Humaza
    102, // At-Takathur
    101, // Al-Qari'a
    100, // Al-Adiyat
    99,  // Az-Zalzala
    97,  // Al-Qadr    — Nuit du Destin
    96,  // Al-Alaq    — première révélation
    98,  // Al-Bayyina
    95,  // At-Tin
  ];

  static const _priereNums = [1, 112, 113, 114, 87, 88, 89, 36, 67];

  static const _protectionNums = [113, 114, 2, 255]; // Falaq, Nas, début Al-Baqarah, Ayat al-Kursi (via verset)

  static const _importantesNums = [
    1, 36, 55, 67, 112, 18, 56, 67, 78,
  ];

  static const _juzAmmaNums = [
    78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
    91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103,
    104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114,
  ];

  // ── Icônes par sourate ────────────────────────────────────────
  static const _icons = <int, String>{
    1: '🌟',  2: '📖',  3: '✨',  18: '🗻', 36: '💫', 55: '🌸',
    56: '⚖️', 67: '🌙', 78: '🌊', 87: '📿', 88: '⛅', 89: '🌅',
    90: '🏙️', 91: '☀️', 92: '🌑', 93: '🌄', 94: '🌬️',
    95: '🫒', 96: '📜', 97: '✨', 98: '📚', 99: '🌍',
    100: '🐎',101: '💥',102: '🏃',103: '⏳',104: '🔥',
    105: '🐘',106: '🕌',107: '🍽️',108: '🌊',109: '🚫',
    110: '🏆',111: '🌿',112: '💎',113: '🌅',114: '👥',
  };

  // ── Construire un parcours : 1 verset = 1 leçon ──────────────
  static List<LearningLesson> buildPath(LearningPathType type) {
    final nums    = _getNumsForPath(type);
    final lessons = <LearningLesson>[];
    bool  firstLesson = true;

    for (final surahNum in nums) {
      final sourate = _findSourate(surahNum);
      if (sourate == null) continue;

      for (final v in sourate.versets) {
        // Première leçon du parcours débloquée, les autres verrouillées
        // (en mode libre : tout débloqué)
        final isUnlocked = type == LearningPathType.libre || firstLesson;

        lessons.add(LearningLesson(
          surahNumber:   sourate.numero,
          versetNumero:  v.numero,
          surahName:     sourate.nomArabe,
          surahNameFr:   sourate.nomFrancais,
          signification: sourate.signification,
          icon:          _icons[sourate.numero] ?? '📖',
          xpReward:      15,
          isUnlocked:    isUnlocked,
          isCompleted:   false,
          versets: [
            LearningVerset(
              surahNumber: sourate.numero,
              numero:      v.numero,
              arabe:       v.arabe,
              phonetique:  v.phonetique,
              francais:    v.francais,
              mastery:     MasteryLevel.notSeen,
            )
          ],
        ));
        firstLesson = false;
      }
    }

    return lessons;
  }

  // ── Mode libre : toutes les sourates, 1 verset = 1 leçon ─────
  static List<LearningLesson> buildAllSurahs() {
    final lessons = <LearningLesson>[];
    for (final s in sourates) {
      for (final v in s.versets) {
        lessons.add(LearningLesson(
          surahNumber:   s.numero,
          versetNumero:  v.numero,
          surahName:     s.nomArabe,
          surahNameFr:   s.nomFrancais,
          signification: s.signification,
          icon:          _icons[s.numero] ?? '📖',
          xpReward:      15,
          isUnlocked:    true,
          isCompleted:   false,
          versets: [
            LearningVerset(
              surahNumber: s.numero,
              numero:      v.numero,
              arabe:       v.arabe,
              phonetique:  v.phonetique,
              francais:    v.francais,
              mastery:     MasteryLevel.notSeen,
            )
          ],
        ));
      }
    }
    return lessons;
  }

  // ── Obtenir les versets à réviser ────────────────────────────
  static List<LearningVerset> getReviewDue(List<LearningLesson> lessons) {
    final due = <LearningVerset>[];
    for (final lesson in lessons) {
      for (final v in lesson.versets) {
        if (v.needsReview) due.add(v);
      }
    }
    due.shuffle();
    return due.take(10).toList(); // max 10 versets par session
  }

  // ── Générer des exercices pour 1 verset ──────────────────────
  // Avec 1 verset par leçon, on génère tous les exercices pour ce verset.
  // Le pool de distracteurs vient de versets aléatoires de la même sourate.
  static List<Exercise> generateExercises(LearningLesson lesson) {
    if (lesson.versets.isEmpty) return [];

    final verset     = lesson.versets.first;
    final exercises  = <Exercise>[];

    // Pool de distracteurs : autres versets du Coran (fallbacks intégrés)
    final poolFr = [
      verset.francais,
      'Au nom d\'Allah, le Tout Miséricordieux',
      'Louange à Allah, Seigneur des univers',
      'Maître du Jour du Jugement',
      'C\'est Toi que nous adorons',
      'Guide-nous vers le droit chemin',
      'Dis : Il est Allah, Unique',
      'Allah, l\'Absolu',
      'Il n\'a pas engendré et n\'a pas été engendré',
      'En vérité, l\'homme est en grande perte',
    ];
    final poolPhonetique = [
      verset.phonetique,
      'Bismillah ir-rahman ir-rahim',
      'Al-hamdu lillahi rabb il-\'alamin',
      'Maliki yawm id-din',
      'Iyyaka na\'budu wa iyyaka nasta\'in',
      'Ihdina s-sirat al-mustaqim',
      'Qul huwa allahu ahad',
      'Allahu s-samad',
      'Wa lam yakun lahu kufuwan ahad',
      'Wal-\'asri inna l-insana lafi khusr',
    ];

    // Exercice 1 : voir l'arabe → choisir la traduction
    exercises.add(Exercise(
      type:          ExerciseType.listenChoose,
      verset:        verset,
      correctAnswer: verset.francais,
      options:       _buildOptions(verset.francais, poolFr),
    ));

    // Exercice 2 : voir l'arabe → compléter la phonétique
    exercises.add(Exercise(
      type:          ExerciseType.fillBlank,
      verset:        verset,
      correctAnswer: verset.phonetique,
      options:       _buildOptions(verset.phonetique, poolPhonetique),
    ));

    // Exercice 3 : voir la traduction → identifier le texte arabe
    exercises.add(Exercise(
      type:          ExerciseType.translateChoice,
      verset:        verset,
      correctAnswer: verset.arabe,
      options:       _buildOptions(verset.arabe, [verset.arabe]),
    ));

    // Exercice 4 : remettre les mots de la phonétique dans l'ordre
    final words = verset.phonetique.trim().split(RegExp(r'\s+'));
    if (words.length >= 3) {
      exercises.add(Exercise(
        type:          ExerciseType.arrange,
        verset:        verset,
        correctAnswer: verset.phonetique.trim(),
        options:       (List<String>.from(words)..shuffle()),
      ));
    }

    return exercises;
  }

  /// Génère un seul exercice varié pour un verset (utilisé en révision SRS).
  static Exercise buildExerciseForVerset(
    LearningVerset verset,
    List<LearningVerset> pool,
  ) {
    final allFr         = pool.map((v) => v.francais).toList();
    final allPhonetique = pool.map((v) => v.phonetique).toList();

    // Choisir le type selon le niveau de maîtrise
    final typeIdx = verset.reviewCount % 3; // rotation 0→1→2
    switch (typeIdx) {
      case 0:
        return Exercise(
          type:          ExerciseType.listenChoose,
          verset:        verset,
          correctAnswer: verset.francais,
          options:       _buildOptions(verset.francais, allFr),
        );
      case 1:
        return Exercise(
          type:          ExerciseType.fillBlank,
          verset:        verset,
          correctAnswer: verset.phonetique,
          options:       _buildOptions(verset.phonetique, allPhonetique),
        );
      default:
        final words = verset.phonetique.trim().split(RegExp(r'\s+'));
        if (words.length >= 3) {
          return Exercise(
            type:          ExerciseType.arrange,
            verset:        verset,
            correctAnswer: verset.phonetique.trim(),
            options:       (List<String>.from(words)..shuffle()),
          );
        }
        return Exercise(
          type:          ExerciseType.listenChoose,
          verset:        verset,
          correctAnswer: verset.francais,
          options:       _buildOptions(verset.francais, allFr),
        );
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────
  static List<String> _buildOptions(String correct, List<String> pool) {
    final fallbacks = [
      'Au nom d\'Allah, le Tout Miséricordieux',
      'Louange à Allah, Seigneur des univers',
      'Dis : Il est Allah, Unique',
      'Seigneur de l\'aube',
      'Maître du Jour du Jugement',
    ];
    final wrong = pool.where((o) => o != correct).toList()..shuffle();
    final opts  = <String>[correct];
    for (final w in [...wrong, ...fallbacks]) {
      if (opts.length >= 4) break;
      if (!opts.contains(w)) opts.add(w);
    }
    return opts..shuffle();
  }

  static Sourate? _findSourate(int num) {
    try {
      return sourates.firstWhere((s) => s.numero == num);
    } catch (_) {
      return null;
    }
  }

  static List<int> _getNumsForPath(LearningPathType type) {
    switch (type) {
      case LearningPathType.debutant:    return _debutantNums;
      case LearningPathType.priere:      return _priereNums;
      case LearningPathType.protection:  return _protectionNums;
      case LearningPathType.importantes: return _importantesNums;
      case LearningPathType.juzAmma:     return _juzAmmaNums;
      case LearningPathType.libre:
        return sourates.map((s) => s.numero).toList();
    }
  }

  static int _calcXP(Sourate s) {
    if (s.nombreVersets <= 5)  return 15;
    if (s.nombreVersets <= 15) return 25;
    if (s.nombreVersets <= 50) return 40;
    return 60;
  }
}
