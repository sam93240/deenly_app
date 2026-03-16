# 📖 Module Apprentissage — Architecture Complète
## Application Nour · Plan de développement V1 → V2

---

## 1. État actuel du code (audit)

### ✅ Ce qui existe déjà et fonctionne

| Fichier | Contenu | État |
|---|---|---|
| `learning_models.dart` | `LearningVerset`, `LearningLesson`, `Exercise`, `UserStats` | ✅ Solide |
| `lesson_generator.dart` | Génération des parcours, exercices, révision due | ✅ Fonctionnel |
| `learning_home_screen.dart` | Accueil avec XP, streak, parcours, révisions dues | ✅ Complet |
| `learning_path_screen.dart` | Liste des leçons avec verrouillage progressif | ✅ Complet |
| `lesson_screen.dart` | Présentation versets + quiz MCQ + résultats | ✅ Bon départ |
| `review_screen.dart` | Flashcards avec flip 3D + auto-évaluation | ✅ Très bien |
| `progress_screen.dart` | XP, badges, stats | ✅ Existant |

### ❌ Ce qui manque pour atteindre l'objectif

1. **Persistance des données** — tout se remet à zéro au redémarrage (`shared_preferences`)
2. **Nouveaux types d'exercices** — seul le MCQ traduction existe ; il manque : mot manquant, remise en ordre, association arabe/phonétique
3. **Structure leçon en 5 étapes** — actuellement 2 phases (présentation + quiz) ; il faut 5 étapes pédagogiques distinctes
4. **Parcours Protection & Sourates importantes** — 2 parcours non implémentés
5. **Objectif quotidien** — pas de concept de "leçon du jour" / objectif XP journalier
6. **Reprise automatique** — la dernière leçon en cours n'est pas sauvegardée
7. **Design system centralisé** — les constantes de couleur sont dupliquées dans chaque fichier (5 fois !)

---

## 2. Architecture Flutter cible

```
lib/
├── main.dart
├── home_screen.dart
├── quran_screen.dart
├── sourates_data.dart
│
└── learning/
    ├── core/
    │   ├── learning_colors.dart          ← Design system centralisé (NOUVEAU)
    │   ├── learning_models.dart          ← Modèles de données (ENRICHIR)
    │   ├── learning_service.dart         ← Persistance + logique métier (NOUVEAU)
    │   └── lesson_generator.dart         ← Génération leçons/exercices (ENRICHIR)
    │
    ├── screens/
    │   ├── learning_home_screen.dart     ← Accueil (ADAPTER → utiliser service)
    │   ├── learning_path_screen.dart     ← Parcours (ADAPTER)
    │   ├── lesson_screen.dart            ← Leçon 5 étapes (REFACTOR)
    │   ├── quiz_screen.dart              ← Tous types de quiz (NOUVEAU)
    │   ├── review_screen.dart            ← Flashcards révision (ADAPTER)
    │   └── progress_screen.dart          ← Stats & badges (ADAPTER)
    │
    └── widgets/
        ├── arabic_card.dart              ← Carte verset arabe réutilisable (NOUVEAU)
        ├── option_button.dart            ← Bouton réponse quiz (EXTRAIRE)
        └── xp_progress_bar.dart          ← Barre XP animée (EXTRAIRE)
```

---

## 3. Modèles de données — version enrichie

### 3.1 `LearningVerset` (enrichir l'existant)

```dart
class LearningVerset {
  final int    surahNumber;   // AJOUTER — pour relier au parcours
  final int    numero;
  final String arabe;
  final String phonetique;
  final String francais;
  MasteryLevel mastery;
  int          reviewCount;
  DateTime?    lastReviewed;
  int          xpEarned;     // AJOUTER — XP cumulés sur ce verset

  // Algorithme de répétition espacée (simplifié)
  // Intervalles : learning=4h, reviewing=24h, mastered=7j
  bool get needsReview {
    if (mastery == MasteryLevel.notSeen) return false;
    final diff = DateTime.now().difference(lastReviewed ?? DateTime(2000)).inHours;
    switch (mastery) {
      case MasteryLevel.learning:   return diff >= 4;
      case MasteryLevel.reviewing:  return diff >= 24;
      case MasteryLevel.mastered:   return diff >= 168; // 7 jours
      default: return false;
    }
  }
}
```

