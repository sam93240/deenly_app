// famille_screen.dart — Module Espace Familles · Application UpYourDeen
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'famille_data.dart';

// ── Palette ───────────────────────────────────────────────────────────────
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

const _kBronze = Color(0xFFCD7F32);
const _kSilver = Color(0xFFC0C0C0);
const _kOrGold = Color(0xFFFFD700);

// ══════════════════════════════════════════════════════════════════════════
// ÉCRAN PRINCIPAL
// ══════════════════════════════════════════════════════════════════════════
class FamilleScreen extends StatefulWidget {
  const FamilleScreen({super.key});
  @override
  State<FamilleScreen> createState() => _FamilleScreenState();
}

class _FamilleScreenState extends State<FamilleScreen>
    with TickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 130,
            pinned: true,
            backgroundColor: _kGreenDeep,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_kGreenDeep, _kGreenPrimary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('🌙', style: const TextStyle(fontSize: 28)),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Espace Familles',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tab,
              indicatorColor: _kGold,
              indicatorWeight: 3,
              labelColor: _kGold,
              unselectedLabelColor: const Color(0xFF8AB8A0),
              labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: const [
                Tab(text: '🕌 Prophètes'),
                Tab(text: '📖 Histoires'),
                Tab(text: '🕐 Frise'),
                Tab(text: '🌙 Bonsoir'),
                Tab(text: '📋 Suivi'),
                Tab(text: '🎯 Défis'),
                Tab(text: '💡 Conseils'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tab,
          children: const [
            _ProphetsTab(),
            _CoranicTab(),
            _TimelineTab(),
            _BedtimeTab(),
            _SuiviTab(),
            _DefisTab(),
            _ConseilsTab(),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 1 — PROPHÈTES
// ══════════════════════════════════════════════════════════════════════════
class _ProphetsTab extends StatelessWidget {
  const _ProphetsTab();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(14),
      itemCount: kProphets.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (ctx, i) => _ProphetCard(prophet: kProphets[i]),
    );
  }
}

class _ProphetCard extends StatelessWidget {
  final Prophet prophet;
  const _ProphetCard({required this.prophet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => _ProphetDetailScreen(prophet: prophet)),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBeigeBorder),
          boxShadow: const [
            BoxShadow(color: Color(0x10000000), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_kGreenPrimary, _kGreenMedium],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(prophet.emoji, style: const TextStyle(fontSize: 28)),
                  ),
                ),
                Positioned(
                  top: -6, right: -6,
                  child: Container(
                    width: 22, height: 22,
                    decoration: const BoxDecoration(
                      color: _kGold,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('${prophet.number}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(prophet.arabicName,
                      style: const TextStyle(
                        color: _kGold,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(prophet.frenchName,
                      style: const TextStyle(
                        color: _kTextDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 3),
                  Text(prophet.shortDesc,
                      style: const TextStyle(color: _kTextLight, fontSize: 12.5),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            // Liens famille rapides
            if (prophet.familyLinks.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: _kGoldLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.family_restroom, color: _kGold, size: 18),
              ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: _kTextLight),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// DÉTAIL PROPHÈTE (avec chapitres, résumé/complet, liens famille, badges)
// ──────────────────────────────────────────────────────────────────────────
class _ProphetDetailScreen extends StatefulWidget {
  final Prophet prophet;
  const _ProphetDetailScreen({required this.prophet});
  @override
  State<_ProphetDetailScreen> createState() => _ProphetDetailScreenState();
}

class _ProphetDetailScreenState extends State<_ProphetDetailScreen> {
  final Map<int, int?> _answers = {};
  bool _quizOpen = false;
  bool _showFullStory = false; // false = résumé, true = chapitres
  int _currentChapter = 0;
  QuizDifficulty _selectedDifficulty = QuizDifficulty.facile;

  List<QuizQ> get _filteredQuiz =>
      widget.prophet.quiz.where((q) => q.difficulty == _selectedDifficulty).toList();

  int get _score {
    final quiz = _filteredQuiz;
    int s = 0;
    for (int i = 0; i < quiz.length; i++) {
      if (_answers[i] == quiz[i].correctIndex) s++;
    }
    return s;
  }

  bool get _allAnswered {
    final quiz = _filteredQuiz;
    for (int i = 0; i < quiz.length; i++) {
      if (!_answers.containsKey(i) || _answers[i] == null) return false;
    }
    return true;
  }

  String _badgeForScore(int score, int total) {
    if (total == 0) return '';
    final pct = (score * 100 ~/ total);
    if (pct >= 95) return '✨ UpYourDeen';
    if (pct >= 90) return '👑 Imam al-Qisas';
    if (pct >= 80) return '🏆 \'Alim';
    if (pct >= 70) return '⭐ Faqih';
    if (pct >= 50) return '💪 Mujtahid';
    return '📖 Talib al-\'Ilm';
  }

  Color _tierColor(int score, int total) {
    if (total == 0) return _kBronze;
    final pct = (score * 100 ~/ total);
    if (pct >= 80) return _kOrGold;
    if (pct >= 50) return _kSilver;
    return _kBronze;
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.prophet;
    final hasChapters = p.chapters.isNotEmpty;
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kGreenDeep,
        foregroundColor: Colors.white,
        title: Text('${p.emoji} ${p.frenchName}'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kGreenDeep, _kGreenPrimary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(p.emoji, style: const TextStyle(fontSize: 52)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.arabicName,
                            style: const TextStyle(
                              color: _kGold,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('Prophète n°${p.number}',
                            style: const TextStyle(
                                color: Color(0xFFB8D4C0), fontSize: 13)),
                        const SizedBox(height: 2),
                        Text(p.period,
                            style: const TextStyle(
                                color: Color(0xFF8AB8A0), fontSize: 12)),
                        const SizedBox(height: 4),
                        // Timeline info
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Color(0xFF8AB8A0), size: 12),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                '${p.timeline.region} · ${p.timeline.approxDate}',
                                style: const TextStyle(color: Color(0xFF8AB8A0), fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Liens familiaux ─────────────────────────────────────────
            if (p.familyLinks.isNotEmpty) ...[
              _sectionTitle('Liens familiaux'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: p.familyLinks.map((link) {
                  final linked = kProphets.where((pr) => pr.number == link.prophetNumber).toList();
                  final linkedName = linked.isNotEmpty ? linked.first.frenchName : '?';
                  final linkedEmoji = linked.isNotEmpty ? linked.first.emoji : '';
                  return GestureDetector(
                    onTap: () {
                      if (linked.isNotEmpty) {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (_) => _ProphetDetailScreen(prophet: linked.first)));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: _kGoldLight,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _kGold.withOpacity(0.4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(linkedEmoji, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text('$linkedName (${link.relation})',
                              style: const TextStyle(
                                color: _kTextDark, fontSize: 12.5,
                                fontWeight: FontWeight.w500)),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward_ios, size: 10, color: _kGold),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],

            // ── Toggle Résumé / Histoire complète ───────────────────────
            Row(
              children: [
                Expanded(child: _sectionTitle(_showFullStory ? 'Son Histoire' : 'Résumé')),
                if (hasChapters)
                  GestureDetector(
                    onTap: () => setState(() {
                      _showFullStory = !_showFullStory;
                      _currentChapter = 0;
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _showFullStory ? _kGreenPrimary : _kGoldLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _showFullStory ? Icons.menu_book : Icons.short_text,
                            size: 16,
                            color: _showFullStory ? Colors.white : _kGold,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _showFullStory ? 'Chapitres' : 'Lire l\'histoire',
                            style: TextStyle(
                              color: _showFullStory ? Colors.white : _kGold,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            // ── Contenu : Résumé OU Chapitres ──────────────────────────
            if (!_showFullStory) ...[
              // Mode résumé
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _kBeigeCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kBeigeBorder),
                ),
                child: Text(p.summary,
                    style: const TextStyle(
                      color: _kTextDark,
                      fontSize: 15,
                      height: 1.7,
                    )),
              ),
            ] else if (hasChapters) ...[
              // Mode chapitres
              // Table des matières
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: _kBeigeCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kBeigeBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Chapitres',
                        style: TextStyle(
                          color: _kGreenPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 8),
                    ...List.generate(p.chapters.length, (i) {
                      final isActive = i == _currentChapter;
                      return GestureDetector(
                        onTap: () => setState(() => _currentChapter = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: isActive ? _kGreenPrimary.withOpacity(0.1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24, height: 24,
                                decoration: BoxDecoration(
                                  color: isActive ? _kGreenPrimary : _kBeigeBorder,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text('${i + 1}',
                                      style: TextStyle(
                                        color: isActive ? Colors.white : _kTextLight,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(p.chapters[i].title,
                                    style: TextStyle(
                                      color: isActive ? _kGreenPrimary : _kTextMid,
                                      fontSize: 13,
                                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                                    )),
                              ),
                              if (isActive)
                                const Icon(Icons.play_arrow, color: _kGreenPrimary, size: 16),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              // Contenu du chapitre actuel
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _kBeigeCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kBeigeBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre du chapitre
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _kGreenPrimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Chapitre ${_currentChapter + 1} — ${p.chapters[_currentChapter].title}',
                        style: const TextStyle(
                          color: _kGreenPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(p.chapters[_currentChapter].content,
                        style: const TextStyle(
                          color: _kTextDark,
                          fontSize: 14.5,
                          height: 1.7,
                        )),
                    const SizedBox(height: 16),
                    // Navigation chapitres
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentChapter > 0)
                          _chapterNavButton(
                            icon: Icons.arrow_back_ios,
                            label: 'Précédent',
                            onTap: () => setState(() => _currentChapter--),
                          )
                        else
                          const SizedBox(),
                        Text('${_currentChapter + 1} / ${p.chapters.length}',
                            style: const TextStyle(color: _kTextLight, fontSize: 12)),
                        if (_currentChapter < p.chapters.length - 1)
                          _chapterNavButton(
                            icon: Icons.arrow_forward_ios,
                            label: 'Suivant',
                            onTap: () => setState(() => _currentChapter++),
                            reverse: true,
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Pas de chapitres, afficher fullStory
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _kBeigeCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kBeigeBorder),
                ),
                child: Text(p.fullStory,
                    style: const TextStyle(
                      color: _kTextDark,
                      fontSize: 14.5,
                      height: 1.7,
                    )),
              ),
            ],
            const SizedBox(height: 16),

            // ── Faits clés ──────────────────────────────────────────────
            _sectionTitle('À retenir'),
            const SizedBox(height: 8),
            ...p.keyFacts.map((f) => _FactChip(text: f)),
            const SizedBox(height: 16),

            // ── Moral ───────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kGoldLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kGold.withOpacity(0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(p.moral,
                        style: const TextStyle(
                          color: _kTextDark,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Quiz avec niveaux ───────────────────────────────────────
            GestureDetector(
              onTap: () => setState(() {
                _quizOpen = !_quizOpen;
                _answers.clear();
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: _kGreenPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Text('🧠', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text('Quiz du Prophète',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                    ),
                    Icon(
                      _quizOpen ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            if (_quizOpen) ...[
              const SizedBox(height: 12),
              // Sélecteur de difficulté
              Row(
                children: QuizDifficulty.values.map((d) {
                  final isSelected = d == _selectedDifficulty;
                  final label = d == QuizDifficulty.facile ? '🟢 Facile'
                      : d == QuizDifficulty.moyen ? '🟡 Moyen' : '🔴 Difficile';
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _selectedDifficulty = d;
                        _answers.clear();
                      }),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? _kGreenPrimary : _kBeigeCard,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? _kGreenPrimary : _kBeigeBorder,
                          ),
                        ),
                        child: Center(
                          child: Text(label,
                              style: TextStyle(
                                color: isSelected ? Colors.white : _kTextMid,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              if (_filteredQuiz.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _kBeigeCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kBeigeBorder),
                  ),
                  child: const Center(
                    child: Text('Pas de questions pour ce niveau.',
                        style: TextStyle(color: _kTextLight, fontSize: 14)),
                  ),
                )
              else ...[
                ...List.generate(_filteredQuiz.length,
                    (i) => _QuizCard(
                      question: _filteredQuiz[i],
                      selectedAnswer: _answers[i],
                      onAnswer: (idx) {
                        if (_answers[i] == null) {
                          setState(() => _answers[i] = idx);
                        }
                      },
                    )),
                if (_allAnswered) ...[
                  const SizedBox(height: 16),
                  _ScoreCard(
                    score: _score,
                    total: _filteredQuiz.length,
                    badge: _badgeForScore(_score, _filteredQuiz.length),
                    tierColor: _tierColor(_score, _filteredQuiz.length),
                  ),
                ],
              ],
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _chapterNavButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool reverse = false,
  }) {
    final children = [
      Icon(icon, size: 14, color: _kGreenPrimary),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(color: _kGreenPrimary, fontSize: 12.5, fontWeight: FontWeight.w600)),
    ];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _kGreenPrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: reverse ? children.reversed.toList() : children,
        ),
      ),
    );
  }

  Widget _sectionTitle(String t) => Text(t,
      style: const TextStyle(
        color: _kGreenPrimary,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ));
}

class _FactChip extends StatelessWidget {
  final String text;
  const _FactChip({required this.text});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 8, height: 8,
              decoration: const BoxDecoration(color: _kGold, shape: BoxShape.circle),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text,
                  style: const TextStyle(
                      color: _kTextMid, fontSize: 14, height: 1.4)),
            ),
          ],
        ),
      );
}

class _QuizCard extends StatelessWidget {
  final QuizQ question;
  final int? selectedAnswer;
  final ValueChanged<int> onAnswer;
  const _QuizCard({
    required this.question,
    required this.selectedAnswer,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final answered = selectedAnswer != null;
    // Difficulty badge
    final diffLabel = question.difficulty == QuizDifficulty.facile ? '🟢'
        : question.difficulty == QuizDifficulty.moyen ? '🟡' : '🔴';
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBeigeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(diffLabel, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(question.question,
                    style: const TextStyle(
                      color: _kTextDark,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...List.generate(question.options.length, (i) {
            final isCorrect = i == question.correctIndex;
            final isSelected = selectedAnswer == i;
            Color bg = Colors.transparent;
            Color border = _kBeigeBorder;
            Color text = _kTextMid;
            if (answered) {
              if (isCorrect) {
                bg = const Color(0xFFD4F0DC);
                border = const Color(0xFF2A7A52);
                text = const Color(0xFF1B4D38);
              } else if (isSelected) {
                bg = const Color(0xFFF9D9D9);
                border = const Color(0xFFAA3333);
                text = const Color(0xFF7A1818);
              }
            }
            return GestureDetector(
              onTap: () => onAnswer(i),
              child: Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: border.withOpacity(0.6)),
                        color: isSelected ? border.withOpacity(0.2) : null,
                      ),
                      child: Center(
                        child: Text(String.fromCharCode(65 + i),
                            style: TextStyle(
                              color: text,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(question.options[i],
                            style: TextStyle(color: text, fontSize: 13.5))),
                    if (answered && isCorrect)
                      const Text('✅', style: TextStyle(fontSize: 16)),
                    if (answered && isSelected && !isCorrect)
                      const Text('❌', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          }),
          if (answered) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kGoldLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kGold.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡 ', style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Text(question.explanation,
                        style: const TextStyle(
                          color: _kTextMid,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final int score;
  final int total;
  final String badge;
  final Color tierColor;
  const _ScoreCard({required this.score, required this.total, required this.badge, required this.tierColor});
  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? (score * 100 ~/ total) : 0;
    final msg = pct >= 90
        ? '🌟 Excellent ! Tu maîtrises cette histoire !'
        : pct >= 70
            ? '👍 Très bien ! Continue comme ça !'
            : pct >= 50
                ? '📖 Pas mal ! Encore un peu de révision !'
                : '💪 Continue à apprendre, tu vas y arriver !';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: pct >= 90
            ? const Color(0xFFD4F0DC)
            : pct >= 50
                ? _kGoldLight
                : const Color(0xFFF9D9D9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: pct >= 90
              ? const Color(0xFF2A7A52)
              : pct >= 50
                  ? _kGold
                  : const Color(0xFFAA3333),
        ),
      ),
      child: Column(
        children: [
          Text('$score / $total',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: pct >= 90
                    ? const Color(0xFF1B4D38)
                    : pct >= 50
                        ? _kGold
                        : const Color(0xFF7A1818),
              )),
          const SizedBox(height: 6),
          Text(msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: pct >= 90
                    ? const Color(0xFF1B4D38)
                    : pct >= 50
                        ? const Color(0xFF7A5A00)
                        : const Color(0xFF7A1818),
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 12),
          // Badge gagné
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: tierColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: tierColor.withOpacity(0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.workspace_premium, color: tierColor, size: 20),
                const SizedBox(width: 8),
                Text(badge,
                    style: TextStyle(
                      color: _kTextDark,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 2 — HISTOIRES CORANIQUES
// ══════════════════════════════════════════════════════════════════════════
class _CoranicTab extends StatelessWidget {
  const _CoranicTab();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(14),
      itemCount: kCoranicStories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (ctx, i) => _CoranicCard(story: kCoranicStories[i]),
    );
  }
}

class _CoranicCard extends StatelessWidget {
  final CoranicStory story;
  const _CoranicCard({required this.story});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => _CoranicDetailScreen(story: story)),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBeigeBorder),
          boxShadow: const [
            BoxShadow(color: Color(0x10000000), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kGreenPrimary, _kGreenMedium],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(story.emoji, style: const TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(story.title,
                      style: const TextStyle(
                        color: _kTextDark,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 2),
                  Text(story.arabicTitle,
                      style: const TextStyle(color: _kGold, fontSize: 13)),
                  const SizedBox(height: 3),
                  Text(story.surahRef,
                      style: const TextStyle(color: _kTextLight, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(story.summary,
                      style: const TextStyle(color: _kTextMid, fontSize: 12.5),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _kTextLight),
          ],
        ),
      ),
    );
  }
}

// ── Détail Histoire Coranique (avec chapitres) ──────────────────────────
class _CoranicDetailScreen extends StatefulWidget {
  final CoranicStory story;
  const _CoranicDetailScreen({required this.story});
  @override
  State<_CoranicDetailScreen> createState() => _CoranicDetailScreenState();
}

class _CoranicDetailScreenState extends State<_CoranicDetailScreen> {
  bool _showChapters = false;
  int _currentChapter = 0;

  @override
  Widget build(BuildContext context) {
    final s = widget.story;
    final hasChapters = s.chapters.isNotEmpty;
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kGreenDeep,
        foregroundColor: Colors.white,
        title: Text('${s.emoji} ${s.title}'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kGreenDeep, _kGreenPrimary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.emoji, style: const TextStyle(fontSize: 46)),
                  const SizedBox(height: 8),
                  Text(s.arabicTitle,
                      style: const TextStyle(
                          color: _kGold, fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(s.title,
                      style: const TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(s.surahRef,
                      style: const TextStyle(
                          color: Color(0xFF8AB8A0), fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Toggle résumé/chapitres
            if (hasChapters)
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showChapters = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: !_showChapters ? _kGreenPrimary : _kBeigeCard,
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                          border: Border.all(color: _kGreenPrimary),
                        ),
                        child: Center(
                          child: Text('Résumé',
                              style: TextStyle(
                                color: !_showChapters ? Colors.white : _kGreenPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showChapters = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _showChapters ? _kGreenPrimary : _kBeigeCard,
                          borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
                          border: Border.all(color: _kGreenPrimary),
                        ),
                        child: Center(
                          child: Text('Histoire complète',
                              style: TextStyle(
                                color: _showChapters ? Colors.white : _kGreenPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),

            if (!_showChapters) ...[
              // Résumé
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _kBeigeCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kBeigeBorder),
                ),
                child: Text(s.summary,
                    style: const TextStyle(
                        color: _kTextDark, fontSize: 15, height: 1.7)),
              ),
            ] else ...[
              // Chapitres avec navigation
              ...List.generate(s.chapters.length, (i) {
                final isOpen = i == _currentChapter;
                return GestureDetector(
                  onTap: () => setState(() => _currentChapter = isOpen ? -1 : i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: _kBeigeCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isOpen ? _kGreenPrimary : _kBeigeBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Container(
                                width: 28, height: 28,
                                decoration: BoxDecoration(
                                  color: isOpen ? _kGreenPrimary : _kBeigeBorder,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text('${i + 1}',
                                      style: TextStyle(
                                        color: isOpen ? Colors.white : _kTextLight,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(s.chapters[i].title,
                                    style: TextStyle(
                                      color: isOpen ? _kGreenPrimary : _kTextDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              Icon(
                                isOpen ? Icons.expand_less : Icons.expand_more,
                                color: isOpen ? _kGreenPrimary : _kTextLight,
                              ),
                            ],
                          ),
                        ),
                        if (isOpen)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                            child: Text(s.chapters[i].content,
                                style: const TextStyle(
                                  color: _kTextDark,
                                  fontSize: 14.5,
                                  height: 1.7,
                                )),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
            const SizedBox(height: 16),
            // Moral
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kGoldLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kGold.withOpacity(0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(s.moral,
                        style: const TextStyle(
                            color: _kTextDark,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            height: 1.5)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 3 — FRISE CHRONOLOGIQUE
// ══════════════════════════════════════════════════════════════════════════
class _TimelineTab extends StatelessWidget {
  const _TimelineTab();

  @override
  Widget build(BuildContext context) {
    // Tri par ordre chronologique
    final sorted = List<Prophet>.from(kProphets)
      ..sort((a, b) => a.timeline.order.compareTo(b.timeline.order));

    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: sorted.length + 1, // +1 pour l'en-tête
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kGreenDeep, _kGreenPrimary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('🕐 Frise des Prophètes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 4),
                  Text('Les prophètes dans l\'ordre chronologique, avec leurs liens familiaux.',
                      style: TextStyle(
                        color: Color(0xFFB8D4C0),
                        fontSize: 13,
                      )),
                ],
              ),
            ),
          );
        }
        final p = sorted[i - 1];
        final isLast = i == sorted.length;
        return _TimelineItem(prophet: p, isLast: isLast);
      },
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Prophet prophet;
  final bool isLast;
  const _TimelineItem({required this.prophet, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ligne verticale + point
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 16, height: 16,
                  decoration: BoxDecoration(
                    color: _kGreenPrimary,
                    shape: BoxShape.circle,
                    border: Border.all(color: _kGold, width: 2),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: _kGreenPrimary.withOpacity(0.3),
                    ),
                  ),
              ],
            ),
          ),
          // Carte
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => _ProphetDetailScreen(prophet: prophet))),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kBeigeCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kBeigeBorder),
                ),
                child: Row(
                  children: [
                    Text(prophet.emoji, style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${prophet.frenchName} ${prophet.arabicName}',
                              style: const TextStyle(
                                color: _kTextDark,
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 2),
                          Text(prophet.timeline.approxDate,
                              style: const TextStyle(color: _kGold, fontSize: 12)),
                          Text(prophet.timeline.region,
                              style: const TextStyle(color: _kTextLight, fontSize: 11.5)),
                          // Liens
                          if (prophet.familyLinks.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 4,
                              children: prophet.familyLinks.map((link) {
                                final linked = kProphets.where((pr) => pr.number == link.prophetNumber).toList();
                                final name = linked.isNotEmpty ? linked.first.frenchName : '?';
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _kGoldLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('${link.relation} de $name',
                                      style: const TextStyle(
                                        color: _kTextMid,
                                        fontSize: 10,
                                      )),
                                );
                              }).toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: _kTextLight, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 4 — HISTOIRES DU SOIR
// ══════════════════════════════════════════════════════════════════════════
class _BedtimeTab extends StatelessWidget {
  const _BedtimeTab();

  static const _dayNames = ['', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().weekday;
    final todayStory = kBedtimeStories.firstWhere(
      (s) => s.dayIndex == today,
      orElse: () => kBedtimeStories.first,
    );

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => _BedtimeDetailScreen(story: todayStory)),
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0A1830), Color(0xFF1B2D60)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(color: Color(0x30000000), blurRadius: 10, offset: Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Text(todayStory.emoji, style: const TextStyle(fontSize: 46)),
                    Positioned(
                      top: 0, right: 0,
                      child: Text('🌙', style: const TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ce soir',
                          style: TextStyle(color: Color(0xFF8AB8E0), fontSize: 12)),
                      Text(todayStory.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 4),
                      Text(todayStory.summary,
                          style: const TextStyle(
                              color: Color(0xFFB0C8E0), fontSize: 12.5),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFF8AB8E0)),
              ],
            ),
          ),
        ),
        const Text('Toutes les histoires du soir',
            style: TextStyle(
              color: _kGreenPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 10),
        ...kBedtimeStories.map((s) => _BedtimeCard(
              story: s,
              isToday: s.dayIndex == today,
              dayName: _dayNames[s.dayIndex],
            )),
      ],
    );
  }
}

class _BedtimeCard extends StatelessWidget {
  final BedtimeStory story;
  final bool isToday;
  final String dayName;
  const _BedtimeCard({required this.story, required this.isToday, required this.dayName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => _BedtimeDetailScreen(story: story)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isToday ? const Color(0xFFE8F0FF) : _kBeigeCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isToday ? const Color(0xFF3D5A9E) : _kBeigeBorder,
            width: isToday ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(story.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(story.title,
                      style: const TextStyle(
                        color: _kTextDark,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 2),
                  Text(story.summary,
                      style: const TextStyle(color: _kTextLight, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(dayName,
                    style: TextStyle(
                      color: isToday ? const Color(0xFF3D5A9E) : _kTextLight,
                      fontSize: 11,
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    )),
                if (isToday) ...[
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D5A9E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Ce soir',
                        style: TextStyle(color: Colors.white, fontSize: 9)),
                  ),
                ],
              ],
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: _kTextLight, size: 18),
          ],
        ),
      ),
    );
  }
}

// ── Détail Histoire du Soir ───────────────────────────────────────────────
class _BedtimeDetailScreen extends StatelessWidget {
  final BedtimeStory story;
  const _BedtimeDetailScreen({required this.story});

  static const _dayNames = ['', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1430),
        foregroundColor: Colors.white,
        title: Text('${story.emoji} ${story.title}'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Text(story.emoji, style: const TextStyle(fontSize: 64)),
                  const SizedBox(height: 8),
                  Text(story.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 4),
                  Text('Histoire du ${_dayNames[story.dayIndex]}',
                      style: const TextStyle(color: Color(0xFF8AB8E0), fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(story.summary,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xFFB0C8E0), fontSize: 13.5)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1A38),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF1E3060)),
              ),
              child: Text(story.story,
                  style: const TextStyle(
                    color: Color(0xFFD8E8FF),
                    fontSize: 15,
                    height: 1.8,
                  )),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF0D2040),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A4A80).withOpacity(0.5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🌟', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(story.moral,
                        style: const TextStyle(
                          color: Color(0xFFD0D8FF),
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text('✨ بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ✨',
                  style: const TextStyle(
                      color: Color(0xFF5A7AAA), fontSize: 14)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 5 — SUIVI ENFANTS
// ══════════════════════════════════════════════════════════════════════════

class _SuiviTab extends StatefulWidget {
  const _SuiviTab();
  @override
  State<_SuiviTab> createState() => _SuiviTabState();
}

class _SuiviTabState extends State<_SuiviTab> {
  final List<Map<String, dynamic>> _enfants = [];
  final Map<String, Set<String>> _souratesApprises = {};
  final Map<String, Set<int>> _stepsValides = {};
  String? _selectedEnfant;

  void _ajouterEnfant(String nom, int age) {
    setState(() {
      _enfants.add({'nom': nom, 'age': age});
      _souratesApprises[nom] = {};
      _stepsValides[nom] = {};
      _selectedEnfant = nom;
    });
  }

  void _toggleSourate(String enfant, String sourate) {
    setState(() {
      final set = _souratesApprises[enfant]!;
      if (set.contains(sourate)) { set.remove(sourate); } else { set.add(sourate); }
    });
  }

  void _toggleStep(String enfant, int step) {
    setState(() {
      final set = _stepsValides[enfant]!;
      if (set.contains(step)) { set.remove(step); } else { set.add(step); }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        // Ajouter un enfant
        GestureDetector(
          onTap: () => _showAjouterEnfant(context),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_kGreenDeep, _kGreenPrimary]),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.person_add_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Ajouter un enfant', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
                Text('${_enfants.length} enfant(s) enregistré(s)', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11)),
              ])),
              Icon(Icons.add_circle_outline_rounded, color: Colors.white.withOpacity(0.7)),
            ]),
          ),
        ),
        const SizedBox(height: 14),

        // Sélecteur enfant
        if (_enfants.isNotEmpty) ...[
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _enfants.map((e) {
                final sel = _selectedEnfant == e['nom'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedEnfant = e['nom']),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: sel ? _kGreenPrimary : _kBeigeCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sel ? _kGreenPrimary : _kBeigeBorder),
                      ),
                      child: Row(children: [
                        const Text('👧 ', style: TextStyle(fontSize: 16)),
                        Text('${e['nom']} (${e['age']} ans)',
                            style: TextStyle(color: sel ? Colors.white : _kTextDark, fontSize: 13, fontWeight: FontWeight.w700)),
                      ]),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Contenu enfant sélectionné
        if (_selectedEnfant != null) ...[
          // Programme prière
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: _kBeigeCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: _kBeigeBorder)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Programme Prière', style: TextStyle(color: _kGreenPrimary, fontSize: 15, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('${_stepsValides[_selectedEnfant]!.length}/${kPrayerSteps.length} étapes validées',
                  style: const TextStyle(color: _kTextLight, fontSize: 11)),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: kPrayerSteps.isEmpty ? 0 : _stepsValides[_selectedEnfant]!.length / kPrayerSteps.length,
                  minHeight: 8, backgroundColor: _kBeigeBorder,
                  valueColor: const AlwaysStoppedAnimation(_kGreenMedium),
                ),
              ),
              const SizedBox(height: 12),
              ...kPrayerSteps.map((step) {
                final done = _stepsValides[_selectedEnfant]!.contains(step.order);
                return GestureDetector(
                  onTap: () => _toggleStep(_selectedEnfant!, step.order),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: done ? _kGreenMedium.withOpacity(0.08) : _kBeige,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: done ? _kGreenMedium.withOpacity(0.3) : _kBeigeBorder),
                    ),
                    child: Row(children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(color: done ? _kGreenMedium : _kBeigeBorder, borderRadius: BorderRadius.circular(8)),
                        child: done
                            ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                            : Center(child: Text('${step.order}', style: const TextStyle(color: _kTextLight, fontSize: 12, fontWeight: FontWeight.w700))),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('${step.emoji} ${step.title}',
                            style: TextStyle(color: _kTextDark, fontSize: 13, fontWeight: FontWeight.w700,
                                decoration: done ? TextDecoration.lineThrough : null)),
                        Text(step.ageRange, style: const TextStyle(color: _kTextLight, fontSize: 10)),
                      ])),
                    ]),
                  ),
                );
              }),
            ]),
          ),
          const SizedBox(height: 14),

          // Mémorisation sourates
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: _kBeigeCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: _kBeigeBorder)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Text('Mémorisation Coran', style: TextStyle(color: _kGreenPrimary, fontSize: 15, fontWeight: FontWeight.w800)),
                const Spacer(),
                Text('${_souratesApprises[_selectedEnfant]!.length}/${kSouratesMemo.length}',
                    style: const TextStyle(color: _kGold, fontSize: 13, fontWeight: FontWeight.w800)),
              ]),
              const SizedBox(height: 12),
              ...['facile', 'moyen', 'avance'].map((diff) {
                final label = diff == 'facile' ? 'Sourates faciles' : diff == 'moyen' ? 'Sourates intermédiaires' : 'Sourates avancées';
                final sourates = kSouratesMemo.where((s) => s.difficulte == diff).toList();
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 6),
                    child: Text(label, style: const TextStyle(color: _kTextMid, fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                  Wrap(spacing: 6, runSpacing: 6, children: sourates.map((s) {
                    final done = _souratesApprises[_selectedEnfant]!.contains(s.nom);
                    return GestureDetector(
                      onTap: () => _toggleSourate(_selectedEnfant!, s.nom),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: done ? _kGreenMedium : _kBeigeCard,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: done ? _kGreenMedium : _kBeigeBorder),
                        ),
                        child: Text(s.nom, style: TextStyle(color: done ? Colors.white : _kTextDark, fontSize: 11, fontWeight: done ? FontWeight.w700 : FontWeight.w500)),
                      ),
                    );
                  }).toList()),
                ]);
              }),
            ]),
          ),
        ],

        // État vide
        if (_enfants.isEmpty)
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: _kGoldLight, borderRadius: BorderRadius.circular(18), border: Border.all(color: _kGold.withOpacity(0.3))),
            child: const Column(children: [
              Text('👶', style: TextStyle(fontSize: 40)),
              SizedBox(height: 12),
              Text('Commencez le suivi', style: TextStyle(color: _kGold, fontSize: 16, fontWeight: FontWeight.w800)),
              SizedBox(height: 6),
              Text('Ajoutez un enfant pour suivre sa progression dans l\'apprentissage de la prière et la mémorisation du Coran.',
                  textAlign: TextAlign.center, style: TextStyle(color: _kTextMid, fontSize: 13, height: 1.4)),
            ]),
          ),
      ],
    );
  }

  void _showAjouterEnfant(BuildContext context) {
    final nomCtrl = TextEditingController();
    final ageCtrl = TextEditingController();
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: _kBeige,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Ajouter un enfant', style: TextStyle(color: _kGreenPrimary, fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          TextField(controller: nomCtrl, decoration: InputDecoration(labelText: 'Prénom', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
          const SizedBox(height: 12),
          TextField(controller: ageCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Âge', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: _kGreenPrimary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              onPressed: () {
                final nom = nomCtrl.text.trim();
                final age = int.tryParse(ageCtrl.text.trim()) ?? 0;
                if (nom.isNotEmpty && age > 0 && age < 18) { _ajouterEnfant(nom, age); Navigator.pop(ctx); }
              },
              child: const Text('Ajouter', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 6 — DÉFIS FAMILLE
// ══════════════════════════════════════════════════════════════════════════

class _DefisTab extends StatelessWidget {
  const _DefisTab();

  @override
  Widget build(BuildContext context) {
    final weekIndex = DateTime.now().difference(DateTime(2025, 1, 1)).inDays ~/ 7;
    final defiSemaine = kFamilyChallenges[weekIndex % kFamilyChallenges.length];

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        // Défi de la semaine (featured)
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF8A4A1A), Color(0xFFB86B2A)]),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: const Color(0xFF8A4A1A).withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                child: const Text('Défi de la semaine', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
              ),
              const Spacer(),
              Text(defiSemaine.emoji, style: const TextStyle(fontSize: 32)),
            ]),
            const SizedBox(height: 10),
            Text(defiSemaine.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            Text(defiSemaine.description, style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 13, height: 1.4)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
              child: Text('⏱️ ${defiSemaine.duration}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 14),
            ...defiSemaine.steps.asMap().entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 22, height: 22, margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                  child: Center(child: Text('${entry.key + 1}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700))),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(entry.value, style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13, height: 1.3))),
              ]),
            )),
          ]),
        ),
        const SizedBox(height: 20),

        const Text('Tous les défis', style: TextStyle(color: _kGreenPrimary, fontSize: 16, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        ...kFamilyChallenges.map((d) => _DefiCard(defi: d)),
      ],
    );
  }
}

