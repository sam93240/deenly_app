// decouvrir_screen.dart
// Module Découvrir – Application UpYourDeen : Lumière sur ta foi

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'decouvrir_data.dart';
import 'assistant_data.dart';
import 'translations.dart';
import 'app_locale.dart';

String _s(String fr, String en) => AppLocale().isFrench ? fr : en;

// ── Palette Découvrir (bleu profond) ──────────────────────────────
const _kDeep    = Color(0xFF0A1628);
const _kPrimary = Color(0xFF1A3A5C);
const _kMedium  = Color(0xFF2D6A9F);
const _kGold    = Color(0xFFC8933A);
const _kGoldLt  = Color(0xFFFFF4DC);
const _kBeige   = Color(0xFFF6F0E3);
const _kCard    = Color(0xFFFFFFFF);
const _kBorder  = Color(0xFFD6C9AF);
const _kTxtDk   = Color(0xFF1A130A);
const _kTxtMid  = Color(0xFF5A4833);
const _kTxtLt   = Color(0xFF8A7863);

// ── Hub principal ─────────────────────────────────────────────────

class DecouvrirScreen extends StatelessWidget {
  const DecouvrirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dayIndex = DateTime.now().difference(DateTime(2025, 1, 1)).inDays;
    final questionDuJour = kQuestionsDuJour[dayIndex % kQuestionsDuJour.length];
    final sagesseDuJour = kSagesses[dayIndex % kSagesses.length];