### 3.2 `ExerciseType` (enrichir l'existant)

```dart
enum ExerciseType {
  listenChoose,   // ← EXISTANT : voir arabe → choisir traduction (MCQ)
  fillBlank,      // ← EXISTANT : voir arabe → choisir phonétique (MCQ)
  arrange,        // ← NOUVEAU : remettre les mots dans l'ordre
  matchPairs,     // ← NOUVEAU : associer arabe ↔ phonétique
  translateChoice,// ← NOUVEAU : voir traduction → choisir arabe
}
```

### 3.3 `LessonStep` (NOUVEAU)

```dart
// Représente une des 5 étapes pédagogiques
enum LessonStep {
  discover,     // Étape 1 : Découverte — arabe + animation
  pronounce,    // Étape 2 : Lecture — arabe + phonétique côte à côte
  understand,   // Étape 3 : Compréhension — traduction + sens
  practice,     // Étape 4 : Exercice / quiz interactif
  validate,     // Étape 5 : Validation — récap + XP
}
```

### 3.4 `UserStats` (enrichir l'existant)

```dart
class UserStats {
  // EXISTANTS
  int xp, streak, level, totalExercises, correctExercises;
  DateTime? lastActivity;
  Map<int, MasteryLevel> surahMastery;

  // AJOUTER
  int  dailyXpGoal;          // Objectif XP journalier (défaut : 50)
  int  dailyXpToday;         // XP gagnés aujourd'hui
  int? lastLessonSurahNum;   // Reprise automatique
  LearningPathType? lastPathType;

  bool get dailyGoalReached => dailyXpToday >= dailyXpGoal;

  // Sérialisation JSON pour shared_preferences
  Map<String, dynamic> toJson() => { ... };
  factory UserStats.fromJson(Map<String, dynamic> json) => ...;
}
```

### 3.5 `LearningPath` (NOUVEAU — parcours étendu)

```dart
class LearningPath {
  final LearningPathType type;
  final String title, subtitle, emoji, description;
  final Color primary, light;
  final List<int> surahNumbers;
  final bool isLocked;           // Protection = débloqué après Débutant
  final String unlockCondition;  // "Termine le parcours Débutant"
}
```

### 3.6 Parcours manquants à ajouter dans `lesson_generator.dart`

```dart
// Protection (sourates de protection)
static const _protectionNums = [113, 114, 2, 255, 1]; // Falaq, Nas, Ayat Al-Kursi, Fatiha

// Sourates importantes
static const _importantNums  = [36, 67, 18, 55, 56, 1, 2];

// Juz Amma complet — déjà existant (37 sourates : 78–114)
```

---

## 4. Design system centralisé

**Problème actuel :** les couleurs sont copiées-collées dans 5 fichiers différents.
**Solution :** créer `lib/learning/core/learning_colors.dart`

```dart
// lib/learning/core/learning_colors.dart

class LNColors {
  // Fond & surfaces
  static const bg         = Color(0xFFFFFEF7);
  static const white      = Color(0xFFFFFFFF);
  static const border     = Color(0xFFE5E5E5);

  // Texte
  static const text       = Color(0xFF3C3C3C);
  static const textLight  = Color(0xFF777777);

  // Vert (correct / succès)
  static const green      = Color(0xFF58C900);
  static const greenDark  = Color(0xFF3DAA00);
  static const greenLight = Color(0xFFE8F9D0);

  // Rouge (erreur)
  static const red        = Color(0xFFFF4B4B);
  static const redLight   = Color(0xFFFFEBEB);

  // Or (XP / gold)
  static const gold       = Color(0xFFFFB020);
  static const goldLight  = Color(0xFFFFF4DC);

  // Bleu (phonétique / info)
  static const blue       = Color(0xFF1CB0F6);
  static const blueLight  = Color(0xFFE7F7FF);

  // Orange (streak)
  static const orange     = Color(0xFFFF9600);
  static const orangeLight= Color(0xFFFFF0D0);

  // Violet (niveau / parcours libre)
  static const purple     = Color(0xFF8549BA);
  static const purpleLight= Color(0xFFF0E8FF);
}
```

