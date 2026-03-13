// quiz_screen.dart — Deenly · Quiz intermédiaire & final de sourate

import 'package:flutter/material.dart';
import 'learning_models.dart';
import 'review_screen.dart';

// ── Palette ────────────────────────────────────────────────────────────────
const _kGreenDeep    = Color(0xFF0A2018);
const _kGreenPrimary = Color(0xFF1B4D38);
const _kGold         = Color(0xFFC8933A);
const _kGoldLight    = Color(0xFFE8BF6A);
const _kBeige        = Color(0xFFF6F0E3);
const _kBeigeCard    = Color(0xFFFFFFFF);
const _kBeigeBorder  = Color(0xFFD6C9AF);
const _kTextDark     = Color(0xFF1A130A);
const _kTextMid      = Color(0xFF5A4833);
const _kTextLight    = Color(0xFF8A7863);
const _kGreen        = Color(0xFF4CAF50);
const _kGreenLight   = Color(0xFFE8F5E9);
const _kRed          = Color(0xFFFF4B4B);
const _kRedLight     = Color(0xFFFFEBEB);
const _kBlue         = Color(0xFF1CB0F6);
const _kBlueLight    = Color(0xFFE7F7FF);
const _kOrange       = Color(0xFFFF9800);

// ══════════════════════════════════════════════════════════════════════════════
// ÉCRAN QUIZ
// ══════════════════════════════════════════════════════════════════════════════
class QuizScreen extends StatefulWidget {
  /// Leçons sur lesquelles porte ce quiz.
  final List<LearningLesson> lessons;
  final String    surahName;
  final String    surahNameFr;
  final int       surahNumber;
  /// Stats utilisateur (nécessaires pour transmettre à ReviewScreen)
  final UserStats stats;
  /// true = quiz final (toute la sourate), false = quiz intermédiaire (tous les 5 versets)
  final bool   isFinalQuiz;
  /// Index du quiz intermédiaire (1-based : 1 = après verset 5, 2 = après verset 10…)
  final int    quizIndex;