class _DefiCard extends StatefulWidget {
  final FamilyChallenge defi;
  const _DefiCard({required this.defi});
  @override
  State<_DefiCard> createState() => _DefiCardState();
}

class _DefiCardState extends State<_DefiCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.defi;
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: _kBeigeCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: _kBeigeBorder)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(d.emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(d.title, style: const TextStyle(color: _kTextDark, fontSize: 14, fontWeight: FontWeight.w700)),
              Row(children: [
                Text('⏱️ ${d.duration}', style: const TextStyle(color: _kTextLight, fontSize: 10)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: _kGreenMedium.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                  child: Text(d.category, style: const TextStyle(color: _kGreenMedium, fontSize: 9, fontWeight: FontWeight.w700)),
                ),
              ]),
            ])),
            Icon(_expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded, color: _kTextLight),
          ]),
          if (_expanded) ...[
            const SizedBox(height: 10),
            Text(d.description, style: const TextStyle(color: _kTextMid, fontSize: 13, height: 1.4)),
            const SizedBox(height: 10),
            ...d.steps.asMap().entries.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${e.key + 1}. ', style: const TextStyle(color: _kGreenMedium, fontSize: 12, fontWeight: FontWeight.w800)),
                Expanded(child: Text(e.value, style: const TextStyle(color: _kTextMid, fontSize: 12, height: 1.3))),
              ]),
            )),
          ],
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 7 — CONSEILS PARENTS
// ══════════════════════════════════════════════════════════════════════════