**Migration** : dans chaque écran, remplacer `const _green = Color(...)` par `import 'core/learning_colors.dart'` et utiliser `LNColors.green`.

---

## 5. Service de persistance (NOUVEAU)

**Fichier :** `lib/learning/core/learning_service.dart`

```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LearningService {
  static const _keyStats    = 'learning_stats';
  static const _keyProgress = 'learning_progress'; // mastery par verset

  // ── Sauvegarder les stats utilisateur
  static Future<void> saveStats(UserStats stats) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyStats, jsonEncode(stats.toJson()));
  }

  // ── Charger les stats (ou créer des stats vierges)
  static Future<UserStats> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyStats);
    if (raw == null) return UserStats();
    return UserStats.fromJson(jsonDecode(raw));
  }

  // ── Sauvegarder la progression verset par verset
  // Clé : "surah_{num}_verset_{num}" → MasteryLevel.index
  static Future<void> saveVersetMastery(int surah, int verset, MasteryLevel m) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mastery_${surah}_$verset', m.index);
  }

  static Future<MasteryLevel> loadVersetMastery(int surah, int verset) async {
    final prefs = await SharedPreferences.getInstance();
    final idx = prefs.getInt('mastery_${surah}_$verset') ?? 0;
    return MasteryLevel.values[idx];
  }

  // ── Mise à jour XP journalier (reset chaque nouveau jour)
  static Future<void> updateDailyXP(UserStats stats, int xpGained) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final lastDay = prefs.getString('daily_xp_date') ?? '';
    final todayStr = '${today.year}-${today.month}-${today.day}';
    if (lastDay != todayStr) {
      stats.dailyXpToday = 0;
      await prefs.setString('daily_xp_date', todayStr);
    }
    stats.dailyXpToday += xpGained;
    await saveStats(stats);
  }
}
```

**Dépendance à ajouter dans `pubspec.yaml` :**
```yaml
dependencies:
  shared_preferences: ^2.2.2
```

---

## 6. Logique de génération des leçons — version complète

### 6.1 Principe de découpage

Toutes les sourates longues (> 10 versets) doivent être découpées en **micro-leçons de 3 à 5 versets** pour rester dans la limite des 1-2 minutes.

```dart
// Dans lesson_generator.dart — méthode à ajouter
static List<LearningLesson> buildChunkedLesson(Sourate s) {
  const chunkSize = 4; // max 4 versets par leçon
  final chunks = <LearningLesson>[];

  for (int i = 0; i < s.versets.length; i += chunkSize) {
    final end = (i + chunkSize).clamp(0, s.versets.length);
    final slice = s.versets.sublist(i, end);
    chunks.add(LearningLesson(
      surahNumber: s.numero,
      surahName: '${s.nomArabe} (${i ~/ chunkSize + 1}/${(s.versets.length / chunkSize).ceil()})',
      surahNameFr: s.nomFrancais,
      signification: s.signification,
      icon: _icons[s.numero] ?? '📖',
      xpReward: 10 + slice.length * 3,
      isUnlocked: i == 0,
      versets: slice.map((v) => LearningVerset(
        surahNumber: s.numero,
        numero: v.numero,
        arabe: v.arabe,
        phonetique: v.phonetique,
        francais: v.francais,
      )).toList(),
    ));
  }
  return chunks;
}
```

### 6.2 Génération automatique de tous les types d'exercices