  const QuizScreen({
    Key? key,
    required this.lessons,
    required this.surahName,
    required this.surahNameFr,
    required this.surahNumber,
    required this.stats,
    this.isFinalQuiz = false,
    this.quizIndex   = 1,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {

  late List<Exercise> _questions;
  int     _currentIdx  = 0;
  int     _score       = 0;
  bool    _showFeedback = false;
  bool    _lastCorrect  = false;
  bool    _done         = false;
  String? _selectedAnswer;

  // Versets mal répondus → envoyés vers RevisionScreen si échec
  final List<LearningVerset> _failedVersets = [];

  // Arrange exercise
  List<String> _arrangeSelected  = [];
  List<String> _arrangeRemaining = [];

  late AnimationController _feedbackCtrl;
  late Animation<Offset>   _feedbackSlide;

  @override
  void initState() {
    super.initState();
    _feedbackCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _feedbackSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end:   Offset.zero,
    ).animate(CurvedAnimation(parent: _feedbackCtrl, curve: Curves.easeOut));

    _questions = _buildQuestions();
    _initArrange();
  }

  @override
  void dispose() {
    _feedbackCtrl.dispose();
    super.dispose();
  }

  // ── Génération des questions ────────────────────────────────────────────
  List<Exercise> _buildQuestions() {
    final versets = widget.lessons
        .where((l) => l.versets.isNotEmpty)
        .map((l) => l.versets.first)
        .toList();
    if (versets.isEmpty) return [];

    // Nombre de questions : 5 pour intermédiaire, 10 minimum pour final
    final int totalQ = widget.isFinalQuiz
        ? (versets.length >= 5 ? 10 : versets.length * 2)
        : 5;

    // Pool de distracteurs construits depuis TOUS les versets du quiz
    final allFr = versets.map((v) => v.francais).toList();
    final allAr = versets.map((v) => v.arabe).toList();
    final allPh = versets.map((v) => v.phonetique).toList();

    // Fallbacks si pool trop petit
    allFr.addAll([
      'Au nom d\'Allah, le Tout Miséricordieux',
      'Louange à Allah, Seigneur des univers',
      'Maître du Jour du Jugement',
      'C\'est Toi que nous adorons',
      'Guide-nous vers le droit chemin',
    ]);
    allPh.addAll([
      'Bismillah ir-rahman ir-rahim',
      'Al-hamdu lillahi rabb il-\'alamin',
      'Maliki yawm id-din',
      'Iyyaka na\'budu wa iyyaka nasta\'in',
    ]);

    final questions   = <Exercise>[];
    final shuffled    = List<LearningVerset>.from(versets)..shuffle();

    for (int i = 0; questions.length < totalQ; i++) {
      if (i > shuffled.length * 4) break; // sécurité anti-boucle infinie
      final v       = shuffled[i % shuffled.length];
      final typeIdx = questions.length % 3;

      if (typeIdx == 0) {
        // listenChoose : voir arabe → choisir traduction
        questions.add(Exercise(
          type:          ExerciseType.listenChoose,
          verset:        v,
          correctAnswer: v.francais,
          options:       _buildOptions(v.francais, allFr),
        ));
      } else if (typeIdx == 1) {
        // fillBlank : voir arabe → choisir phonétique
        questions.add(Exercise(
          type:          ExerciseType.fillBlank,
          verset:        v,
          correctAnswer: v.phonetique,
          options:       _buildOptions(v.phonetique, allPh),
          hint:          _blankHint(v.phonetique),
        ));
      } else {
        // translateChoice : voir traduction → choisir arabe
        if (allAr.length >= 4) {
          questions.add(Exercise(
            type:          ExerciseType.translateChoice,
            verset:        v,
            correctAnswer: v.arabe,
            options:       _buildOptions(v.arabe, allAr),
          ));
        } else {
          questions.add(Exercise(
            type:          ExerciseType.listenChoose,
            verset:        v,
            correctAnswer: v.francais,
            options:       _buildOptions(v.francais, allFr),
          ));
        }
      }
    }

    return questions.take(totalQ).toList();
  }

  String _blankHint(String phonetique) {
    final words = phonetique.trim().split(RegExp(r'\s+'));
    if (words.length < 2) return '___';
    final midIdx = words.length ~/ 2;
    return words.asMap().entries
        .map((e) => e.key == midIdx ? '[ ___ ]' : e.value)
        .join(' ');
  }

  List<String> _buildOptions(String correct, List<String> pool) {
    final opts = <String>{correct};
    final shuffled = List<String>.from(pool)..shuffle();
    for (final o in shuffled) {
      if (o != correct) opts.add(o);
      if (opts.length >= 4) break;
    }
    while (opts.length < 4) opts.add('—');
    final list = opts.toList()..shuffle();
    return list;
  }

  void _initArrange() {
    if (_questions.isEmpty) return;
    final q = _questions[_currentIdx];
    if (q.type == ExerciseType.arrange) {
      _arrangeSelected  = [];
      _arrangeRemaining = List<String>.from(q.options);
    }
  }

  // ── Logique de réponse ─────────────────────────────────────────────────
  void _onAnswer(String answer) {
    if (_showFeedback) return;
    final q       = _questions[_currentIdx];
    final correct = answer == q.correctAnswer;
    if (correct) {
      _score++;
    } else {
      final alreadyFailed = _failedVersets.any(
          (v) => v.numero == q.verset.numero && v.surahNumber == q.verset.surahNumber);
      if (!alreadyFailed) _failedVersets.add(q.verset);
    }
    setState(() {
      _selectedAnswer = answer;
      _lastCorrect    = correct;
      _showFeedback   = true;
    });
    _feedbackCtrl.forward(from: 0);
  }

  void _next() {
    _feedbackCtrl.reverse();
    Future.delayed(const Duration(milliseconds: 180), () {
      if (!mounted) return;
      setState(() {
        _showFeedback   = false;
        _selectedAnswer = null;
        if (_currentIdx + 1 >= _questions.length) {
          _done = true;
        } else {
          _currentIdx++;
          _initArrange();
        }
      });
    });
  }

  bool get _passed {
    if (_questions.isEmpty) return true;
    final threshold = widget.isFinalQuiz ? 0.70 : 0.60;
    return _score / _questions.length >= threshold;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: _kBeige,
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('❓', style: TextStyle(fontSize: 60)),
            const SizedBox(height: 16),
            const Text('Pas assez de versets pour ce quiz.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kTextMid, fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              style: ElevatedButton.styleFrom(backgroundColor: _kGreenPrimary, foregroundColor: Colors.white),
              child: const Text('Retour'),
            ),
          ],
        )),
      );
    }
    if (_done) return _buildResultScreen(context);

    return Scaffold(
      backgroundColor: _kBeige,
      body: SafeArea(
        child: Stack(children: [
          Column(children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
                child: _buildQuestion(),
              ),
            ),
          ]),
          if (_showFeedback)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: SlideTransition(
                position: _feedbackSlide,
                child: _buildFeedback(),
              ),
            ),
        ]),
      ),
    );
  }

  // ── Top bar avec barre de progression ──────────────────────────────────
  Widget _buildTopBar(BuildContext context) {
    final progress = _questions.isEmpty ? 0.0 : _currentIdx / _questions.length;
    final label    = widget.isFinalQuiz
        ? 'Quiz Final · ${widget.surahNameFr}'
        : 'Quiz ${widget.quizIndex} · Versets 1–${widget.lessons.length}';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_kGreenDeep, Color(0xFF112B1E)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      child: Column(children: [
        Row(children: [
          GestureDetector(
            onTap: () => _showQuitDialog(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.close_rounded, color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800)),
              Text('Question ${_currentIdx + 1} / ${_questions.length}',
                  style: TextStyle(color: Colors.white.withOpacity(0.60), fontSize: 11)),
            ],
          )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _kGold.withOpacity(0.22),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kGold.withOpacity(0.40)),
            ),
            child: Text('⚡ $_score / ${_questions.length}',
                style: const TextStyle(color: _kGoldLight, fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ]),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value:           progress,
            minHeight:       7,
            backgroundColor: Colors.white.withOpacity(0.18),
            valueColor:      const AlwaysStoppedAnimation(_kGold),
          ),
        ),
      ]),
    );
  }

  // ── Question ──────────────────────────────────────────────────────────
  Widget _buildQuestion() {
    final q = _questions[_currentIdx];

    String questionText;
    switch (q.type) {
      case ExerciseType.listenChoose:
        questionText = 'Quelle est la traduction de ce verset ?';
        break;
      case ExerciseType.fillBlank:
        questionText = 'Quelle est la phonétique de ce verset ?';
        break;
      case ExerciseType.translateChoice:
        questionText = 'Quel est ce verset en arabe ?';
        break;
      case ExerciseType.arrange:
        questionText = 'Remets les mots dans l\'ordre';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Badge question
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _kGold.withOpacity(0.13),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _kGold.withOpacity(0.35)),
            ),
            child: Text(questionText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: _kGold, fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(height: 20),

        // Carte arabe (sauf translateChoice → montre la traduction)
        if (q.type != ExerciseType.translateChoice) _buildArabicCard(q),
        if (q.type == ExerciseType.translateChoice)  _buildFrenchCard(q.verset.francais),

        // Hint phonétique pour fillBlank
        if (q.type == ExerciseType.fillBlank && q.hint != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kBlueLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBlue.withOpacity(0.30)),
            ),
            child: Text(q.hint!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF0078A8), fontSize: 14,
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.w600)),
          ),
        ],

        const SizedBox(height: 22),

        // Options MCQ
        if (q.type != ExerciseType.arrange)
          ...q.options.map((o) => _buildOptionTile(o, q.correctAnswer)),

        // Exercice arrange (remise en ordre)
        if (q.type == ExerciseType.arrange) _buildArrange(q),
      ],
    );
  }

  Widget _buildArabicCard(Exercise q) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D3A25), Color(0xFF1B5E40)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: _kGreenPrimary.withOpacity(0.28), blurRadius: 18, offset: const Offset(0, 6))],
      ),
      child: Column(children: [
        Text('(${q.verset.numero})',
            style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 11)),
        const SizedBox(height: 12),
        Text(q.verset.arabe,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white, fontSize: 26, height: 1.75,
            )),
      ]),
    );
  }

  Widget _buildFrenchCard(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4DC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kGold.withOpacity(0.4)),
      ),
      child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _kTextDark, fontSize: 16,
            fontStyle: FontStyle.italic, height: 1.5)),
    );
  }

  Widget _buildOptionTile(String opt, String correct) {
    Color bg     = _kBeigeCard;
    Color border = _kBeigeBorder;
    Color text   = _kTextDark;
    Widget? icon;

    if (_showFeedback) {
      if (opt == _selectedAnswer) {
        if (_lastCorrect) {
          bg = _kGreenLight; border = _kGreen; text = const Color(0xFF1B6B2B);
          icon = const Icon(Icons.check_circle_rounded, color: _kGreen, size: 20);
        } else {
          bg = _kRedLight; border = _kRed; text = const Color(0xFF9B1A1A);
          icon = const Icon(Icons.cancel_rounded, color: _kRed, size: 20);
        }
      } else if (opt == correct && !_lastCorrect) {
        bg = _kGreenLight; border = _kGreen; text = const Color(0xFF1B6B2B);
        icon = const Icon(Icons.check_circle_rounded, color: _kGreen, size: 20);
      }
    }

    return GestureDetector(
      onTap: _showFeedback ? null : () => _onAnswer(opt),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, width: 1.5),
          boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Row(children: [
          Expanded(child: Text(opt,
              style: TextStyle(color: text, fontSize: 14, fontWeight: FontWeight.w600, height: 1.4))),
          if (icon != null) icon,
        ]),
      ),
    );
  }

  Widget _buildArrange(Exercise q) {
    return Column(children: [
      // Zone dépôt
      GestureDetector(
        onTap: _arrangeSelected.isEmpty || _showFeedback ? null : () {
          setState(() {
            _arrangeRemaining.add(_arrangeSelected.removeLast());
          });
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _arrangeSelected.isEmpty ? const Color(0xFFF8F4ED) : _kBlueLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _arrangeSelected.isEmpty ? _kBeigeBorder : _kBlue.withOpacity(0.55),
              width: 1.5,
            ),
          ),
          child: _arrangeSelected.isEmpty
              ? Center(child: Text('Touche les mots ci-dessous...',
                  style: TextStyle(color: _kTextLight, fontSize: 12)))
              : Wrap(
                  spacing: 8, runSpacing: 6,
                  children: _arrangeSelected.map((w) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: _kBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(w, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                  )).toList(),
                ),
          ),
        ),
      ),
      const SizedBox(height: 14),
      Wrap(
        spacing: 8, runSpacing: 8,
        children: _arrangeRemaining.map((w) => GestureDetector(
          onTap: _showFeedback ? null : () {
            setState(() {
              _arrangeRemaining.remove(w);
              _arrangeSelected.add(w);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _kBeigeCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _kBeigeBorder, width: 1.5),
            ),
            child: Text(w, style: const TextStyle(color: _kTextDark, fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        )).toList(),
      ),
      const SizedBox(height: 20),
      if (_arrangeRemaining.isEmpty && !_showFeedback)
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _onAnswer(_arrangeSelected.join(' ')),
            style: ElevatedButton.styleFrom(
              backgroundColor: _kGreenPrimary, foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 14), elevation: 0,
            ),
            child: const Text('Vérifier', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
          ),
        ),
    ]);
  }

  // ── Feedback ──────────────────────────────────────────────────────────
  Widget _buildFeedback() {
    final q = _questions[_currentIdx];
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
      decoration: BoxDecoration(
        color: _lastCorrect ? _kGreenLight : _kRedLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(
          color: _lastCorrect ? _kGreen : _kRed, width: 2)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(_lastCorrect ? '✅' : '❌', style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Text(
            _lastCorrect ? 'Correct ! +1 ⚡' : 'Pas tout à fait...',
            style: TextStyle(
              color: _lastCorrect ? const Color(0xFF1B6B2B) : const Color(0xFF9B1A1A),
              fontSize: 16, fontWeight: FontWeight.w800,
            ),
          ),
        ]),
        if (!_lastCorrect) ...[
          const SizedBox(height: 8),
          Text('Bonne réponse :',
              style: TextStyle(color: Colors.grey[600], fontSize: 11)),
          const SizedBox(height: 3),
          Text(q.correctAnswer,
              style: const TextStyle(color: _kTextDark, fontSize: 13, fontWeight: FontWeight.w700)),
        ],
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _next,
            style: ElevatedButton.styleFrom(
              backgroundColor: _lastCorrect ? _kGreen : _kRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(vertical: 14), elevation: 0,
            ),
            child: const Text('Continuer →',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
          ),
        ),
      ]),
    );
  }

  // ── Résultat final ────────────────────────────────────────────────────
  Widget _buildResultScreen(BuildContext context) {
    final total  = _questions.length;
    final pct    = total == 0 ? 0.0 : _score / total;
    final passed = _passed;
    final minScore = widget.isFinalQuiz ? '7/$total' : '3/$total';

    return Scaffold(
      backgroundColor: _kBeige,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            const SizedBox(height: 24),
            Text(passed ? '🏆' : '📚', style: const TextStyle(fontSize: 80)),
            const SizedBox(height: 18),
            Text(
              passed
                  ? (widget.isFinalQuiz ? 'Sourate maîtrisée !' : 'Quiz réussi !')
                  : 'Encore un effort !',
              style: TextStyle(
                color: passed ? _kGreenPrimary : _kOrange,
                fontSize: 26, fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              passed
                  ? 'Bravo ! Tu as obtenu $_score/$total bonnes réponses.'
                  : 'Tu as obtenu $_score/$total. Il faut au moins $minScore pour réussir.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: _kTextMid, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 30),

            // Carte score
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _kBeigeCard,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: _kBeigeBorder),
                boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 4))],
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Score', style: TextStyle(color: _kTextLight, fontSize: 13)),
                    Text('${(pct * 100).round()}%',
                        style: TextStyle(
                          color: passed ? _kGreenPrimary : _kOrange,
                          fontSize: 24, fontWeight: FontWeight.w900,
                        )),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value:           pct,
                    minHeight:       10,
                    backgroundColor: _kBeigeBorder,
                    valueColor:      AlwaysStoppedAnimation(passed ? _kGreenPrimary : _kOrange),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _stat('✅', '$_score',       'Corrects'),
                    _stat('❌', '${total - _score}', 'Erreurs'),
                    _stat('📊', '${(pct * 100).round()}%', 'Score'),
                  ],
                ),
              ]),
            ),

            const SizedBox(height: 28),

            // Bouton révision si échec
            if (!passed && _failedVersets.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ReviewScreen(versets: _failedVersets, stats: widget.stats)));
                    if (!mounted) return;
                    // Réinitialise le quiz après révision
                    setState(() {
                      _done           = false;
                      _currentIdx     = 0;
                      _score          = 0;
                      _showFeedback   = false;
                      _selectedAnswer = null;
                      _failedVersets.clear();
                      _questions      = _buildQuestions();
                      _initArrange();
                    });
                  },
                  icon: const Icon(Icons.auto_fix_high_rounded, size: 18),
                  label: Text('Réviser les ${_failedVersets.length} versets ratés'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kOrange, foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(vertical: 14), elevation: 0,
                  ),
                ),
              ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // Renvoie true (réussi) ou false (raté) à l'écran parent
                onPressed: () => Navigator.pop(context, passed),
                style: ElevatedButton.styleFrom(
                  backgroundColor: passed ? _kGreenPrimary : _kBeigeCard,
                  foregroundColor: passed ? Colors.white : _kTextDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: passed ? BorderSide.none : const BorderSide(color: _kBeigeBorder),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14), elevation: 0,
                ),
                child: Text(passed ? 'Continuer  🎉' : 'Retour au parcours',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
              ),
            ),

            if (!passed) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => setState(() {
                  _done           = false;
                  _currentIdx     = 0;
                  _score          = 0;
                  _showFeedback   = false;
                  _selectedAnswer = null;
                  _failedVersets.clear();
                  _questions      = _buildQuestions();
                  _initArrange();
                }),
                child: const Text('Recommencer le quiz',
                    style: TextStyle(color: _kTextLight, fontSize: 13)),
              ),
            ],
            const SizedBox(height: 16),
          ]),
        ),
      ),
    );
  }

  Widget _stat(String emoji, String val, String label) {
    return Column(children: [
      Text(emoji, style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 4),
      Text(val, style: const TextStyle(color: _kTextDark, fontSize: 17, fontWeight: FontWeight.w900)),
      Text(label, style: const TextStyle(color: _kTextLight, fontSize: 10)),
    ]);
  }

  void _showQuitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _kBeigeCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Quitter le quiz ?',
            style: TextStyle(color: _kTextDark, fontWeight: FontWeight.w800)),
        content: const Text('Ta progression sera perdue.',
            style: TextStyle(color: _kTextMid)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Continuer',
                style: TextStyle(color: _kGreenPrimary, fontWeight: FontWeight.w700)),
          ),
          TextButton(
            onPressed: () { Navigator.pop(ctx); Navigator.pop(context, false); },
            child: const Text('Quitter', style: TextStyle(color: _kRed)),
          ),
        ],
      ),
    );
  }
}
