// children_screen.dart
// Module Espace Enfants – Application Deenly : Lumière sur ta foi

import 'package:flutter/material.dart';

// ── Palette Deenly ──────────────────────────────────────────────────
const _kGreenDeep    = Color(0xFF0A2018);
const _kGreenPrimary = Color(0xFF1B4D38);
const _kGreenMedium  = Color(0xFF2A7A52);
const _kGold         = Color(0xFFC8933A);
const _kGoldLight    = Color(0xFFFFF4DC);
const _kBeige        = Color(0xFFF6F0E3);
const _kBeigeCard    = Color(0xFFFFFFFF);
const _kBeigeBorder  = Color(0xFFD6C9AF);
const _kTextDark     = Color(0xFF1A130A);
const _kTextMid      = Color(0xFF5A4833);
const _kTextLight    = Color(0xFF8A7863);

// ── Modèle d'une histoire ──────────────────────────────────────────
class Histoire {
  final String titre, prophete, resume, contenu, emoji, morale;
  const Histoire({
    required this.titre, required this.prophete, required this.resume,
    required this.contenu, required this.emoji, required this.morale,
  });
}

// ── Modèle d'une question quiz ─────────────────────────────────────
class QuizQuestion {
  final String question, explication;
  final List<String> options;
  final int reponseCorrecteIndex;
  const QuizQuestion({
    required this.question, required this.options,
    required this.reponseCorrecteIndex, required this.explication,
  });
}

// ── Données : Histoires ────────────────────────────────────────────
const List<Histoire> _histoires = [
  Histoire(
    titre: 'Noé et l\'Arche',
    prophete: 'Nuh (Noé) عليه السلام',
    resume: 'Comment Allah sauva les croyants grâce à une immense arche.',
    emoji: '🚢',
    contenu: '''Il y a très longtemps, vivait un homme bon nommé Nuh. Allah lui ordonna de construire une grande arche en bois, car une inondation allait venir.

Les gens se moquaient de lui : "Pourquoi construire un bateau sur la terre ferme ?" Mais Nuh continuait à travailler avec patience et foi.

Quand l'arche fut prête, Allah lui dit d'y faire monter sa famille et des animaux, deux par deux. Puis la pluie tomba pendant très longtemps, couvrant toute la terre d'eau.

Mais grâce à l'arche, Nuh et ceux qui croyaient furent sauvés. Quand les eaux se retirèrent, l'arche s'arrêta sur une montagne.

Nuh remercia Allah de tout son cœur.''',
    morale: '👶 Leçon : Quand Allah nous demande quelque chose, même si c\'est difficile, il faut obéir avec foi et patience.',
  ),
  Histoire(
    titre: 'Ibrahim et le Feu',
    prophete: 'Ibrahim (Abraham) عليه السلام',
    resume: 'La foi d\'Ibrahim qui ne fut pas brûlé par les flammes.',
    emoji: '🔥',
    contenu: '''Ibrahim vivait dans un pays où les gens adoraient des statues en pierre. Il savait que c'était faux et il disait à son peuple : "N'adorez qu'Allah, le Créateur du ciel et de la terre !"

Un jour, Ibrahim cassa les idoles pour montrer à son peuple qu'elles n'avaient aucun pouvoir. En colère, le roi ordonna de jeter Ibrahim dans un immense feu.

Les flammes étaient si hautes qu'on ne pouvait pas s'en approcher. Mais Ibrahim n'avait pas peur. Il dit : "Allah me suffit."

Miracle ! Quand Ibrahim fut jeté dans le feu, Allah ordonna au feu : "Sois fraîcheur et salut pour Ibrahim !" Le feu ne lui fit aucun mal.

Tout le monde était stupéfait. Ibrahim en sortit sain et sauf, le sourire aux lèvres.''',
    morale: '👶 Leçon : Lorsque nous avons confiance en Allah de tout notre cœur, Il nous protège.',
  ),
  Histoire(
    titre: 'Yusuf et ses frères',
    prophete: 'Yusuf (Joseph) عليه السلام',
    resume: 'L\'histoire du pardon et de la patience de Yusuf.',
    emoji: '⭐',
    contenu: '''Yusuf était un jeune garçon très bon et aimé de son père. Un jour, il rêva que onze étoiles, le soleil et la lune se prosternaient devant lui.

Ses frères étaient jaloux de lui. Un jour, ils le jetèrent dans un puits et dirent à leur père qu'un loup l'avait mangé.

Des marchands trouvèrent Yusuf et l'emmenèrent en Égypte, où il devint esclave. Malgré les épreuves, il restait patient et ne cessait pas de prier Allah.

Grâce à sa sagesse et sa foi, Yusuf devint un grand ministre du roi d'Égypte. Des années plus tard, ses frères vinrent en Égypte chercher de la nourriture et le reconnurent.

Au lieu de se venger, Yusuf dit : "Je vous pardonne. Allah est Miséricordieux."''',
    morale: '👶 Leçon : La patience et le pardon sont des qualités très précieuses. Allah récompense ceux qui restent bons même dans les épreuves.',
  ),
  Histoire(
    titre: 'Musa et le Pharaon',
    prophete: 'Musa (Moïse) عليه السلام',
    resume: 'Comment Musa libéra les enfants d\'Israël avec l\'aide d\'Allah.',
    emoji: '🌊',
    contenu: '''Musa grandit en Égypte au temps d'un roi très cruel appelé Pharaon, qui asservissait le peuple d'Israël.

Un jour, Allah parla à Musa depuis un buisson ardent et lui dit : "Va voir Pharaon et dis-lui de libérer mon peuple."

Musa obéit malgré sa peur. Il alla devant Pharaon avec son bâton, qui se transforma en serpent devant tout le monde. Pharaon refusa de libérer les gens.

Allah envoya alors de nombreux signes. Finalement, Musa conduisit son peuple vers la mer. Pharaon les poursuivit avec son armée.

À la mer, Allah dit à Musa de frapper l'eau de son bâton. La mer s'ouvrit en deux, formant un chemin ! Musa et son peuple traversèrent sains et saufs.''',
    morale: '👶 Leçon : Allah est toujours avec ceux qui lui font confiance, même dans les moments les plus difficiles.',
  ),
];