```dart
// Dans lesson_generator.dart — enrichir generateExercises()
static List<Exercise> generateExercises(LearningLesson lesson) {
  final all = lesson.versets;
  if (all.isEmpty) return [];

  final exercises = <Exercise>[];
  final poolFr    = all.map((v) => v.francais).toList();
  final poolPho   = all.map((v) => v.phonetique).toList();

  for (final v in all) {
    // Type 1 : Voir arabe → choisir traduction (MCQ)
    exercises.add(Exercise(
      type: ExerciseType.listenChoose,
      verset: v,
      correctAnswer: v.francais,
      options: _buildOptions(v.francais, poolFr),
    ));

    // Type 2 : Voir traduction → choisir arabe (MCQ inversé)
    if (all.length >= 2) {
      exercises.add(Exercise(
        type: ExerciseType.translateChoice,
        verset: v,
        correctAnswer: v.arabe,
        options: _buildOptions(v.arabe, all.map((x) => x.arabe).toList()),
      ));
    }

    // Type 3 : Voir arabe → choisir phonétique
    if (all.length >= 2) {
      exercises.add(Exercise(
        type: ExerciseType.fillBlank,
        verset: v,
        correctAnswer: v.phonetique,
        options: _buildOptions(v.phonetique, poolPho),
      ));
    }

    // Type 4 : Remise en ordre des mots (phonétique)
    // Découper la phonétique en mots, mélanger
    final words = v.phonetique.split(' ');
    if (words.length >= 3) {
      final shuffled = [...words]..shuffle();
      exercises.add(Exercise(
        type: ExerciseType.arrange,
        verset: v,
        correctAnswer: v.phonetique,
        options: shuffled, // les mots mélangés à remettre dans l'ordre
      ));
    }
  }

  // Limiter à 6 exercices max par leçon, mélangés
  exercises.shuffle();
  return exercises.take(6).toList();
}
```

---

## 7. Structure d'une leçon en 5 étapes — `lesson_screen.dart` refactorisé

### Architecture de l'écran

```
LessonScreen
│
├── _LessonState
│   ├── _currentStep : LessonStep (5 étapes)
│   ├── _versetIdx   : int (index verset en cours)
│   ├── _exerciseIdx : int (index exercice en cours)
│   │
│   ├── Étape 1 : _DiscoverWidget       — grand arabe animé
│   ├── Étape 2 : _PronounceWidget      — arabe + phonétique en miroir
│   ├── Étape 3 : _UnderstandWidget     — traduction + sens du mot-clé
│   ├── Étape 4 : _ExerciseWidget       — dispatch selon ExerciseType
│   │   ├── _MCQWidget                  — choix multiple (existant)
│   │   ├── _ArrangeWidget              — glisser-déposer mots
│   │   └── _MatchWidget                — association pairs
│   └── Étape 5 : _ValidateWidget       — récap + XP animé + confettis
```

### Flux de navigation entre étapes

```
Pour chaque verset dans la leçon :
  → Étape 1 : Découverte  (swipe ou bouton "J'ai lu")
  → Étape 2 : Prononciation  (bouton "Compris")
  → Étape 3 : Compréhension  (bouton "Suivant")
  → Étape 4 : Exercice  (validation automatique selon réponse)

Après tous les versets :
  → Étape 5 : Validation globale (score + XP + badges)
```

### Code squelette du nouveau `lesson_screen.dart`