    return Scaffold(
      backgroundColor: _kBeige,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: _kPrimary,
            leading: GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 15),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_kDeep, _kPrimary],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(60, 10, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(context.t.discoverTitle,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900)),
                        Text(context.t.discoverSubtitle,
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.55),
                                fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Question du jour (featured card)
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => _QuestionDetailScreen(question: questionDuJour))),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_kDeep, _kPrimary],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: _kPrimary.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: _kGold.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(context.t.discoverQuestionOfDay,
                                style: const TextStyle(
                                    color: _kGold,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800)),
                          ),
                          const Spacer(),
                          Text(questionDuJour.emoji,
                              style: const TextStyle(fontSize: 28)),
                        ]),
                        const SizedBox(height: 12),
                        Text(questionDuJour.question,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                height: 1.3)),
                        const SizedBox(height: 8),
                        Text(context.t.discoverTapToReveal,
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 11)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Sagesse du jour
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _kGoldLt,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _kGold.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(sagesseDuJour.emoji,
                            style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Text(context.t.discoverWisdom,
                            style: const TextStyle(
                                color: _kGold,
                                fontSize: 12,
                                fontWeight: FontWeight.w800)),
                      ]),
                      const SizedBox(height: 8),
                      Text(sagesseDuJour.texte,
                          style: const TextStyle(
                              color: _kTxtDk,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              height: 1.5)),
                      const SizedBox(height: 6),
                      Text('— ${sagesseDuJour.auteur}',
                          style: const TextStyle(
                              color: _kTxtLt,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ── Assistant IA ──
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => const _AssistantScreen())),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1A6B4A), Color(0xFF0D4A32)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFF1A6B4A).withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6)),
                      ],
                    ),
                    child: Row(children: [
                      Container(
                        width: 52, height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text('\u{1F916}',
                              style: TextStyle(fontSize: 28)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_s('Pose ta Question', 'Ask Your Question'),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900)),
                            const SizedBox(height: 3),
                            Text(
                                "${kAssistantTopics.length} ${_s('thèmes', 'topics')} · Ramadan, Hajj, ${_s('Mariage', 'Marriage')}...",
                                style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 11)),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.white.withValues(alpha: 0.5), size: 18),
                    ]),
                  ),
                ),
                const SizedBox(height: 16),

                // Section cards
                _HubSection(
                  emoji: '\u2753',
                  title: _s('Questions du Jour', 'Questions of the Day'),
                  subtitle: "${kQuestionsDuJour.length} ${_s('questions pour apprendre', 'questions to learn')}",
                  color: _kMedium,
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => const _QuestionsListScreen())),
                ),
                _HubSection(
                  emoji: '💡',
                  title: _s('Le Saviez-Vous ?', 'Did You Know?'),
                  subtitle: _s('Faits fascinants sur l\'Islam et la science', 'Fascinating facts about Islam and science'),
                  color: const Color(0xFF8A6A3A),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => const _FaitsScreen())),
                ),
                _HubSection(
                  emoji: '🌟',
                  title: context.t.discoverProphetStories,
                  subtitle: "${kProphetStories.length} ${_s('prophètes et leurs leçons', 'prophets and their lessons')}",
                  color: const Color(0xFF2A7A52),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => const _ProphetesScreen())),
                ),
                _HubSection(
                  emoji: '📜',
                  title: _s('Sagesses & Citations', 'Wisdom & Quotes'),
                  subtitle: "${kSagesses.length} ${_s('paroles de sagesse', 'words of wisdom')}",
                  color: const Color(0xFF6A3FAA),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => const _SagessesScreen())),
                ),
                _HubSection(
                  emoji: '🧠',
                  title: _s('Quiz Islamique', 'Islamic Quiz'),
                  subtitle: _s('Teste tes connaissances !', 'Test your knowledge!'),
                  color: const Color(0xFFB85C3A),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => const _QuizScreen())),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _HubSection extends StatelessWidget {
  final String emoji, title, subtitle;
  final Color color;
  final VoidCallback onTap;

  const _HubSection({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kBorder, width: 1.2),
          boxShadow: const [
            BoxShadow(
                color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Row(children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: _kTxtDk,
                        fontSize: 15,
                        fontWeight: FontWeight.w800)),
                Text(subtitle,
                    style: const TextStyle(color: _kTxtLt, fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: color, size: 24),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// QUESTION DU JOUR — Détail
// ══════════════════════════════════════════════════════════════════

class _QuestionDetailScreen extends StatelessWidget {
  final QuestionDuJour question;
  const _QuestionDetailScreen({required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: Text(_s('Question du Jour', 'Question of the Day'),
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [_kDeep, _kPrimary]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(children: [
                Text(question.emoji, style: const TextStyle(fontSize: 40)),
                const SizedBox(height: 12),
                Text(question.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.3)),
              ]),
            ),
            const SizedBox(height: 20),

            // Réponse
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _kBorder, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.t.discoverAnswer,
                      style: const TextStyle(
                          color: _kPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Text(question.reponse,
                      style: const TextStyle(
                          color: _kTxtMid, fontSize: 15, height: 1.6)),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _kGoldLt,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(children: [
                      const Text('📚 ', style: TextStyle(fontSize: 14)),
                      Expanded(
                        child: Text('Source : ${question.source}',
                            style: const TextStyle(
                                color: _kGold,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// QUESTIONS — Liste
// ══════════════════════════════════════════════════════════════════

class _QuestionsListScreen extends StatelessWidget {
  const _QuestionsListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: Text(_s('Questions du Jour', 'Questions of the Day'),
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kQuestionsDuJour.length,
        itemBuilder: (context, index) {
          final q = kQuestionsDuJour[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => _QuestionDetailScreen(question: q))),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _kBorder, width: 1.2),
              ),
              child: Row(children: [
                Text(q.emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(q.question,
                      style: const TextStyle(
                          color: _kTxtDk,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: _kTxtLt, size: 22),
              ]),
            ),
          );
        },
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// LE SAVIEZ-VOUS ?
// ══════════════════════════════════════════════════════════════════

class _FaitsScreen extends StatelessWidget {
  const _FaitsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: Text(_s('Le Saviez-Vous ?', 'Did You Know?'),
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kFaitsMarquants.length,
        itemBuilder: (context, index) {
          final f = kFaitsMarquants[index];
          return _FaitCard(fait: f);
        },
      ),
    );
  }
}

class _FaitCard extends StatefulWidget {
  final FaitMarquant fait;
  const _FaitCard({required this.fait});

  @override
  State<_FaitCard> createState() => _FaitCardState();
}

class _FaitCardState extends State<_FaitCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final f = widget.fait;
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kBorder, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(f.emoji, style: const TextStyle(fontSize: 26)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(f.titre,
                    style: const TextStyle(
                        color: _kTxtDk,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
              ),
              Icon(_expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                  color: _kTxtLt),
            ]),
            if (_expanded) ...[
              const SizedBox(height: 12),
              Text(f.contenu,
                  style: const TextStyle(
                      color: _kTxtMid, fontSize: 14, height: 1.6)),
            ],
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// HISTOIRES DES PROPHÈTES
// ══════════════════════════════════════════════════════════════════

class _ProphetesScreen extends StatelessWidget {
  const _ProphetesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: Text(context.t.discoverProphetStories,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kProphetStories.length,
        itemBuilder: (context, index) {
          final p = kProphetStories[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => _ProphetDetailScreen(prophet: p))),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _kBorder, width: 1.2),
              ),
              child: Row(children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    color: _kPrimary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                      child: Text(p.emoji,
                          style: const TextStyle(fontSize: 26))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(p.displayNom,
                            style: const TextStyle(
                                color: _kTxtDk,
                                fontSize: 15,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(width: 8),
                        Text(p.nomArabe,
                            style: const TextStyle(
                                color: _kMedium,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ]),
                      Text(p.titre,
                          style: const TextStyle(
                              color: _kTxtLt, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: _kTxtLt, size: 22),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class _ProphetDetailScreen extends StatelessWidget {
  final ProphetStory prophet;
  const _ProphetDetailScreen({required this.prophet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: Text(prophet.displayNom,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
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
                gradient: const LinearGradient(colors: [_kDeep, _kPrimary]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(children: [
                Text(prophet.emoji, style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                Text(prophet.nomArabe,
                    style: const TextStyle(
                        color: _kGold, fontSize: 28, fontWeight: FontWeight.w800)),
                Text(prophet.titre,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7), fontSize: 13)),
              ]),
            ),
            const SizedBox(height: 16),

            // Résumé
            _DetailCard(title: _s('L\'histoire', 'The Story'), child: Text(prophet.resume,
                style: const TextStyle(
                    color: _kTxtMid, fontSize: 15, height: 1.6))),
            const SizedBox(height: 12),

            // Leçons
            _DetailCard(
              title: _s('Leçons à retenir', 'Lessons to Remember'),
              child: Column(
                children: prophet.lecons.map((l) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('✦ ',
                          style: TextStyle(
                              color: _kGold, fontSize: 14, fontWeight: FontWeight.w800)),
                      Expanded(
                        child: Text(l,
                            style: const TextStyle(
                                color: _kTxtMid, fontSize: 14, height: 1.4)),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 12),

            // Verset clé
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kGoldLt,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _kGold.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.t.discoverVerseKey,
                      style: const TextStyle(
                          color: _kGold,
                          fontSize: 12,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text('« ${prophet.versetCle} »',
                      style: const TextStyle(
                          color: _kTxtDk,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          height: 1.5)),
                  const SizedBox(height: 6),
                  Text(prophet.refVerset,
                      style: const TextStyle(
                          color: _kTxtLt,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SAGESSES & CITATIONS
// ══════════════════════════════════════════════════════════════════

class _SagessesScreen extends StatefulWidget {
  const _SagessesScreen();

  @override
  State<_SagessesScreen> createState() => _SagessesScreenState();
}

class _SagessesScreenState extends State<_SagessesScreen> {
  String _filter = 'all';

  List<Sagesse> get _filtered => _filter == 'all'
      ? kSagesses
      : kSagesses.where((s) => s.categorie == _filter).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: Text(_s('Sagesses & Citations', 'Wisdom & Quotes'),
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
      ),
      body: Column(
        children: [
          // Filters
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              children: kSagesseCategories.entries.map((e) {
                final selected = _filter == e.key;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: GestureDetector(
                    onTap: () => setState(() => _filter = e.key),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: selected ? _kPrimary : _kCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: selected ? _kPrimary : _kBorder),
                      ),
                      child: Text(e.value,
                          style: TextStyle(
                              color: selected ? Colors.white : _kTxtMid,
                              fontSize: 12,
                              fontWeight: selected
                                  ? FontWeight.w800
                                  : FontWeight.w500)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final s = _filtered[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: _kCard,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: _kBorder, width: 1.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.emoji, style: const TextStyle(fontSize: 24)),
                      const SizedBox(height: 10),
                      Text(s.texte,
                          style: const TextStyle(
                              color: _kTxtDk,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              height: 1.5)),
                      const SizedBox(height: 10),
                      Text('— ${s.auteur}',
                          style: const TextStyle(
                              color: _kMedium,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// QUIZ ISLAMIQUE
// ══════════════════════════════════════════════════════════════════

class _QuizScreen extends StatefulWidget {
  const _QuizScreen();

  @override
  State<_QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<_QuizScreen> {
  late List<QuizQuestion> _questions;
  int _current = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _startQuiz();
  }

  void _startQuiz() {
    final shuffled = List<QuizQuestion>.from(kQuizQuestions)..shuffle(Random());
    _questions = shuffled.take(10).toList();
    _current = 0;
    _score = 0;
    _selectedAnswer = null;
    _answered = false;
    _finished = false;
  }

  void _answer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _questions[_current].correctIndex) _score++;
    });
  }

  void _next() {
    setState(() {
      if (_current < _questions.length - 1) {
        _current++;
        _selectedAnswer = null;
        _answered = false;
      } else {
        _finished = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: Text(_finished
            ? _s('Résultats', 'Results')
            : 'Question ${_current + 1}/${_questions.length}',
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
      ),
      body: _finished ? _buildResults() : _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    final q = _questions[_current];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: (_current + 1) / _questions.length,
              minHeight: 6,
              backgroundColor: _kBorder,
              valueColor: const AlwaysStoppedAnimation(_kMedium),
            ),
          ),
          const SizedBox(height: 4),
          Text('Score : $_score/${_current + (_answered ? 1 : 0)}',
              style: const TextStyle(
                  color: _kTxtLt, fontSize: 11, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),

          // Question
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_kDeep, _kPrimary]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(q.question,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.4)),
          ),
          const SizedBox(height: 16),

          // Options
          for (int i = 0; i < q.options.length; i++)
            GestureDetector(
              onTap: () => _answer(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: !_answered
                      ? _kCard
                      : i == q.correctIndex
                          ? const Color(0xFFEEF7F2)
                          : i == _selectedAnswer
                              ? const Color(0xFFFDE8E8)
                              : _kCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: !_answered
                        ? _kBorder
                        : i == q.correctIndex
                            ? const Color(0xFF2A7A52)
                            : i == _selectedAnswer
                                ? const Color(0xFFC0392B)
                                : _kBorder,
                    width: _answered && (i == q.correctIndex || i == _selectedAnswer)
                        ? 2
                        : 1.2,
                  ),
                ),
                child: Row(children: [
                  Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(
                      color: !_answered
                          ? _kBeige
                          : i == q.correctIndex
                              ? const Color(0xFF2A7A52)
                              : i == _selectedAnswer
                                  ? const Color(0xFFC0392B)
                                  : _kBeige,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: _answered && i == q.correctIndex
                          ? const Icon(Icons.check_rounded,
                              color: Colors.white, size: 18)
                          : _answered && i == _selectedAnswer && i != q.correctIndex
                              ? const Icon(Icons.close_rounded,
                                  color: Colors.white, size: 18)
                              : Text(String.fromCharCode(65 + i),
                                  style: const TextStyle(
                                      color: _kTxtMid,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(q.options[i],
                        style: TextStyle(
                            color: _kTxtDk,
                            fontSize: 15,
                            fontWeight: _answered && i == q.correctIndex
                                ? FontWeight.w800
                                : FontWeight.w500)),
                  ),
                ]),
              ),
            ),

          // Explication
          if (_answered) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kGoldLt,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_s('Explication', 'Explanation'),
                      style: const TextStyle(
                          color: _kGold,
                          fontSize: 12,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(q.explication,
                      style: const TextStyle(
                          color: _kTxtMid, fontSize: 13, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _next,
                child: Text(
                    _current < _questions.length - 1
                        ? _s('Question suivante', 'Next question')
                        : _s('Voir les résultats', 'See results'),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResults() {
    final percent = (_score / _questions.length * 100).round();
    final String message;
    final String emoji;

    if (percent >= 80) {
      emoji = '🏆';
      message = _s('ماشاءالله ! Excellente performance !', 'MashaAllah! Excellent performance!');
    } else if (percent >= 60) {
      emoji = '⭐';
      message = _s('Très bien ! Continue d\'apprendre !', 'Very good! Keep learning!');
    } else if (percent >= 40) {
      emoji = '📚';
      message = _s('Pas mal ! Chaque apprentissage est une bénédiction.', 'Not bad! Every learning is a blessing.');
    } else {
      emoji = '🌱';
      message = _s('C\'est le début du chemin. La recherche du savoir est une adoration !', 'This is the beginning of the path. Seeking knowledge is an act of worship!');
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_kDeep, _kPrimary]),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                    color: _kPrimary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8)),
              ],
            ),
            child: Column(children: [
              Text(emoji, style: const TextStyle(fontSize: 56)),
              const SizedBox(height: 14),
              Text('$_score / ${_questions.length}',
                  style: const TextStyle(
                      color: _kGold,
                      fontSize: 48,
                      fontWeight: FontWeight.w900)),
              Text(context.t.discoverCorrectAnswersPercent(percent),
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7), fontSize: 14)),
              const SizedBox(height: 14),
              Text(message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ]),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _kPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () => setState(() => _startQuiz()),
              child: Text(_s('Rejouer', 'Play Again'),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: _kPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                side: const BorderSide(color: _kPrimary, width: 2),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(_s('Retour', 'Back'),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// ASSISTANT IA (FAQ hors-ligne)
// ══════════════════════════════════════════════════════════════════

class _AssistantScreen extends StatefulWidget {
  const _AssistantScreen();

  @override
  State<_AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<_AssistantScreen> {
  final _ctrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final List<_ChatMsg> _messages = [];
  bool _showTopics = true;

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  // ── Recherche par mots-clés ──────────────────────────────────────
  List<AssistantQA> _search(String query) {
    final words = query
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\sàâäéèêëïîôùûüçœæ]'), '')
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 2)
        .toList();
    if (words.isEmpty) return [];

    final scored = <AssistantQA, int>{};
    for (final topic in kAssistantTopics) {
      for (final qa in topic.questions) {
        int score = 0;
        for (final w in words) {
          for (final kw in qa.keywords) {
            if (kw.contains(w) || w.contains(kw)) score += 3;
          }
          if (qa.question.toLowerCase().contains(w)) score += 2;
          if (qa.reponse.toLowerCase().contains(w)) score += 1;
        }
        if (score > 0) scored[qa] = score;
      }
    }

    final sorted = scored.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(5).map((e) => e.key).toList();
  }

  void _sendQuestion(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _showTopics = false;
      _messages.add(_ChatMsg(text: text.trim(), isUser: true));
    });
    _ctrl.clear();

    final results = _search(text);
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        if (results.isEmpty) {
          _messages.add(_ChatMsg(
            text: _s(
              'Je n\'ai pas de réponse précise pour cette question.\n\n'
              'L\'Imam Malik ibn Anas — le grand savant de Médine — fut un jour interrogé '
              'sur 48 questions. Il répondit à 36 d\'entre elles par « لا أدري » (je ne sais pas). '
              'Ses élèves, surpris, lui demandèrent : « Que dirons-nous aux gens ? » '
              'Il répondit : « Dites-leur que Malik ne sait pas. »\n\n'
              'Si le plus grand savant de son époque n\'avait pas honte de dire '
              '« je ne sais pas », alors moi non plus. 😊\n\n'
              'Essaie de reformuler ta question ou choisis un thème ci-dessous.',
              'I don\'t have a precise answer for this question.\n\n'
              'Imam Malik ibn Anas — the great scholar of Medina — was once asked '
              '48 questions. He answered 36 of them with « لا أدري » (I don\'t know). '
              'His students, surprised, asked him: "What shall we tell the people?" '
              'He replied: "Tell them that Malik does not know."\n\n'
              'If the greatest scholar of his time was not ashamed to say '
              '"I don\'t know", then neither am I. 😊\n\n'
              'Try rephrasing your question or choose a topic below.',
            ),
            isUser: false,
            source: 'Tartib al-Madarik — Qadi Iyad',
          ));
          _showTopics = true;
        } else if (results.length == 1) {
          _messages.add(_ChatMsg(
            text: results.first.reponse,
            isUser: false,
            source: results.first.source,
          ));
        } else {
          // Show best match + suggest others
          _messages.add(_ChatMsg(
            text: results.first.reponse,
            isUser: false,
            source: results.first.source,
            relatedQuestions:
                results.skip(1).map((q) => q.question).toList(),
          ));
        }
      });
      _scrollToBottom();
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _selectTopic(AssistantTopic topic) {
    setState(() {
      _showTopics = false;
      _messages.add(_ChatMsg(
        text: '${topic.emoji} ${topic.title}',
        isUser: true,
      ));
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _messages.add(_ChatMsg(
          text: "${topic.description}\n\n${_s('Voici les questions disponibles :', 'Here are the available questions:')}",
          isUser: false,
          relatedQuestions: topic.questions.map((q) => q.question).toList(),
        ));
      });
      _scrollToBottom();
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D4A32),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Row(children: [
          Text('\u{1F916} ',
              style: TextStyle(fontSize: 22)),
          Text('Assistant UpYourDeen',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900)),
        ]),
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 15),
            ),
          ),
        ),
      ),
      body: Column(children: [
        // ── Messages area ──────────────────────────────
        Expanded(
          child: ListView(
            controller: _scrollCtrl,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            children: [
              // Welcome message
              if (_messages.isEmpty) ...[
                _BotBubble(
                  text: _s(
                    'Assalamu alaykum ! Je suis l\'assistant UpYourDeen. '
                    'Pose-moi une question sur l\'Islam et je ferai de mon '
                    'mieux pour te répondre avec des sources fiables.',
                    'Assalamu alaykum! I am the UpYourDeen assistant. '
                    'Ask me a question about Islam and I will do my '
                    'best to answer you with reliable sources.',
                  ),
                ),
                const SizedBox(height: 12),
                // Quick suggestions
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: kQuickSuggestions.map((s) => GestureDetector(
                    onTap: () => _sendQuestion(s),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A6B4A).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFF1A6B4A).withValues(alpha: 0.2)),
                      ),
                      child: Text(s,
                          style: const TextStyle(
                              color: Color(0xFF1A6B4A),
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 16),
              ],

              // Chat messages
              ..._messages.map((m) {
                if (m.isUser) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A6B4A),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(4),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF1A6B4A)
                                      .withValues(alpha: 0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(m.text,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    height: 1.4)),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _BotBubble(
                            text: m.text, source: m.source),
                        if (m.relatedQuestions != null &&
                            m.relatedQuestions!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(context.t.discoverRelatedQuestions,
                                style: const TextStyle(
                                    color: _kTxtLt,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700)),
                          ),
                          const SizedBox(height: 6),
                          ...m.relatedQuestions!.map((q) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: GestureDetector(
                              onTap: () => _sendQuestion(q),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _kCard,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color(0xFF1A6B4A)
                                          .withValues(alpha: 0.2)),
                                ),
                                child: Row(children: [
                                  const Icon(Icons.touch_app_rounded,
                                      size: 14,
                                      color: Color(0xFF1A6B4A)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(q,
                                        style: const TextStyle(
                                            color: Color(0xFF1A6B4A),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ]),
                              ),
                            ),
                          )),
                        ],
                      ],
                    ),
                  );
                }
              }),

              // Topic grid
              if (_showTopics && _messages.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(context.t.discoverChooseTheme,
                    style: const TextStyle(
                        color: _kTxtMid,
                        fontSize: 13,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: kAssistantTopics.map((t) => GestureDetector(
                    onTap: () => _selectTopic(t),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: _kCard,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kBorder),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(t.emoji,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(t.title,
                              style: const TextStyle(
                                  color: _kTxtDk,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ],

              // Topic grid for empty state
              if (_messages.isEmpty) ...[
                Text(context.t.discoverOrChooseTheme,
                    style: const TextStyle(
                        color: _kTxtMid,
                        fontSize: 13,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: kAssistantTopics.map((t) => GestureDetector(
                    onTap: () => _selectTopic(t),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: _kCard,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kBorder),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(t.emoji,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(t.title,
                              style: const TextStyle(
                                  color: _kTxtDk,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),

        // ── Input bar ──────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 12),
          decoration: BoxDecoration(
            color: _kCard,
            border: Border(top: BorderSide(color: _kBorder.withValues(alpha: 0.5))),
          ),
          child: SafeArea(
            top: false,
            child: Row(children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: _kBeige,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: _kBorder),
                  ),
                  child: TextField(
                    controller: _ctrl,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: _s('Pose ta question...', 'Ask your question...'),
                      hintStyle:
                          const TextStyle(color: _kTxtLt, fontSize: 14),
                    ),
                    style:
                        const TextStyle(color: _kTxtDk, fontSize: 14),
                    onSubmitted: _sendQuestion,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _sendQuestion(_ctrl.text),
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A6B4A),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1A6B4A).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.send_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ── Chat message model ─────────────────────────────────────────────

class _ChatMsg {
  final String text;
  final bool isUser;
  final String? source;
  final List<String>? relatedQuestions;

  const _ChatMsg({
    required this.text,
    required this.isUser,
    this.source,
    this.relatedQuestions,
  });
}

// ── Bot bubble widget ──────────────────────────────────────────────

class _BotBubble extends StatefulWidget {
  final String text;
  final String? source;

  const _BotBubble({required this.text, this.source});

  @override
  State<_BotBubble> createState() => _BotBubbleState();
}

class _BotBubbleState extends State<_BotBubble> {
  bool _copied = false;

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.text));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32, height: 32,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1A6B4A).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text('\u{1F916}', style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
              boxShadow: [
                BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 6,
                    offset: Offset(0, 2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.text,
                    style: const TextStyle(
                        color: _kTxtDk,
                        fontSize: 13,
                        height: 1.55)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (widget.source != null)
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A6B4A).withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.menu_book_rounded,
                                  size: 12,
                                  color: Color(0xFF1A6B4A)),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(widget.source!,
                                    style: const TextStyle(
                                        color: Color(0xFF1A6B4A),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _copy,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _copied
                              ? const Color(0xFF1A6B4A).withValues(alpha: 0.10)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _copied ? Icons.check_rounded : Icons.copy_rounded,
                              size: 12,
                              color: const Color(0xFF1A6B4A).withValues(alpha: 0.6),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              _copied ? _s('Copié', 'Copied') : _s('Copier', 'Copy'),
                              style: TextStyle(
                                color: const Color(0xFF1A6B4A).withValues(alpha: 0.6),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SHARED
// ══════════════════════════════════════════════════════════════════

class _DetailCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _DetailCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: _kPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