// ── Données : Quiz ─────────────────────────────────────────────────
const List<QuizQuestion> _quizQuestions = [
  QuizQuestion(
    question: 'Combien de piliers compte l\'Islam ?',
    options: ['3', '4', '5', '6'],
    reponseCorrecteIndex: 2,
    explication: 'L\'Islam a 5 piliers : la Shahada, la Salat, la Zakat, le Sawm et le Hajj.',
  ),
  QuizQuestion(
    question: 'Qui est le dernier Prophète de l\'Islam ?',
    options: ['Ibrahim', 'Issa', 'Musa', 'Muhammad ﷺ'],
    reponseCorrecteIndex: 3,
    explication: 'Le Prophète Muhammad ﷺ est le dernier messager d\'Allah envoyé à toute l\'humanité.',
  ),
  QuizQuestion(
    question: 'Combien de sourates contient le Coran ?',
    options: ['99', '100', '114', '120'],
    reponseCorrecteIndex: 2,
    explication: 'Le Saint Coran contient 114 sourates, de Al-Fatiha à An-Nas.',
  ),
  QuizQuestion(
    question: 'Quelle est la première sourate du Coran ?',
    options: ['Al-Baqara', 'Al-Fatiha', 'Al-Ikhlas', 'An-Nas'],
    reponseCorrecteIndex: 1,
    explication: 'Al-Fatiha ("L\'Ouverture") est la première sourate du Coran.',
  ),
  QuizQuestion(
    question: 'Combien de fois par jour un musulman prie-t-il ?',
    options: ['3 fois', '4 fois', '5 fois', '6 fois'],
    reponseCorrecteIndex: 2,
    explication: 'Un musulman accomplit 5 prières par jour : Fajr, Dohr, Asr, Maghrib et Icha.',
  ),
  QuizQuestion(
    question: 'Dans quelle ville est né le Prophète Muhammad ﷺ ?',
    options: ['Médine', 'La Mecque', 'Jérusalem', 'Taïf'],
    reponseCorrecteIndex: 1,
    explication: 'Le Prophète Muhammad ﷺ est né à La Mecque, en Arabie Saoudite.',
  ),
  QuizQuestion(
    question: 'Que signifie "Alhamdulillah" ?',
    options: ['Allah est grand', 'Louange à Allah', 'Au nom d\'Allah', 'Allah soit loué'],
    reponseCorrecteIndex: 1,
    explication: '"Alhamdulillah" (الحمد لله) signifie "Louange à Allah".',
  ),
  QuizQuestion(
    question: 'Quel prophète a construit une arche pour se sauver du déluge ?',
    options: ['Ibrahim', 'Musa', 'Nuh', 'Yusuf'],
    reponseCorrecteIndex: 2,
    explication: 'C\'est le Prophète Nuh (Noé عليه السلام) qui construisit l\'arche sur ordre d\'Allah.',
  ),
];