```dart
class _LessonScreenState extends State<LessonScreen> {
  LessonStep _step    = LessonStep.discover;
  int        _vIdx    = 0;    // verset en cours
  int        _exIdx   = 0;    // exercice en cours
  int        _score   = 0;
  int        _hearts  = 5;

  late List<LearningVerset> _versets;
  late List<Exercise>        _exercises;

  LearningVerset get _currentVerset => _versets[_vIdx];

  void _advance() {
    switch (_step) {
      case LessonStep.discover:
        setState(() => _step = LessonStep.pronounce);
        break;
      case LessonStep.pronounce:
        setState(() => _step = LessonStep.understand);
        break;
      case LessonStep.understand:
        // Chercher un exercice pour ce verset
        setState(() { _step = LessonStep.practice; });
        break;
      case LessonStep.practice:
        if (_vIdx + 1 < _versets.length) {
          setState(() { _vIdx++; _step = LessonStep.discover; });
        } else {
          setState(() => _step = LessonStep.validate);
        }
        break;
      case LessonStep.validate:
        Navigator.pop(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(step: _step, total: _versets.length, index: _vIdx, hearts: _hearts),
            Expanded(child: _buildStep()),
          ],
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case LessonStep.discover:   return _DiscoverStep(v: _currentVerset, onNext: _advance);
      case LessonStep.pronounce:  return _PronounceStep(v: _currentVerset, onNext: _advance);
      case LessonStep.understand: return _UnderstandStep(v: _currentVerset, onNext: _advance);
      case LessonStep.practice:   return _PracticeStep(
        exercises: _exercises.where((e) => e.verset.numero == _currentVerset.numero).toList(),
        onCorrect: () { _score++; _advance(); },
        onWrong:   () { setState(() => _hearts = (_hearts - 1).clamp(0, 5)); _advance(); },
      );
      case LessonStep.validate:   return _ValidateStep(
        lesson: widget.lesson, score: _score, total: _exercises.length, onDone: () => Navigator.pop(context),
      );
    }
  }
}
```

---

## 8. Logique de quiz — nouveaux types d'exercices

### Type 1 : MCQ Traduction (existant — à conserver)
```
Question : [Texte arabe]
Options A / B / C / D  ← traductions françaises
```

### Type 2 : Remise en ordre (`ExerciseType.arrange`)
```
Afficher : "Remets les mots dans le bon ordre"
Mots mélangés : [wa], [anna], [alladhina], [kafarou]
L'utilisateur glisse les mots pour reformer la phonétique
Validation : comparaison avec la phonétique originale
```

**Widget `_ArrangeWidget` :**
```dart
class _ArrangeWidget extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onCorrect, onWrong;

  // Utilise ReorderableListView ou DragTarget
  // options = mots mélangés (List<String>)
  // correctAnswer = phonétique complète
}
```

### Type 3 : Association (`ExerciseType.matchPairs`)
```
Gauche (arabe)         Droite (phonétique)
  بِسۡمِ  ●──────?──── ●  Bismillah
  ٱلرَّحۡمَٰنِ  ●──────?──── ●  Al-Rahman
  ٱلرَّحِيمِ  ●──────?──── ●  Al-Rahim
```

**Widget :** utiliser `GestureDetector` avec sélection + liaison visuelle.

### Type 4 : MCQ inversé (`ExerciseType.translateChoice`)
```
Question : "Seigneur des univers"  ← traduction affichée
Options : 4 textes arabes différents
Réponse attendue : le bon texte arabe
```

---

## 9. Logique de révision intelligente

### Algorithme de répétition espacée (SRS simplifié)

Inspiré de SM-2 mais adapté au mobile :

```
Niveau 0 (notSeen)     → jamais vu
Niveau 1 (learning)    → révision dans 4 heures
Niveau 2 (reviewing)   → révision dans 24 heures
Niveau 3 (mastered)    → révision dans 7 jours
```

### Logique dans `LessonGenerator.getReviewDue()`

```dart
static List<LearningVerset> getReviewDue(List<LearningLesson> lessons) {
  final now = DateTime.now();
  final due = <LearningVerset>[];
  for (final lesson in lessons) {
    for (final v in lesson.versets) {
      if (v.mastery == MasteryLevel.notSeen) continue;
      if (v.lastReviewed == null) { due.add(v); continue; }
      final hours = now.difference(v.lastReviewed!).inHours;
      final threshold = switch (v.mastery) {
        MasteryLevel.learning  => 4,
        MasteryLevel.reviewing => 24,
        MasteryLevel.mastered  => 168, // 7 jours
        _ => 9999,
      };
      if (hours >= threshold) due.add(v);
    }
  }
  due.shuffle();
  return due.take(10).toList(); // max 10 versets par session
}
```

### Mise à jour de la maîtrise après révision