class _ConseilsTab extends StatefulWidget {
  const _ConseilsTab();
  @override
  State<_ConseilsTab> createState() => _ConseilsTabState();
}

class _ConseilsTabState extends State<_ConseilsTab> {
  String _filter = 'all';

  List<ParentAdvice> get _filtered => _filter == 'all'
      ? kParentAdvices
      : kParentAdvices.where((a) => a.category == _filter).toList();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 44,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          children: kAdviceCategories.entries.map((e) {
            final sel = _filter == e.key;
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: GestureDetector(
                onTap: () => setState(() => _filter = e.key),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: sel ? _kGreenPrimary : _kBeigeCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: sel ? _kGreenPrimary : _kBeigeBorder),
                  ),
                  child: Text(e.value, style: TextStyle(color: sel ? Colors.white : _kTextMid, fontSize: 12, fontWeight: sel ? FontWeight.w800 : FontWeight.w500)),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: _filtered.length,
          itemBuilder: (context, index) {
            final a = _filtered[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: _kBeigeCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: _kBeigeBorder)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(a.emoji, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 10),
                  Expanded(child: Text(a.title, style: const TextStyle(color: _kTextDark, fontSize: 15, fontWeight: FontWeight.w800))),
                ]),
                const SizedBox(height: 10),
                Text(a.content, style: const TextStyle(color: _kTextMid, fontSize: 14, height: 1.55)),
                if (a.hadithRef != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: _kGoldLight, borderRadius: BorderRadius.circular(10)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Text('📚 ', style: TextStyle(fontSize: 12)),
                      Text(a.hadithRef!, style: const TextStyle(color: _kGold, fontSize: 11, fontWeight: FontWeight.w700)),
                    ]),
                  ),
                ],
              ]),
            );
          },
        ),
      ),
    ]);
  }
}