// ── Écran Espace Enfants ───────────────────────────────────────────
class ChildrenScreen extends StatefulWidget {
  const ChildrenScreen({super.key});

  @override
  State<ChildrenScreen> createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _HistoiresTab(),
                const _QuizTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kGreenDeep, _kGreenPrimary],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 15),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Espace Enfants ⭐',
                            style: TextStyle(
                              color: Colors.white, fontSize: 20,
                              fontWeight: FontWeight.w900,
                            )),
                        Text('Histoires & quiz islamiques',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.55),
                                fontSize: 11)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _kGold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _kGold.withOpacity(0.4), width: 1),
                    ),
                    child: Text('${_histoires.length} histoires',
                        style: const TextStyle(
                            color: _kGold, fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TabBar(
              controller: _tabController,
              indicatorColor: _kGold,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.5),
              labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              tabs: const [
                Tab(text: 'Histoires', icon: Icon(Icons.auto_stories_rounded, size: 16)),
                Tab(text: 'Quiz', icon: Icon(Icons.quiz_rounded, size: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Onglet Histoires ───────────────────────────────────────────────
class _HistoiresTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: _histoires.length,
      itemBuilder: (context, index) {
        final histoire = _histoires[index];
        return _HistoireCard(
          histoire: histoire,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HistoireDetailScreen(histoire: histoire)),
          ),
        );
      },
    );
  }
}

// ── Carte histoire ─────────────────────────────────────────────────
class _HistoireCard extends StatelessWidget {
  final Histoire histoire;
  final VoidCallback onTap;
  const _HistoireCard({required this.histoire, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kBeigeBorder, width: 1.2),
          boxShadow: const [
            BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Row(children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              color: _kGoldLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: Text(histoire.emoji,
                style: const TextStyle(fontSize: 30))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(histoire.titre,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w800, color: _kTextDark)),
                const SizedBox(height: 3),
                Text(histoire.prophete,
                    style: const TextStyle(
                        fontSize: 12, color: _kGreenPrimary, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(histoire.resume,
                    style: const TextStyle(fontSize: 12, color: _kTextLight),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: _kTextLight),
        ]),
      ),
    );
  }
}

// ── Écran Détail d'une Histoire ────────────────────────────────────
class HistoireDetailScreen extends StatelessWidget {
  final Histoire histoire;
  const HistoireDetailScreen({super.key, required this.histoire});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_kGreenDeep, _kGreenPrimary],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(children: [
                    Row(children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white, size: 15),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(histoire.titre,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18,
                                fontWeight: FontWeight.w900)),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    Text(histoire.emoji, style: const TextStyle(fontSize: 64)),
                    const SizedBox(height: 8),
                    Text(histoire.prophete,
                        style: const TextStyle(
                            color: _kGold, fontSize: 14, fontWeight: FontWeight.w700)),
                  ]),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                // Contenu
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _kBeigeCard,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: _kBeigeBorder, width: 1.2),
                    boxShadow: const [
                      BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 3)),
                    ],
                  ),
                  child: Text(histoire.contenu.trim(),
                      style: const TextStyle(
                          fontSize: 15, height: 1.8, color: _kTextMid)),
                ),
                const SizedBox(height: 16),

                // Morale
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: _kGoldLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _kGold.withOpacity(0.4), width: 1.5),
                  ),
                  child: Text(histoire.morale,
                      style: const TextStyle(
                          fontSize: 14, color: _kTextMid,
                          fontWeight: FontWeight.w600, height: 1.5)),
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Onglet Quiz ────────────────────────────────────────────────────
class _QuizTab extends StatefulWidget {
  const _QuizTab();