```dart
// Dans review_screen.dart — méthode _respond()
void _respond(bool mastered) {
  final v = widget.versets[_index];
  v.reviewCount++;
  v.lastReviewed = DateTime.now();

  if (mastered) {
    // Progression d'un niveau
    switch (v.mastery) {
      case MasteryLevel.learning:   v.mastery = MasteryLevel.reviewing;
      case MasteryLevel.reviewing:  v.mastery = MasteryLevel.mastered;
      default: break;
    }
    widget.stats.addXP(5);
  } else {
    // Retour à learning si on se trompe
    v.mastery = MasteryLevel.learning;
  }

  // Persister
  LearningService.saveVersetMastery(v.surahNumber, v.numero, v.mastery);
  LearningService.saveStats(widget.stats);
}
```

---

## 10. Parcours d'apprentissage complets

| Parcours | Sourates | Leçons | Couleur | Condition de déblocage |
|---|---|---|---|---|
| 🌱 Débutant | 112–114, 108–96, 1 | 20 | Vert | Toujours débloqué |
| 🕌 Prière | 1, 112–114, 87–88, 36, 67 | 9 | Bleu | Toujours débloqué |
| 🛡️ Protection | 113, 114, 2:255, 1 | 5 | Violet | Après 5 leçons Débutant |
| ⭐ Importantes | 36, 67, 18, 55, 56 | 8 | Or | Après 10 leçons |
| 📖 Juz Amma | Sourates 78–114 | 37 | Orange | Après parcours Débutant |
| 🔓 Mode Libre | Toutes (1–114) | 114 | Gris | Toujours débloqué |

---

## 11. Objectif quotidien

### Dans `UserStats`
```dart
int  dailyXpGoal  = 50;    // Configurable : 20 / 50 / 100 XP
int  dailyXpToday = 0;
bool get goalReached => dailyXpToday >= dailyXpGoal;
```

### Widget dans `learning_home_screen.dart`
```dart
// Afficher juste après le banner "Continuer"
Container(
  child: Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Objectif du jour · ${stats.dailyXpToday}/${stats.dailyXpGoal} XP"),
        if (stats.goalReached) Text("✅ Atteint !")
      ]
    ),
    LinearProgressIndicator(
      value: (stats.dailyXpToday / stats.dailyXpGoal).clamp(0.0, 1.0),
    ),
  ])
)
```

---

## 12. Plan de développement étape par étape

### PHASE 1 — Fondations (2-3 jours) 🏗️

**Objectif :** tout ce qui existe fonctionne durablement.

**Tâches :**
1. Créer `lib/learning/core/learning_colors.dart` — centralisr toutes les couleurs
2. Migrer les 5 fichiers pour utiliser `LNColors.*` à la place des constantes locales
3. Ajouter `shared_preferences` dans `pubspec.yaml`
4. Créer `lib/learning/core/learning_service.dart` avec `saveStats()` / `loadStats()`
5. Enrichir `UserStats` avec `toJson()` / `fromJson()` / `dailyXpToday` / `lastLessonSurahNum`
6. Enrichir `LearningVerset` avec `surahNumber` (nécessaire pour la persistance)
7. Dans `LearningHomeScreen.initState()` : charger les stats via `LearningService.loadStats()`

**Validation :** relancer l'app → les stats (streak, XP) sont conservées entre sessions.

---

### PHASE 2 — Leçon en 5 étapes (3-4 jours) 📚

**Objectif :** chaque leçon suit le parcours pédagogique complet.

**Tâches :**
1. Ajouter `enum LessonStep` dans `learning_models.dart`
2. Créer `lib/learning/widgets/arabic_card.dart` — widget réutilisable carte arabe
3. Créer `lib/learning/widgets/option_button.dart` — extraire `_OptionButton` de `lesson_screen.dart`
4. Refactoriser `lesson_screen.dart` :
   - Remplacer `_Phase` (2 étapes) par `LessonStep` (5 étapes)
   - Créer les 5 widgets correspondants (`_DiscoverStep`, etc.)
5. Créer `lib/learning/widgets/xp_progress_bar.dart`
6. Sauvegarder la progression après chaque leçon via `LearningService`

**Validation :** une leçon se déroule en 5 étapes claires, avec une transition animée entre chaque.

