import 'dart:async' show unawaited;
import 'package:flutter/material.dart';
import '../translations.dart';
import '../app_locale.dart';
import 'learning_models.dart';
import 'learning_service.dart';
import 'audio_verse_widget.dart';

String _s(String fr, String en) => AppLocale().isFrench ? fr : en;

// ── Palette UpYourDeen ──────────────────────────────────────────────────
const _kGreenDeep    = Color(0xFF0A2018);
const _kGreenPrimary = Color(0xFF1B4D38);
const _kGreenMedium  = Color(0xFF2A7A52);
const _kGold         = Color(0xFFC8933A);
const _kGoldLight    = Color(0xFFFFF4DC);
const _kBeige        = Color(0xFFF6F0E3);
const _kBeigeCard    = Color(0xFFFFFFFF);
const _kBeigeBorder  = Color(0xFFD6C9AF);
const _kTextDark     = Color(0xFF1A130A);
const _kTextLight    = Color(0xFF8A7863);

// Couleurs complémentaires conservées pour les exercices
const _kBlue         = Color(0xFF1CB0F6);
const _kBlueLight    = Color(0xFFE7F7FF);
const _kGreenLight   = Color(0xFFE8F4EE);
const _kRed          = Color(0xFFFF4B4B);
const _kRedLight     = Color(0xFFFFEBEB);


// ─── Lesson Phase (5 étapes pédagogiques) ─────────────────────────
// discover   : Lire le verset (arabe + phonétique + traduction)
// practice   : Exercices MCQ / arrangement
// result     : Récapitulatif + XP
enum _Phase { discover, practice, result }