  @override
  State<_QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<_QuizTab> {
  int  _questionIndex = 0;
  int? _reponseSelectionnee;
  int  _score = 0;
  bool _quizTermine = false;

  void _selectReponse(int index) {
    if (_reponseSelectionnee != null) return;
    setState(() {
      _reponseSelectionnee = index;
      if (index == _quizQuestions[_questionIndex].reponseCorrecteIndex) _score++;
    });
  }

  void _prochainQuestion() {
    if (_questionIndex < _quizQuestions.length - 1) {
      setState(() { _questionIndex++; _reponseSelectionnee = null; });
    } else {
      setState(() => _quizTermine = true);
    }
  }

  void _recommencer() {
    setState(() {
      _questionIndex = 0; _reponseSelectionnee = null;
      _score = 0; _quizTermine = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_quizTermine) {
      return _ResultatQuiz(score: _score, total: _quizQuestions.length, onRestart: _recommencer);
    }

    final question = _quizQuestions[_questionIndex];
    final aRepondu = _reponseSelectionnee != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        // Progression
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Question ${_questionIndex + 1} / ${_quizQuestions.length}',
                style: const TextStyle(color: _kTextLight, fontSize: 13)),
            Text('Score : $_score ⭐',
                style: const TextStyle(color: _kGold, fontWeight: FontWeight.w800)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: (_questionIndex + 1) / _quizQuestions.length,
            minHeight: 8,
            backgroundColor: _kBeigeBorder,
            valueColor: const AlwaysStoppedAnimation<Color>(_kGreenPrimary),
          ),
        ),
        const SizedBox(height: 20),

        // Question
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_kGreenDeep, _kGreenPrimary],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: _kGreenPrimary.withOpacity(0.3),
                  blurRadius: 16, offset: const Offset(0, 6)),
            ],
          ),
          child: Text(question.question,
              style: const TextStyle(
                  color: Colors.white, fontSize: 17,
                  fontWeight: FontWeight.w800, height: 1.4),
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: 20),

        // Options de réponse
        ...List.generate(question.options.length, (index) {
          final isSelected = _reponseSelectionnee == index;
          final isCorrect = index == question.reponseCorrecteIndex;
          Color bgColor = _kBeigeCard;
          Color borderColor = _kBeigeBorder;

          if (aRepondu) {
            if (isCorrect) {
              bgColor = const Color(0xFFE8F4EE);
              borderColor = _kGreenPrimary;
            } else if (isSelected && !isCorrect) {
              bgColor = const Color(0xFFFFEBEB);
              borderColor = const Color(0xFFFF4B4B);
            }
          }

          return GestureDetector(
            onTap: () => _selectReponse(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor, width: 2),
              ),
              child: Row(children: [
                Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isCorrect ? _kGreenPrimary : const Color(0xFFFF4B4B))
                        : (aRepondu && isCorrect ? _kGreenPrimary : _kBeigeBorder),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(['A', 'B', 'C', 'D'][index],
                        style: TextStyle(
                          color: (isSelected || (aRepondu && isCorrect))
                              ? Colors.white : _kTextMid,
                          fontWeight: FontWeight.w800, fontSize: 13)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(question.options[index],
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600,
                          color: aRepondu && isCorrect ? _kGreenPrimary : _kTextDark)),
                ),
                if (aRepondu)
                  Icon(
                    isCorrect ? Icons.check_circle_rounded
                        : (isSelected ? Icons.cancel_rounded : Icons.circle_outlined),
                    color: isCorrect ? _kGreenPrimary
                        : (isSelected ? const Color(0xFFFF4B4B) : Colors.transparent),
                    size: 20,
                  ),
              ]),
            ),
          );
        }),

        // Explication + bouton suivant
        if (aRepondu) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F4EE),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kGreenPrimary.withOpacity(0.3), width: 1),
            ),
            child: Text('💡 ${question.explication}',
                style: const TextStyle(fontSize: 13, color: _kGreenPrimary, height: 1.5)),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _kGreenPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: _prochainQuestion,
              child: Text(
                _questionIndex < _quizQuestions.length - 1
                    ? 'Question suivante ➜'
                    : 'Voir le résultat 🏆',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ]),
    );
  }
}

// ── Résultat du Quiz ───────────────────────────────────────────────
class _ResultatQuiz extends StatelessWidget {
  final int score, total;
  final VoidCallback onRestart;
  const _ResultatQuiz({required this.score, required this.total, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    final percent = score / total;
    final emoji = percent >= 0.8 ? '🏆' : percent >= 0.5 ? '⭐' : '📚';
    final message = percent >= 0.8
        ? 'ماشاءالله ! Excellent !'
        : percent >= 0.5
            ? 'Bien joué ! Continue à apprendre !'
            : 'Continue à apprendre, إن شاء الله tu progresseras !';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            Text('$score / $total',
                style: const TextStyle(
                    fontSize: 48, fontWeight: FontWeight.w900, color: _kGreenPrimary)),
            const Text('bonnes réponses',
                style: TextStyle(color: _kTextLight, fontSize: 16)),
            const SizedBox(height: 16),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700, color: _kTextMid)),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _kGreenPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: onRestart,
              icon: const Icon(Icons.refresh),
              label: const Text('Recommencer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}