---

### PHASE 3 — Nouveaux types d'exercices (3-4 jours) 🎯

**Objectif :** varier les exercices pour maintenir l'engagement.

**Tâches :**
1. Ajouter `ExerciseType.arrange`, `matchPairs`, `translateChoice` dans les modèles
2. Créer `lib/learning/screens/quiz_screen.dart` — écran de quiz autonome (appelable depuis lesson ou révision)
3. Implémenter `_ArrangeWidget` (drag-and-drop mots)
4. Implémenter `_MatchWidget` (association arabe ↔ phonétique)
5. Implémenter `_TranslateChoiceWidget` (MCQ inversé)
6. Enrichir `LessonGenerator.generateExercises()` pour générer tous les types

**Validation :** une leçon propose au moins 3 types d'exercices différents.

---

### PHASE 4 — Révision intelligente (2 jours) 🔄

**Objectif :** le SRS fonctionne et les versets reviennent au bon moment.

**Tâches :**
1. Mettre à jour `getReviewDue()` avec les 3 intervalles (4h, 24h, 7j)
2. Mettre à jour `_respond()` dans `review_screen.dart` pour faire évoluer le niveau de maîtrise
3. Persister la maîtrise de chaque verset après chaque révision
4. Tester sur au moins 5 versets : vérifier que les intervalles fonctionnent

**Validation :** un verset marqué "Maîtrisé" le mardi n'apparaît pas en révision avant le mardi suivant.

---

### PHASE 5 — Parcours & objectif quotidien (2 jours) 🏅

**Objectif :** tous les parcours sont disponibles et l'objectif journalier motive.

**Tâches :**
1. Ajouter les 2 parcours manquants dans `lesson_generator.dart` (Protection, Importantes)
2. Ajouter un 6e parcours dans `learning_path_screen.dart`
3. Implémenter la logique de déblocage conditionnel (`isLocked` selon progression)
4. Ajouter le widget Objectif quotidien dans `LearningHomeScreen`
5. Ajouter la reprise automatique de la dernière leçon (sauvegarder `lastLessonSurahNum`)

**Validation :** le bandeau "Continuer" pointe vers la bonne leçon au redémarrage.

---

### PHASE 6 — Polish & animations (2 jours) ✨

**Objectif :** l'expérience est fluide et motivante.

**Tâches :**
1. Ajouter une animation de confettis sur l'écran de résultats (package `confetti`)
2. Ajouter une animation de level-up quand XP franchit un palier
3. Finaliser les badges dans `progress_screen.dart` (déclencher selon vraie progression)
4. Ajouter un son de feedback (correct/incorrect) si l'utilisateur active le son
5. Test end-to-end : parcourir chaque parcours de A à Z

---

## 13. Priorités immédiates

**Ce que tu dois faire maintenant, dans cet ordre :**

1. `flutter pub add shared_preferences` dans le terminal
2. Créer `learning_colors.dart` (20 min)
3. Ajouter `toJson`/`fromJson` à `UserStats` (30 min)
4. Créer `learning_service.dart` (45 min)
5. Modifier `LearningHomeScreen.initState()` pour charger les stats (15 min)

Avec ça, ta base est solide et tout ce qui viendra ensuite s'appuiera sur des fondations stables.

---

## 14. Ce que tu peux déjà tester aujourd'hui

Ton module actuel fonctionne déjà pour :
- ✅ Le parcours Débutant de bout en bout
- ✅ La révision flashcard avec flip 3D
- ✅ L'écran de résultats avec XP
- ✅ Le déblocage progressif des leçons

Les écrans `LearningHomeScreen`, `LearningPathScreen`, `LessonScreen` et `ReviewScreen` sont fonctionnels et bien designés. La priorité n'est pas de réécrire ce qui marche, mais d'ajouter la couche persistance et d'enrichir les exercices.

---

*Document généré pour l'application Nour — Architecture V1 complète*
*Toutes les sourates du Coran (1–114) sont disponibles dans `sourates_data.dart`*