// ─── Lesson Screen ────────────────────────────────────────────────
class LessonScreen extends StatefulWidget {
  final LearningLesson lesson;
  const LessonScreen({super.key, required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> with TickerProviderStateMixin {
  // ── State ──────────────────────────────────────────────────────
  _Phase  _phase     = _Phase.discover;
  int     _versetIdx = 0;    // index dans la phase discover
  int     _quizIdx   = 0;    // index dans la phase practice
  String? _selected;
  bool    _answered  = false;
  int     _hearts    = 5;
  int     _score     = 0;
  int     _totalQ    = 0;

  // Pour l'exercice "arrange"
  List<String>  _arrangeSelected  = [];
  List<String>  _arrangeRemaining = [];

  late List<LearningVerset> _versets;
  late List<Exercise>        _quizzes;

  // ── Animations ─────────────────────────────────────────────────
  late AnimationController _progressCtrl;
  late Animation<double>   _progressAnim;
  late AnimationController _feedbackCtrl;
  late Animation<double>   _feedbackAnim;
  late AnimationController _cardCtrl;
  late Animation<Offset>   _cardAnim;
  late AnimationController _celebCtrl;
  late Animation<double>   _celebAnim;

  @override
  void initState() {
    super.initState();
    _versets = widget.lesson.versets;
    _quizzes = _buildQuizzes();
    _totalQ  = _quizzes.length;

    _progressCtrl = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _progressAnim = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _progressCtrl, curve: Curves.easeInOut));

    _feedbackCtrl = AnimationController(duration: const Duration(milliseconds: 350), vsync: this);
    _feedbackAnim = CurvedAnimation(parent: _feedbackCtrl, curve: Curves.easeOut);

    _cardCtrl = AnimationController(duration: const Duration(milliseconds: 280), vsync: this);
    _cardAnim = Tween<Offset>(begin: Offset.zero, end: const Offset(-1.3, 0)).animate(
        CurvedAnimation(parent: _cardCtrl, curve: Curves.easeInCubic));

    _celebCtrl = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _celebAnim = CurvedAnimation(parent: _celebCtrl, curve: Curves.elasticOut);

    _updateProgress(0);
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    _feedbackCtrl.dispose();
    _cardCtrl.dispose();
    _celebCtrl.dispose();
    super.dispose();
  }

  void _updateProgress(double target) {
    final old = _progressAnim.value;
    _progressAnim = Tween<double>(begin: old, end: target.clamp(0.0, 1.0)).animate(
        CurvedAnimation(parent: _progressCtrl, curve: Curves.easeInOut));
    _progressCtrl.forward(from: 0);
  }

  double get _progressValue {
    final total = _versets.length + _totalQ;
    if (total == 0) return 0;
    if (_phase == _Phase.discover)  return _versetIdx / total;
    if (_phase == _Phase.practice)  return (_versets.length + _quizIdx) / total;
    return 1.0;
  }

  // ── Build quiz list ────────────────────────────────────────────
  List<Exercise> _buildQuizzes() {
    final all = widget.lesson.versets;
    if (all.isEmpty) return [];

    // Pool global de mots phonétiques (pour les distracteurs fill-blank)
    final allPhonWords = all
        .expand((v) => v.phonetique.split(' '))
        .toSet()
        .toList();

    final quizzes = <Exercise>[];
    final poolTranslations = all.map((v) => v.traduction).toList();

    for (final v in all) {
      final phonWords = v.phonetique.split(' ');

      // ── 1. Mot manquant dans la phonétique ──────────────────────
      if (phonWords.length >= 2) {
        // Préférer les mots longs (plus significatifs à retenir)
        final candidates = phonWords.where((w) => w.length >= 4).toList();
        final pool2      = candidates.isNotEmpty ? candidates : List<String>.from(phonWords);
        pool2.shuffle();
        final chosen     = pool2.first;
        final blanked    = v.phonetique.replaceFirst(chosen, '___');

        quizzes.add(Exercise(
          type:          ExerciseType.fillBlank,
          verset:        v,
          correctAnswer: chosen,
          options:       _buildPhonOptions(chosen, allPhonWords),
          hint:          blanked,
        ));
      }

      // ── 2. Reconstituer la phonétique dans l'ordre ──────────────
      if (phonWords.length >= 3) {
        final shuffled = List<String>.from(phonWords)..shuffle();
        // S'assurer que l'ordre est réellement différent
        while (shuffled.join(' ') == v.phonetique) {
          shuffled.shuffle();
        }
        quizzes.add(Exercise(
          type:          ExerciseType.arrange,
          verset:        v,
          correctAnswer: v.phonetique,
          options:       shuffled,
        ));
      }

      // ── 3. Traduction (MCQ) – contexte sémantique ───────────────
      quizzes.add(Exercise(
        type:          ExerciseType.listenChoose,
        verset:        v,
        correctAnswer: v.traduction,
        options:       _buildOptions(v.traduction, poolTranslations),
      ));
    }

    quizzes.shuffle();
    return quizzes;
  }

  List<String> _buildOptions(String correct, List<String> pool) {
    const fallbacks = [
      'Au nom d\'Allah, le Tout Miséricordieux',
      'Louange à Allah, Seigneur des univers',
      'Dis : Il est Allah, Unique',
      'Et Il n\'a pas d\'égal',
    ];
    final wrong = pool.where((o) => o != correct).toList()..shuffle();
    final opts  = <String>[correct];
    for (final w in [...wrong, ...fallbacks]) {
      if (opts.length >= 4) break;
      if (!opts.contains(w)) opts.add(w);
    }
    return opts..shuffle();
  }

  List<String> _buildPhonOptions(String correct, List<String> allWords) {
    const fallbacks = ['bismillah', 'rahman', 'rahim', 'allahu', 'karim', 'hakim', 'aziz'];
    final wrong = allWords
        .where((w) => w != correct && w.length >= 2)
        .toList()
      ..shuffle();
    final opts = <String>[correct];
    for (final w in [...wrong, ...fallbacks]) {
      if (opts.length >= 4) break;
      if (!opts.contains(w)) opts.add(w);
    }
    return opts..shuffle();
  }

  // ── Navigation: discover ──────────────────────────────────────
  Future<void> _nextPresentation() async {
    await _cardCtrl.forward();
    _cardCtrl.reset();
    if (_versetIdx + 1 >= _versets.length) {
      setState(() { _phase = _Phase.practice; _quizIdx = 0; });
      _initArrange();
    } else {
      setState(() => _versetIdx++);
    }
    _updateProgress(_progressValue);
  }

  // ── Arrange helpers ───────────────────────────────────────────
  void _initArrange() {
    if (_quizzes.isEmpty) return;
    final q = _quizzes[_quizIdx];
    if (q.type == ExerciseType.arrange) {
      setState(() {
        _arrangeRemaining = List<String>.from(q.options);
        _arrangeSelected  = [];
      });
    }
  }

  void _tapArrangeWord(String word) {
    setState(() {
      _arrangeRemaining.remove(word);
      _arrangeSelected.add(word);
    });
  }

  void _removeArrangeWord(int idx) {
    setState(() {
      _arrangeRemaining.add(_arrangeSelected[idx]);
      _arrangeSelected.removeAt(idx);
    });
  }

  void _submitArrange() {
    if (_answered || _arrangeSelected.isEmpty) return;
    final answer  = _arrangeSelected.join(' ');
    final correct = answer == _quizzes[_quizIdx].correctAnswer;
    setState(() {
      _selected = answer;
      _answered = true;
      if (correct) {
        _score++;
      } else {
        _hearts = (_hearts - 1).clamp(0, 5);
      }
    });
    _updateMastery(correct);
    _feedbackCtrl.forward(from: 0);
  }

  // ── Navigation: practice ──────────────────────────────────────
  void _onAnswer(String answer) {
    if (_answered) return;
    final correct = answer == _quizzes[_quizIdx].correctAnswer;
    setState(() {
      _selected = answer;
      _answered = true;
      if (correct) {
        _score++;
      } else {
        _hearts = (_hearts - 1).clamp(0, 5);
      }
    });
    _updateMastery(correct);
    _feedbackCtrl.forward(from: 0);
  }

  void _updateMastery(bool correct) {
    final v = _quizzes[_quizIdx].verset;
    v.reviewCount++;
    v.lastReviewed = DateTime.now();

    if (correct) {
      // Progression SRS : notSeen/learning → reviewing → mastered
      switch (v.mastery) {
        case MasteryLevel.notSeen:
        case MasteryLevel.learning:
          v.mastery = MasteryLevel.reviewing;
          break;
        case MasteryLevel.reviewing:
          v.mastery = MasteryLevel.mastered;
          break;
        case MasteryLevel.mastered:
          break;
      }
    } else {
      // Régression
      if (v.mastery == MasteryLevel.mastered) {
        v.mastery = MasteryLevel.reviewing;
      } else {
        v.mastery = MasteryLevel.learning;
      }
    }

    // Persistance asynchrone (fire-and-forget)
    unawaited(LearningService.instance.saveVersetMastery(
      v.surahNumber, v.numero, v.mastery, v.lastReviewed,
    ));
  }

  Future<void> _nextQuiz() async {
    if (_quizIdx + 1 >= _quizzes.length || _hearts == 0) {
      // Fin → sauvegarder les stats
      setState(() => _phase = _Phase.result);
      _celebCtrl.forward();
      _updateProgress(1.0);
    } else {
      setState(() { _quizIdx++; _selected = null; _answered = false; });
      _feedbackCtrl.reset();
      _initArrange();
      _updateProgress(_progressValue);
    }
  }

  // ── Build ─────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      body: SafeArea(
        child: Column(children: [
          _buildTopBar(context),
          Expanded(child: _buildBody()),
          if (_phase == _Phase.practice && _answered) _buildFeedback(),
        ]),
      ),
    );
  }

  // ── Top bar ───────────────────────────────────────────────────
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(children: [
        Row(children: [
          GestureDetector(
            onTap: () => _showQuitDialog(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kBeigeBorder.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.close_rounded, color: _kTextLight, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedBuilder(
              animation: _progressAnim,
              builder: (_, _) => Stack(children: [
                Container(height: 14, decoration: BoxDecoration(color: _kBeigeBorder, borderRadius: BorderRadius.circular(99))),
                FractionallySizedBox(
                  widthFactor: _progressAnim.value,
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF58C900), Color(0xFF3DAA00)]),
                      borderRadius: BorderRadius.circular(99),
                      boxShadow: [BoxShadow(color: _kGreenPrimary.withValues(alpha: 0.4), blurRadius: 6)],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(width: 12),
          // Hearts
          Row(
            children: List.generate(5, (i) => Padding(
              padding: const EdgeInsets.only(left: 2),
              child: AnimatedScale(
                scale: i < _hearts ? 1.0 : 0.6,
                duration: const Duration(milliseconds: 300),
                child: Text('❤️', style: TextStyle(
                  fontSize: 18,
                  color: i < _hearts ? Colors.red : Colors.grey.withValues(alpha: 0.3),
                )),
              ),
            )),
          ),
        ]),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_phase == _Phase.discover)
              _phaseBadge('📖 Lecture · Verset ${_versetIdx + 1}/${_versets.length}', _kBlueLight, _kBlue),
            if (_phase == _Phase.practice)
              _buildPhaseBadgePractice(),
          ],
        ),
      ]),
    );
  }

  Widget _buildPhaseBadgePractice() {
    if (_quizzes.isEmpty) return _phaseBadge('🎯 Exercice', _kGoldLight, _kGold);
    final type = _quizzes[_quizIdx].type;
    final icon = type == ExerciseType.fillBlank ? '🎤'
               : type == ExerciseType.arrange   ? '🔤'
               : '🎯';
    return _phaseBadge('$icon Exercice ${_quizIdx + 1}/${_quizzes.length}', _kGoldLight, _kGold);
  }

  Widget _phaseBadge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w700)),
    );
  }

  // ── Body dispatcher ───────────────────────────────────────────
  Widget _buildBody() {
    switch (_phase) {
      case _Phase.discover:  return _buildPresentation();
      case _Phase.practice:  return _buildQuiz();
      case _Phase.result:    return _buildResult();
    }
  }

  // ── Discover Phase ────────────────────────────────────────────
  Widget _buildPresentation() {
    if (_versets.isEmpty) return Center(child: Text(_s('Aucun verset', 'No verse')));
    final v = _versets[_versetIdx];

    return SlideTransition(
      position: _cardAnim,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(children: [
          Text(_s('Lis attentivement ce verset', 'Read this verse carefully'),
              style: const TextStyle(color: _kTextLight, fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),

          // Arabic card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(color: const Color(0xFF1B5E20).withValues(alpha: 0.35), blurRadius: 24, offset: const Offset(0, 8)),
              ],
            ),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(_s('Verset ${v.numero}', 'Verse ${v.numero}'),
                    style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 20),
              Text(v.arabe,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Color(0xFFFFE082), fontSize: 28, fontWeight: FontWeight.w600,
                  height: 2.2, fontFamily: 'serif',
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),

          // Phonétique
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _kBlueLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _kBlue.withValues(alpha: 0.25)),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.volume_up_rounded, color: _kBlue, size: 16),
                const SizedBox(width: 6),
                Text(_s('PHONÉTIQUE', 'PHONETIC'), style: const TextStyle(color: _kBlue, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
              ]),
              const SizedBox(height: 10),
              Text(v.phonetique,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF1565C0), fontSize: 16, fontStyle: FontStyle.italic, height: 1.5, fontWeight: FontWeight.w600),
              ),
            ]),
          ),
          const SizedBox(height: 12),

          // Traduction
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _kGoldLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _kGold.withValues(alpha: 0.3)),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('🌍', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(_s('TRADUCTION', 'TRANSLATION'), style: const TextStyle(color: Color(0xFFB06000), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
              ]),
              const SizedBox(height: 10),
              Text(v.traduction,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF7A4200), fontSize: 15, height: 1.6, fontWeight: FontWeight.w600),
              ),
            ]),
          ),
          const SizedBox(height: 16),

          // Audio verset par verset
          AudioVerseWidget(
            surahNumber: v.surahNumber,
            ayahNumber:  v.numero,
          ),
          const SizedBox(height: 16),

          // CTA
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextPresentation,
              style: ElevatedButton.styleFrom(
                backgroundColor: _kGreenPrimary,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: _kGreenPrimary.withValues(alpha: 0.4),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: Text(
                _versetIdx + 1 >= _versets.length ? 'Passer au Quiz →' : 'Verset suivant →',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // ── Quiz Phase ────────────────────────────────────────────────
  Widget _buildQuiz() {
    if (_quizzes.isEmpty) return Center(child: Text(_s('Aucun exercice', 'No exercise')));
    final quiz = _quizzes[_quizIdx];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: switch (quiz.type) {
        ExerciseType.arrange   => _buildArrangeQuiz(quiz),
        ExerciseType.fillBlank => _buildFillBlankQuiz(quiz),
        _                      => _buildMcqQuiz(quiz),
      },
    );
  }

  // ── Fill-Blank Quiz ───────────────────────────────────────────
  Widget _buildFillBlankQuiz(Exercise quiz) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: _kBlueLight, borderRadius: BorderRadius.circular(16)),
          child: const Text(
            '🎤 Quel mot manque dans la phonétique ?',
            style: TextStyle(color: Color(0xFF1565C0), fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 20),

        // Arabe
        _buildArabicCard(quiz.verset, showPhonetic: false),
        const SizedBox(height: 16),

        // Phonétique avec le trou
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: _kBlueLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _kBlue.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.volume_up_rounded, color: _kBlue, size: 16),
              SizedBox(width: 6),
              Text(_s('PHONÉTIQUE', 'PHONETIC'), style: TextStyle(color: _kBlue, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
            ]),
            const SizedBox(height: 12),
            _buildBlankedLine(quiz),
          ]),
        ),
        const SizedBox(height: 24),

        // Options MCQ
        ...quiz.options.map((opt) => _OptionButton(
          text:     opt,
          correct:  quiz.correctAnswer,
          selected: _selected,
          answered: _answered,
          onTap:    () => _onAnswer(opt),
        )),
      ],
    );
  }

  /// Affiche la phonétique avec le mot manquant mis en évidence.
  Widget _buildBlankedLine(Exercise quiz) {
    final hint  = quiz.hint ?? quiz.verset.phonetique;
    final parts = hint.split('___');
    final before = parts[0];
    final after  = parts.length > 1 ? parts[1] : '';

    final blankText = _answered ? (_selected ?? '?') : '  ?  ';
    final blankColor = _answered
        ? (_selected == quiz.correctAnswer ? _kGreenPrimary : _kRed)
        : _kBlue;

    return Wrap(
      alignment:      WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4, runSpacing: 6,
      children: [
        if (before.trim().isNotEmpty)
          Text(
            before.trim(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1565C0), fontSize: 15,
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w600,
            ),
          ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color:        blankColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border:       Border.all(color: blankColor, width: 2),
          ),
          child: Text(
            blankText,
            style: TextStyle(
              color: blankColor, fontSize: 15, fontWeight: FontWeight.w900,
            ),
          ),
        ),
        if (after.trim().isNotEmpty)
          Text(
            after.trim(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1565C0), fontSize: 15,
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  // ── MCQ Quiz ──────────────────────────────────────────────────
  Widget _buildMcqQuiz(Exercise quiz) {
    final instruction = quiz.type == ExerciseType.listenChoose
        ? '🎯 Quelle est la traduction de ce verset ?'
        : '📖 Quel est le texte arabe de cette traduction ?';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: _kGoldLight, borderRadius: BorderRadius.circular(16)),
          child: Text(instruction,
              style: const TextStyle(color: Color(0xFFB06000), fontSize: 13, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 20),

        // Display
        _buildArabicCard(quiz.verset, showPhonetic: quiz.type == ExerciseType.listenChoose),
        const SizedBox(height: 24),

        // Options
        ...quiz.options.map((opt) => _OptionButton(
          text:     opt,
          correct:  quiz.correctAnswer,
          selected: _selected,
          answered: _answered,
          onTap:    () => _onAnswer(opt),
        )),
      ],
    );
  }

  // ── Arrange Quiz ──────────────────────────────────────────────
  Widget _buildArrangeQuiz(Exercise quiz) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: _kBlueLight, borderRadius: BorderRadius.circular(16)),
          child: Text(context.t.lessonReorderWords,
              style: const TextStyle(color: Color(0xFF1565C0), fontSize: 13, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 16),

        _buildArabicCard(quiz.verset, showPhonetic: false),
        const SizedBox(height: 16),

        // Zone sélectionnée
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kBeigeCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _answered
                  ? (_selected == quiz.correctAnswer ? _kGreenPrimary : _kRed)
                  : _kBeigeBorder,
              width: 2,
            ),
          ),
          child: Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              if (_arrangeSelected.isEmpty)
                Text(_s('Touche les mots ci-dessous…', 'Tap the words below…'),
                    style: const TextStyle(color: _kTextLight, fontSize: 13, fontStyle: FontStyle.italic)),
              ..._arrangeSelected.asMap().entries.map((e) => GestureDetector(
                onTap: _answered ? null : () => _removeArrangeWord(e.key),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _kBlueLight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _kBlue.withValues(alpha: 0.4)),
                  ),
                  child: Text(e.value,
                      style: const TextStyle(color: Color(0xFF1565C0), fontSize: 13, fontWeight: FontWeight.w700)),
                ),
              )),
            ],
          ),
          ),
        ),
        const SizedBox(height: 12),

        // Mots disponibles
        if (!_answered) ...[
          Wrap(
            spacing: 8, runSpacing: 8,
            children: _arrangeRemaining.map((w) => GestureDetector(
              onTap: () => _tapArrangeWord(w),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _kBeigeCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kBeigeBorder, width: 2),
                  boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 2))],
                ),
                child: Text(w, style: const TextStyle(color: _kTextDark, fontSize: 13, fontWeight: FontWeight.w700)),
              ),
            )).toList(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _arrangeSelected.isEmpty ? null : _submitArrange,
              style: ElevatedButton.styleFrom(
                backgroundColor: _kBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(_s('Valider →', 'Validate →'), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildArabicCard(LearningVerset v, {required bool showPhonetic}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: const Color(0xFF1B5E20).withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 6))],
      ),
      child: Column(children: [
        Text(v.arabe,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            color: Color(0xFFFFE082), fontSize: 26, fontWeight: FontWeight.w600,
            height: 2.1, fontFamily: 'serif',
          ),
        ),
        if (showPhonetic) ...[
          const SizedBox(height: 8),
          Text(v.phonetique,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white60, fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ]),
    );
  }

  // ── Feedback Panel ────────────────────────────────────────────
  Widget _buildFeedback() {
    final isCorrect = _selected == _quizzes[_quizIdx].correctAnswer;
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(_feedbackAnim),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        decoration: BoxDecoration(
          color: isCorrect ? _kGreenLight : _kRedLight,
          border: Border(top: BorderSide(color: isCorrect ? _kGreenPrimary : _kRed, width: 2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              AnimatedScale(
                scale: _answered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.elasticOut,
                child: Text(isCorrect ? '✅' : '❌', style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCorrect ? 'Excellent ! +5 XP ⚡' : 'Pas tout à fait...',
                    style: TextStyle(
                      color: isCorrect ? _kGreenDeep : _kRed,
                      fontWeight: FontWeight.w900, fontSize: 16,
                    ),
                  ),
                  if (!isCorrect) ...[
                    const SizedBox(height: 4),
                    Text(
                      _quizzes[_quizIdx].type == ExerciseType.fillBlank
                          ? 'Mot correct : « ${_quizzes[_quizIdx].correctAnswer} »'
                          : 'Réponse : ${_quizzes[_quizIdx].correctAnswer}',
                      style: const TextStyle(color: _kTextLight, fontSize: 12),
                    ),
                    if (_quizzes[_quizIdx].type == ExerciseType.fillBlank) ...[
                      const SizedBox(height: 2),
                      Text(
                        '📢 ${_quizzes[_quizIdx].verset.phonetique}',
                        style: const TextStyle(color: Color(0xFF1565C0), fontSize: 11, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ],
                ],
              )),
            ]),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCorrect ? _kGreenPrimary : _kRed,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  _quizIdx + 1 >= _quizzes.length ? 'Voir les résultats 🎉' : 'Continuer →',
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Result Screen ─────────────────────────────────────────────
  Widget _buildResult() {
    final pct      = _totalQ == 0 ? 0 : (_score / _totalQ * 100).round();
    final xpGained = _score * 5 + widget.lesson.xpReward;
    final emoji    = pct >= 80 ? '🏆' : pct >= 50 ? '⭐' : '📖';
    final msg      = pct >= 80 ? 'Excellent travail !' : pct >= 50 ? 'Bien joué !' : 'Continue à pratiquer !';
    final color    = pct >= 80 ? _kGreenPrimary : pct >= 50 ? _kGold : _kBlue;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(children: [
        const SizedBox(height: 10),
        ScaleTransition(scale: _celebAnim, child: Text(emoji, style: const TextStyle(fontSize: 80))),
        const SizedBox(height: 16),
        Text(msg, style: TextStyle(color: color, fontSize: 26, fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        Text(context.t.lessonSurahCompleted(widget.lesson.surahNameFr),
            style: const TextStyle(color: _kTextLight, fontSize: 14)),
        const SizedBox(height: 32),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12, mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            _ResultTile('⚡', '+$xpGained XP', 'Gagnés',          _kGold,                    _kGoldLight),
            _ResultTile('🎯', '$pct%',          'Précision',        color, pct >= 80 ? _kGreenLight : pct >= 50 ? _kGoldLight : _kBlueLight),
            _ResultTile('❤️', '$_hearts/5',     'Vies restantes',  _kRed,                     _kRedLight),
            _ResultTile('✅', '$_score/$_totalQ','Bonnes réponses', _kGreenPrimary,             _kGreenLight),
          ],
        ),
        const SizedBox(height: 28),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _kGreenPrimary,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: _kGreenPrimary.withValues(alpha: 0.4),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            child: Text(_s('Retour au parcours 🎉', 'Back to path 🎉'),
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => setState(() {
            _phase     = _Phase.discover;
            _versetIdx = 0;
            _quizIdx   = 0;
            _selected  = null;
            _answered  = false;
            _hearts    = 5;
            _score     = 0;
            _quizzes   = _buildQuizzes();
            _arrangeSelected  = [];
            _arrangeRemaining = [];
            _updateProgress(0);
            _celebCtrl.reset();
          }),
          child: Text(_s('Recommencer la leçon', 'Restart lesson'),
              style: const TextStyle(color: _kTextLight, fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }

  void _showQuitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: _kBeigeCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(_s('Quitter la leçon ?', 'Quit lesson?'),
            style: const TextStyle(color: _kTextDark, fontWeight: FontWeight.w900)),
        content: Text(_s('Ta progression pour cette session sera perdue.', 'Your progress for this session will be lost.'),
            style: const TextStyle(color: _kTextLight)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(_s('Continuer', 'Continue'), style: const TextStyle(color: _kGreenPrimary, fontWeight: FontWeight.w800)),
          ),
          TextButton(
            onPressed: () { Navigator.pop(context); Navigator.pop(context); },
            child: Text(_s('Quitter', 'Quit'), style: const TextStyle(color: _kRed, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

// ─── Option Button ────────────────────────────────────────────────
class _OptionButton extends StatelessWidget {
  final String  text, correct;
  final String? selected;
  final bool    answered;
  final VoidCallback onTap;
  const _OptionButton({required this.text, required this.correct, required this.selected, required this.answered, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == text;
    final isCorrect  = text == correct;

    Color  bg        = _kBeigeCard;
    Color  border    = _kBeigeBorder;
    Color  textColor = _kTextDark;
    String? badge;

    if (answered) {
      if (isCorrect)       { bg = _kGreenLight; border = _kGreenPrimary; textColor = _kGreenDeep;   badge = '✅'; }
      else if (isSelected) { bg = _kRedLight;   border = _kRed;          textColor = _kRed;          badge = '❌'; }
    } else if (isSelected) {
      bg = const Color(0xFFF0F8F3); border = _kGreenMedium; textColor = _kGreenPrimary;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border, width: 2.5),
          boxShadow: isSelected && !answered
              ? [const BoxShadow(color: Color(0x202A7A52), blurRadius: 12)]
              : answered && isCorrect
                  ? [BoxShadow(color: _kGreenPrimary.withValues(alpha: 0.2), blurRadius: 12)]
                  : [const BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Row(children: [
          if (badge != null) ...[
            Text(badge, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
          ] else ...[
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: isSelected ? _kGreenMedium.withValues(alpha: 0.15) : const Color(0xFFE5E5E5).withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(isSelected ? '●' : '○',
                    style: TextStyle(color: isSelected ? _kGreenPrimary : _kTextLight, fontSize: 12)),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(text,
                style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w700, height: 1.4)),
          ),
        ]),
      ),
    );
  }
}

// ─── Result Tile ─────────────────────────────────────────────────
class _ResultTile extends StatelessWidget {
  final String icon, value, label;
  final Color  color, bg;
  const _ResultTile(this.icon, this.value, this.label, this.color, this.bg);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 26)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(color: _kTextLight, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
