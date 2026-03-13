// journal_screen.dart
// Module Journal Spirituel enrichi – Application Deenly : Lumière sur ta foi

import 'dart:math';
import 'package:flutter/material.dart';
import 'journal_data.dart';

// ── Palette Deenly ──────────────────────────────────────────────────
const _kDeep    = Color(0xFF0A2018);
const _kPrimary = Color(0xFF1B4D38);
const _kMedium  = Color(0xFF2A7A52);
const _kGold    = Color(0xFFC8933A);
const _kGoldLt  = Color(0xFFFFF4DC);
const _kBeige   = Color(0xFFF6F0E3);
const _kCard    = Color(0xFFFFFFFF);
const _kBorder  = Color(0xFFD6C9AF);
const _kTxtDk   = Color(0xFF1A130A);
const _kTxtMid  = Color(0xFF5A4833);
const _kTxtLt   = Color(0xFF8A7863);

// ── Modèles locaux ────────────────────────────────────────────────

class _JournalEntry {
  final String id;
  final DateTime date;
  final String texte;
  final String type; // 'gratitude', 'action', 'dua', 'reflexion', 'note', 'lettre'
  final int points;
  final String? promptId;

  _JournalEntry({
    required this.id,
    required this.date,
    required this.texte,
    required this.type,
    required this.points,
    this.promptId,
  });
}

class _MoodEntry {
  final DateTime date;
  final String moodId;

  _MoodEntry({required this.date, required this.moodId});
}

class _PersonalGoal {
  final String id;
  final String title;
  final String emoji;
  final DateTime created;
  int currentDay;
  int targetDays;
  bool completed;

  _PersonalGoal({
    required this.id,
    required this.title,
    required this.emoji,
    required this.created,
    this.currentDay = 0,
    this.targetDays = 30,
    this.completed = false,
  });
}

class _ZakatRecord {
  final String id;
  final String type;
  final double amount;
  final double zakatDue;
  final DateTime date;
  bool paid;

  _ZakatRecord({
    required this.id,
    required this.type,
    required this.amount,
    required this.zakatDue,
    required this.date,
    this.paid = false,
  });
}

class _DonRecord {
  final String id;
  final String causeId;
  final double amount;
  final DateTime date;
  final String? note;

  _DonRecord({
    required this.id,
    required this.causeId,
    required this.amount,
    required this.date,
    this.note,
  });
}

class _DayScore {
  final DateTime date;
  final int score;
  final int scoreMax;

  _DayScore({required this.date, required this.score, required this.scoreMax});
}

// ── Écran principal ───────────────────────────────────────────────

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  // -- State : Actions quotidiennes --
  final Map<String, bool> _doneActions = {};

  // -- State : Journal --
  final List<_JournalEntry> _entries = [
    _JournalEntry(
      id: '1',
      date: DateTime.now().subtract(const Duration(days: 1)),
      texte: 'Alhamdulillah, j\'ai pu prier Fajr à l\'heure et lire une page du Coran.',
      type: 'gratitude',
      points: 10,
    ),
    _JournalEntry(
      id: 'lettre_demo',
      date: DateTime.now().subtract(const Duration(days: 31)),
      texte: 'Cher moi du futur, j\'espère que tu continues à lire le Coran chaque jour. Rappelle-toi pourquoi tu as commencé ce chemin.',
      type: 'lettre',
      points: 10,
    ),
  ];

  // -- State : Humeur --
  final List<_MoodEntry> _moods = [];
  String? _todayMood;

  // -- State : Streaks --
  int _currentStreak = 0;
  int _bestStreak = 0;

  // -- State : Objectifs --
  final List<_PersonalGoal> _goals = [];

  // -- State : Zakat --
  final List<_ZakatRecord> _zakatRecords = [];

  // -- State : Dons --
  final List<_DonRecord> _donRecords = [];

  // -- State : Calendar history --
  final List<_DayScore> _dayScores = [];

  // -- Computed --
  int get _scoreJour {
    int total = 0;
    for (final cat in kActionCategories) {
      for (final a in cat.actions) {
        if (_doneActions[a.id] == true) total += a.points;
      }
    }
    return total;
  }

  int get _scoreMax {
    int total = 0;
    for (final cat in kActionCategories) {
      for (final a in cat.actions) {
        total += a.points;
      }
    }
    return total;
  }

  int get _doneCount => _doneActions.values.where((v) => v).length;

  int get _totalActions {
    int c = 0;
    for (final cat in kActionCategories) {
      c += cat.actions.length;
    }
    return c;
  }

  ReflectionPrompt get _promptDuJour {
    final day = DateTime.now().difference(DateTime(2025, 1, 1)).inDays;
    return kReflectionPrompts[day % kReflectionPrompts.length];
  }

  StreakMilestone? get _nextMilestone {
    for (final m in kStreakMilestones) {
      if (m.days > _currentStreak) return m;
    }
    return null;
  }

  double get _totalDonsAnnee {
    final now = DateTime.now();
    return _donRecords
        .where((d) => d.date.year == now.year)
        .fold(0.0, (s, d) => s + d.amount);
  }

  _JournalEntry? get _lettreARelire {
    final now = DateTime.now();
    for (final e in _entries) {
      if (e.type == 'lettre') {
        final diff = now.difference(e.date).inDays;
        if (diff >= 30) return e;
      }
    }
    return null;
  }

  _JournalEntry? get _ilYa30Jours {
    final now = DateTime.now();
    for (final e in _entries) {
      if (e.type != 'lettre') {
        final diff = now.difference(e.date).inDays;
        if (diff >= 28 && diff <= 32) return e;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  void _toggleAction(String actionId) {
    setState(() {
      _doneActions[actionId] = !(_doneActions[actionId] ?? false);
      _updateStreak();
    });
  }

  void _setMood(String moodId) {
    setState(() {
      _todayMood = moodId;
      _moods.removeWhere((m) =>
          m.date.year == DateTime.now().year &&
          m.date.month == DateTime.now().month &&
          m.date.day == DateTime.now().day);
      _moods.add(_MoodEntry(date: DateTime.now(), moodId: moodId));
    });
  }

  void _updateStreak() {
    final threshold = _totalActions * 0.5;
    if (_doneCount >= threshold) {
      _currentStreak++;
      if (_currentStreak > _bestStreak) _bestStreak = _currentStreak;
    }
  }

  void _addEntry(String texte, String type, {String? promptId}) {
    setState(() {
      _entries.insert(0, _JournalEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        texte: texte,
        type: type,
        points: 10,
        promptId: promptId,
      ));
    });
  }

  void _addGoal(GoalTemplate tpl, int targetDays) {
    setState(() {
      _goals.add(_PersonalGoal(
        id: '${tpl.id}_${DateTime.now().millisecondsSinceEpoch}',
        title: tpl.title,
        emoji: tpl.emoji,
        created: DateTime.now(),
        targetDays: targetDays,
      ));
    });
  }

  void _incrementGoal(int index) {
    setState(() {
      final g = _goals[index];
      if (g.currentDay < g.targetDays) {
        g.currentDay++;
        if (g.currentDay >= g.targetDays) g.completed = true;
      }
    });
  }

  void _addZakat(_ZakatRecord record) {
    setState(() => _zakatRecords.add(record));
  }

  void _toggleZakatPaid(int index) {
    setState(() => _zakatRecords[index].paid = !_zakatRecords[index].paid);
  }

  void _addDon(_DonRecord record) {
    setState(() => _donRecords.add(record));
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
              controller: _tabCtrl,
              children: [
                _PrieresTab(
                  doneActions: _doneActions,
                  score: _scoreJour,
                  scoreMax: _scoreMax,
                  todayMood: _todayMood,
                  onToggle: _toggleAction,
                  onMood: _setMood,
                ),
                _JournalTab(
                  entries: _entries,
                  promptDuJour: _promptDuJour,
                  lettreARelire: _lettreARelire,
                  ilYa30Jours: _ilYa30Jours,
                  onAdd: _addEntry,
                ),
                _ObjectifsTab(
                  goals: _goals,
                  streak: _currentStreak,
                  bestStreak: _bestStreak,
                  nextMilestone: _nextMilestone,
                  onAddGoal: _addGoal,
                  onIncrement: _incrementGoal,
                ),
                _GenerositeTab(
                  zakatRecords: _zakatRecords,
                  donRecords: _donRecords,
                  totalDonsAnnee: _totalDonsAnnee,
                  onAddZakat: _addZakat,
                  onToggleZakatPaid: _toggleZakatPaid,
                  onAddDon: _addDon,
                ),
                _TableauTab(
                  score: _scoreJour,
                  scoreMax: _scoreMax,
                  entries: _entries,
                  moods: _moods,
                  streak: _currentStreak,
                  bestStreak: _bestStreak,
                  goals: _goals,
                  doneCount: _doneCount,
                  totalActions: _totalActions,
                  totalDonsAnnee: _totalDonsAnnee,
                  donRecords: _donRecords,
                  dayScores: _dayScores,
                ),
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
          colors: [_kDeep, _kPrimary],
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
                        border: Border.all(
                            color: Colors.white.withOpacity(0.2), width: 1),
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
                        const Text('Journal Spirituel',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900)),
                        Text('Réflexions, suivi & générosité',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.55),
                                fontSize: 11)),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _kGold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: _kGold.withOpacity(0.4), width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$_scoreJour',
                            style: const TextStyle(
                                color: _kGold,
                                fontSize: 13,
                                fontWeight: FontWeight.w900)),
                        Text(' / $_scoreMax',
                            style: TextStyle(
                                color: _kGold.withOpacity(0.6), fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TabBar(
              controller: _tabCtrl,
              isScrollable: true,
              indicatorColor: _kGold,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.45),
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
              tabAlignment: TabAlignment.start,
              tabs: const [
                Tab(text: 'Prières', icon: Icon(Icons.checklist_rounded, size: 15)),
                Tab(text: 'Journal', icon: Icon(Icons.book_rounded, size: 15)),
                Tab(text: 'Objectifs', icon: Icon(Icons.flag_rounded, size: 15)),
                Tab(text: 'Générosité', icon: Icon(Icons.volunteer_activism_rounded, size: 15)),
                Tab(text: 'Tableau', icon: Icon(Icons.dashboard_rounded, size: 15)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// TAB 1 : PRIÈRES & ACTIONS QUOTIDIENNES
// ══════════════════════════════════════════════════════════════════

class _PrieresTab extends StatelessWidget {
  final Map<String, bool> doneActions;
  final int score, scoreMax;
  final String? todayMood;
  final Function(String) onToggle;
  final Function(String) onMood;

  const _PrieresTab({
    required this.doneActions,
    required this.score,
    required this.scoreMax,
    required this.todayMood,
    required this.onToggle,
    required this.onMood,
  });

  @override
  Widget build(BuildContext context) {
    final progress = scoreMax > 0 ? score / scoreMax : 0.0;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        // Score bar
        _CardBox(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Score du jour',
                    style: TextStyle(
                        color: _kTxtMid,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
                Text('$score / $scoreMax pts',
                    style: const TextStyle(
                        color: _kPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 13)),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: _kBorder,
                valueColor: AlwaysStoppedAnimation(
                    progress > 0.7 ? _kMedium : _kGold),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 12),

        // Mood picker
        _CardBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Comment te sens-tu aujourd\'hui ?',
                  style: TextStyle(
                      color: _kTxtMid,
                      fontWeight: FontWeight.w700,
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: kMoodOptions.map((m) {
                  final selected = todayMood == m.id;
                  return GestureDetector(
                    onTap: () => onMood(m.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected
                            ? _kPrimary.withOpacity(0.12)
                            : _kBeige,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? _kPrimary : _kBorder,
                          width: selected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(m.emoji, style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 6),
                          Text(m.label,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: selected
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                  color: selected ? _kPrimary : _kTxtMid)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Action categories
        for (final cat in kActionCategories) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Row(children: [
              Text(cat.emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(cat.title,
                  style: const TextStyle(
                      color: _kTxtDk,
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
              const Spacer(),
              Text(
                '${cat.actions.where((a) => doneActions[a.id] == true).length}/${cat.actions.length}',
                style: const TextStyle(
                    color: _kTxtLt, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ]),
          ),
          for (final action in cat.actions)
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: doneActions[action.id] == true
                    ? const Color(0xFFEEF7F2)
                    : _kCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: doneActions[action.id] == true
                      ? const Color(0xFFB8D8C8)
                      : _kBorder,
                  width: 1.2,
                ),
              ),
              child: ListTile(
                dense: true,
                leading: Text(action.emoji,
                    style: const TextStyle(fontSize: 20)),
                title: Text(
                  action.titre,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    decoration: doneActions[action.id] == true
                        ? TextDecoration.lineThrough
                        : null,
                    color: doneActions[action.id] == true
                        ? _kTxtLt
                        : _kTxtDk,
                  ),
                ),
                subtitle: action.detail != null
                    ? Text(action.detail!,
                        style: const TextStyle(fontSize: 10, color: _kTxtLt),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis)
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('+${action.points}',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: doneActions[action.id] == true
                                ? _kMedium
                                : _kTxtLt)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => onToggle(action.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: doneActions[action.id] == true
                              ? _kMedium
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: doneActions[action.id] == true
                                ? _kMedium
                                : _kBorder,
                            width: 2,
                          ),
                        ),
                        child: doneActions[action.id] == true
                            ? const Icon(Icons.check_rounded,
                                color: Colors.white, size: 18)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// TAB 2 : JOURNAL & RÉFLEXIONS (amélioré)
// ══════════════════════════════════════════════════════════════════

class _JournalTab extends StatelessWidget {
  final List<_JournalEntry> entries;
  final ReflectionPrompt promptDuJour;
  final _JournalEntry? lettreARelire;
  final _JournalEntry? ilYa30Jours;
  final Function(String texte, String type, {String? promptId}) onAdd;

  const _JournalTab({
    required this.entries,
    required this.promptDuJour,
    required this.lettreARelire,
    required this.ilYa30Jours,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        elevation: 4,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
        children: [
          // Lettre à relire (notification)
          if (lettreARelire != null)
            _LetterReminderCard(entry: lettreARelire!),

          // Il y a 30 jours
          if (ilYa30Jours != null && lettreARelire == null)
            _ThirtyDaysAgoCard(entry: ilYa30Jours!),

          // Prompt du jour
          GestureDetector(
            onTap: () => _showAddSheet(context, prompt: promptDuJour),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kDeep, _kPrimary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: _kPrimary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4)),
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
                        color: _kGold.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('Réflexion du jour',
                          style: TextStyle(
                              color: _kGold,
                              fontSize: 10,
                              fontWeight: FontWeight.w800)),
                    ),
                    const Spacer(),
                    Text(promptDuJour.emoji,
                        style: const TextStyle(fontSize: 24)),
                  ]),
                  const SizedBox(height: 10),
                  Text(
                    promptDuJour.question,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.4),
                  ),
                  const SizedBox(height: 8),
                  Text('Appuyer pour répondre →',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 11)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Quick action buttons
          Row(children: [
            Expanded(
              child: _QuickAddBtn(
                emoji: '📝',
                label: 'Note privée',
                onTap: () => _showAddSheet(context, forceType: 'note'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _QuickAddBtn(
                emoji: '✉️',
                label: 'Lettre à moi',
                onTap: () => _showAddSheet(context, forceType: 'lettre'),
              ),
            ),
          ]),
          const SizedBox(height: 16),

          // Entry list
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text('Vos entrées (${entries.length})',
                style: const TextStyle(
                    color: _kTxtDk,
                    fontWeight: FontWeight.w800,
                    fontSize: 14)),
          ),

          if (entries.isEmpty)
            _EmptyJournalMessage()
          else
            for (final entry in entries) _EntryCard(entry: entry),
        ],
      ),
    );
  }

  void _showAddSheet(BuildContext context,
      {ReflectionPrompt? prompt, String? forceType}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AddEntrySheet(
        prompt: prompt,
        forceType: forceType,
        onSave: (texte, type) {
          onAdd(texte, type, promptId: prompt?.id);
          Navigator.pop(ctx);
        },
      ),
    );
  }
}

class _LetterReminderCard extends StatefulWidget {
  final _JournalEntry entry;
  const _LetterReminderCard({required this.entry});

  @override
  State<_LetterReminderCard> createState() => _LetterReminderCardState();
}

class _LetterReminderCardState extends State<_LetterReminderCard> {
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    final idx = DateTime.now().day % kLetterReminders.length;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A3FAA), Color(0xFF4A2080)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF6A3FAA).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Text('✉️', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(kLetterReminders[idx],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
          ]),
          const SizedBox(height: 10),
          if (!_revealed)
            GestureDetector(
              onTap: () => setState(() => _revealed = true),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Ouvrir ma lettre',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(widget.entry.texte,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      height: 1.5)),
            ),
        ],
      ),
    );
  }
}

class _ThirtyDaysAgoCard extends StatelessWidget {
  final _JournalEntry entry;
  const _ThirtyDaysAgoCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final days = DateTime.now().difference(entry.date).inDays;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kGoldLt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kGold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Text('🔮', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text('Il y a $days jours, tu écrivais...',
                style: const TextStyle(
                    color: _kGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w800)),
          ]),
          const SizedBox(height: 8),
          Text(entry.texte,
              style: const TextStyle(
                  color: _kTxtMid,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  height: 1.4),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class _QuickAddBtn extends StatelessWidget {
  final String emoji, label;
  final VoidCallback onTap;

  const _QuickAddBtn(
      {required this.emoji, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorder, width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    color: _kTxtDk,
                    fontSize: 13,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _EmptyJournalMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final idx = DateTime.now().day % kWelcomeBackMessages.length;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(children: [
          const Text('📓', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(kWelcomeBackMessages[idx],
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: _kTxtMid, fontSize: 14, height: 1.5)),
          ),
        ]),
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  final _JournalEntry entry;
  const _EntryCard({required this.entry});

  static const _months = [
    '', 'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun',
    'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'
  ];

  Color _typeColor() {
    switch (entry.type) {
      case 'gratitude': return _kPrimary;
      case 'action': return const Color(0xFF1A5C8A);
      case 'dua': return const Color(0xFF6A3FAA);
      case 'reflexion': return _kGold;
      case 'note': return const Color(0xFF5A7A8A);
      case 'lettre': return const Color(0xFF8A3F6A);
      default: return _kTxtLt;
    }
  }

  Color _typeBg() {
    switch (entry.type) {
      case 'gratitude': return const Color(0xFFE8F4EE);
      case 'action': return const Color(0xFFE3EDF7);
      case 'dua': return const Color(0xFFF3ECFA);
      case 'reflexion': return _kGoldLt;
      case 'note': return const Color(0xFFE8EFF3);
      case 'lettre': return const Color(0xFFF8E8F3);
      default: return _kBeige;
    }
  }

  String _typeLabel() {
    switch (entry.type) {
      case 'gratitude': return '💚 Gratitude';
      case 'action': return '✅ Bonne action';
      case 'dua': return '🤲 Du\'a';
      case 'reflexion': return '💭 Réflexion';
      case 'note': return '📝 Note privée';
      case 'lettre': return '✉️ Lettre à moi';
      default: return entry.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: _typeBg(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(_typeLabel(),
                  style: TextStyle(
                      fontSize: 11,
                      color: _typeColor(),
                      fontWeight: FontWeight.w800)),
            ),
            const Spacer(),
            Text(
                '${entry.date.day} ${_months[entry.date.month]} ${entry.date.year}',
                style: const TextStyle(fontSize: 11, color: _kTxtLt)),
          ]),
          const SizedBox(height: 10),
          Text(entry.texte,
              style: TextStyle(
                  fontSize: 14,
                  color: _kTxtMid,
                  height: 1.5,
                  fontStyle: entry.type == 'lettre'
                      ? FontStyle.italic
                      : FontStyle.normal)),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// TAB 3 : OBJECTIFS & STREAKS
// ══════════════════════════════════════════════════════════════════

class _ObjectifsTab extends StatelessWidget {
  final List<_PersonalGoal> goals;
  final int streak, bestStreak;
  final StreakMilestone? nextMilestone;
  final Function(GoalTemplate, int) onAddGoal;
  final Function(int) onIncrement;

  const _ObjectifsTab({
    required this.goals,
    required this.streak,
    required this.bestStreak,
    required this.nextMilestone,
    required this.onAddGoal,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        // Streak card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_kDeep, _kPrimary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: _kPrimary.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6)),
            ],
          ),
          child: Column(children: [
            const Text('🔥', style: TextStyle(fontSize: 36)),
            const SizedBox(height: 6),
            Text('$streak jour${streak > 1 ? 's' : ''} de suite',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text('Meilleur : $bestStreak jours',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6), fontSize: 12)),
            if (nextMilestone != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(children: [
                  Text(nextMilestone!.emoji,
                      style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Prochain palier : ${nextMilestone!.title} (${nextMilestone!.days}j)',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3),
                        Text(nextMilestone!.hadith,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 10,
                                fontStyle: FontStyle.italic),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ]),
        ),
        const SizedBox(height: 20),

        // Current goals
        Row(children: [
          const Text('Mes objectifs',
              style: TextStyle(
                  color: _kTxtDk,
                  fontWeight: FontWeight.w800,
                  fontSize: 15)),
          const Spacer(),
          GestureDetector(
            onTap: () => _showGoalPicker(context),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _kPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('+ Ajouter',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
        const SizedBox(height: 12),

        if (goals.isEmpty)
          _CardBox(
            child: Column(children: [
              const Text('🎯', style: TextStyle(fontSize: 36)),
              const SizedBox(height: 8),
              const Text('Aucun objectif pour l\'instant',
                  style: TextStyle(color: _kTxtMid, fontSize: 14)),
              const SizedBox(height: 4),
              const Text('Appuyez sur + pour en ajouter un',
                  style: TextStyle(color: _kTxtLt, fontSize: 12)),
            ]),
          )
        else
          for (int i = 0; i < goals.length; i++)
            _GoalCard(goal: goals[i], onIncrement: () => onIncrement(i)),

        // Milestones overview
        const SizedBox(height: 20),
        const Text('Paliers de régularité',
            style: TextStyle(
                color: _kTxtDk,
                fontWeight: FontWeight.w800,
                fontSize: 15)),
        const SizedBox(height: 10),
        for (final m in kStreakMilestones)
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: streak >= m.days
                  ? const Color(0xFFEEF7F2)
                  : _kCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: streak >= m.days ? _kMedium : _kBorder, width: 1),
            ),
            child: Row(children: [
              Text(m.emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(
                child: Text('${m.days} jours — ${m.title}',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: streak >= m.days ? _kPrimary : _kTxtMid)),
              ),
              if (streak >= m.days)
                const Icon(Icons.check_circle_rounded,
                    color: _kMedium, size: 20),
            ]),
          ),
      ],
    );
  }

  void _showGoalPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _GoalPickerSheet(
        onSelect: (tpl, days) {
          onAddGoal(tpl, days);
          Navigator.pop(ctx);
        },
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final _PersonalGoal goal;
  final VoidCallback onIncrement;

  const _GoalCard({required this.goal, required this.onIncrement});

  @override
  Widget build(BuildContext context) {
    final progress =
        goal.targetDays > 0 ? goal.currentDay / goal.targetDays : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: goal.completed ? const Color(0xFFEEF7F2) : _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: goal.completed ? _kMedium : _kBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(goal.emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(goal.title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kTxtDk)),
            ),
            if (!goal.completed)
              GestureDetector(
                onTap: onIncrement,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _kPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('+1 jour',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ),
              )
            else
              const Icon(Icons.emoji_events_rounded,
                  color: _kGold, size: 24),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: _kBorder,
                  valueColor: AlwaysStoppedAnimation(
                      goal.completed ? _kMedium : _kGold),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text('${goal.currentDay}/${goal.targetDays}j',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _kTxtMid)),
          ]),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// TAB 4 : GÉNÉROSITÉ (Zakat + Dons)
// ══════════════════════════════════════════════════════════════════

class _GenerositeTab extends StatelessWidget {
  final List<_ZakatRecord> zakatRecords;
  final List<_DonRecord> donRecords;
  final double totalDonsAnnee;
  final Function(_ZakatRecord) onAddZakat;
  final Function(int) onToggleZakatPaid;
  final Function(_DonRecord) onAddDon;

  const _GenerositeTab({
    required this.zakatRecords,
    required this.donRecords,
    required this.totalDonsAnnee,
    required this.onAddZakat,
    required this.onToggleZakatPaid,
    required this.onAddDon,
  });

  @override
  Widget build(BuildContext context) {
    final totalZakatDue =
        zakatRecords.where((r) => !r.paid).fold(0.0, (s, r) => s + r.zakatDue);
    final totalZakatPaid =
        zakatRecords.where((r) => r.paid).fold(0.0, (s, r) => s + r.zakatDue);

    // Hadith du jour
    final hadithIdx = DateTime.now().day % kGenerosityHadiths.length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        // Hadith de la générosité
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_kDeep, _kPrimary],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: _kPrimary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4)),
            ],
          ),
          child: Column(children: [
            const Text('🤲', style: TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text(kGenerosityHadiths[hadithIdx],
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    height: 1.5)),
          ]),
        ),
        const SizedBox(height: 16),

        // Total annuel
        _CardBox(
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kMedium.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('💚', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total donné cette année',
                      style: TextStyle(
                          color: _kTxtMid,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  Text('${(totalDonsAnnee + totalZakatPaid).toStringAsFixed(2)} €',
                      style: const TextStyle(
                          color: _kPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          ]),
        ),
        const SizedBox(height: 16),

        // ── SECTION ZAKAT ──
        const Text('Zakat',
            style: TextStyle(
                color: _kTxtDk,
                fontWeight: FontWeight.w800,
                fontSize: 16)),
        const SizedBox(height: 10),

        // Zakat summary
        Row(children: [
          Expanded(
            child: _MiniStatCard(
                label: 'Restant', value: totalZakatDue, color: _kGold),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _MiniStatCard(
                label: 'Versé', value: totalZakatPaid, color: _kMedium),
          ),
        ]),
        const SizedBox(height: 10),

        // Calculator button
        GestureDetector(
          onTap: () => _showZakatCalc(context),
          child: _CardBox(
            child: Row(children: [
              const Text('🧮', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Calculer ma Zakat',
                    style: TextStyle(
                        color: _kTxtDk,
                        fontWeight: FontWeight.w800,
                        fontSize: 14)),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: _kTxtLt, size: 24),
            ]),
          ),
        ),

        // Zakat types
        const SizedBox(height: 10),
        for (final z in kZakatTypes)
          _ZakatTypeCard(zakatType: z),

        // Beneficiaries
        _CardBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Les 8 catégories de bénéficiaires',
                  style: TextStyle(
                      color: _kTxtDk,
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
              const SizedBox(height: 4),
              const Text('Sourate At-Tawba, verset 60',
                  style: TextStyle(color: _kTxtLt, fontSize: 11)),
              const SizedBox(height: 12),
              for (int i = 0; i < kZakatBeneficiaries.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: _kPrimary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: _kPrimary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(kZakatBeneficiaries[i],
                            style: const TextStyle(
                                color: _kTxtMid,
                                fontSize: 13,
                                height: 1.3)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        // Zakat records
        if (zakatRecords.isNotEmpty) ...[
          const SizedBox(height: 10),
          for (int i = 0; i < zakatRecords.length; i++)
            _ZakatRecordCard(
              record: zakatRecords[i],
              onToggle: () => onToggleZakatPaid(i),
            ),
        ],

        const SizedBox(height: 24),

        // ── SECTION DONS / SADAQA ──
        Row(children: [
          const Text('Mes Dons & Sadaqa',
              style: TextStyle(
                  color: _kTxtDk,
                  fontWeight: FontWeight.w800,
                  fontSize: 16)),
          const Spacer(),
          GestureDetector(
            onTap: () => _showAddDon(context),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _kPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('+ Nouveau don',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
        const SizedBox(height: 12),

        // Causes suggestions
        const Text('Suggestions de causes',
            style: TextStyle(
                color: _kTxtMid,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: kDonCauses.length,
            itemBuilder: (context, index) {
              final cause = kDonCauses[index];
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _kBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cause.emoji, style: const TextStyle(fontSize: 22)),
                    const SizedBox(height: 6),
                    Text(cause.title,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _kTxtDk)),
                    Text(cause.description,
                        style:
                            const TextStyle(fontSize: 9, color: _kTxtLt),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),

        // Don records
        if (donRecords.isEmpty)
          _CardBox(
            child: Column(children: [
              const Text('💰', style: TextStyle(fontSize: 32)),
              const SizedBox(height: 8),
              const Text('Aucun don enregistré',
                  style: TextStyle(color: _kTxtMid, fontSize: 14)),
              const SizedBox(height: 4),
              const Text(
                  'Enregistrez vos dons pour suivre votre générosité',
                  style: TextStyle(color: _kTxtLt, fontSize: 12)),
            ]),
          )
        else
          for (final don in donRecords) _DonRecordCard(don: don),
      ],
    );
  }

  void _showZakatCalc(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _ZakatCalculatorSheet(
        onSave: (record) {
          onAddZakat(record);
          Navigator.pop(ctx);
        },
      ),
    );
  }

  void _showAddDon(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AddDonSheet(
        onSave: (record) {
          onAddDon(record);
          Navigator.pop(ctx);
        },
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _MiniStatCard(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(color: _kTxtLt, fontSize: 11)),
          Text('${value.toStringAsFixed(2)} €',
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _DonRecordCard extends StatelessWidget {
  final _DonRecord don;
  const _DonRecordCard({required this.don});

  static const _months = [
    '', 'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun',
    'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'
  ];

  String _causeName() {
    for (final c in kDonCauses) {
      if (c.id == don.causeId) return '${c.emoji} ${c.title}';
    }
    return don.causeId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder, width: 1.2),
      ),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_causeName(),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kTxtDk)),
              if (don.note != null && don.note!.isNotEmpty)
                Text(don.note!,
                    style:
                        const TextStyle(fontSize: 11, color: _kTxtLt)),
              Text(
                  '${don.date.day} ${_months[don.date.month]} ${don.date.year}',
                  style: const TextStyle(fontSize: 10, color: _kTxtLt)),
            ],
          ),
        ),
        Text('${don.amount.toStringAsFixed(2)} €',
            style: const TextStyle(
                color: _kMedium,
                fontSize: 16,
                fontWeight: FontWeight.w900)),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// TAB 5 : TABLEAU DE BORD (amélioré)
// ══════════════════════════════════════════════════════════════════

class _TableauTab extends StatelessWidget {
  final int score, scoreMax, streak, bestStreak, doneCount, totalActions;
  final List<_JournalEntry> entries;
  final List<_MoodEntry> moods;
  final List<_PersonalGoal> goals;
  final List<_DonRecord> donRecords;
  final List<_DayScore> dayScores;
  final double totalDonsAnnee;

  const _TableauTab({
    required this.score,
    required this.scoreMax,
    required this.entries,
    required this.moods,
    required this.streak,
    required this.bestStreak,
    required this.goals,
    required this.doneCount,
    required this.totalActions,
    required this.totalDonsAnnee,
    required this.donRecords,
    required this.dayScores,
  });

  @override
  Widget build(BuildContext context) {
    final progress = scoreMax > 0 ? score / scoreMax : 0.0;
    final percent = (progress * 100).round();
    final goalsCompleted = goals.where((g) => g.completed).length;

    // Message adaptatif
    final String motivMessage;
    if (percent >= 70) {
      final idx = DateTime.now().hour % kHighScoreMessages.length;
      motivMessage = kHighScoreMessages[idx];
    } else if (percent >= 20) {
      final idx = DateTime.now().hour % kLowScoreMessages.length;
      motivMessage = kLowScoreMessages[idx];
    } else {
      final idx = DateTime.now().hour % kWelcomeBackMessages.length;
      motivMessage = kWelcomeBackMessages[idx];
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Score card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kDeep, _kPrimary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                    color: _kPrimary.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8)),
              ],
            ),
            child: Column(children: [
              Text('⭐ Score Spirituel',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 14)),
              const SizedBox(height: 12),
              Text('$score',
                  style: const TextStyle(
                      color: _kGold,
                      fontSize: 56,
                      fontWeight: FontWeight.w900)),
              Text('sur $scoreMax points',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6), fontSize: 13)),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation(_kGold),
                ),
              ),
              const SizedBox(height: 8),
              Text('$percent% accompli aujourd\'hui',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.85), fontSize: 13)),
            ]),
          ),
          const SizedBox(height: 16),

          // Mini calendar
          _MonthCalendar(dayScores: dayScores, todayScore: score, todayMax: scoreMax),
          const SizedBox(height: 14),

          // Stats grid
          Row(children: [
            Expanded(
              child: _StatBox(
                  icon: '🔥', label: 'Streak actuel',
                  value: '$streak j', color: const Color(0xFFE8713A)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatBox(
                  icon: '🏆', label: 'Meilleur streak',
                  value: '$bestStreak j', color: _kGold),
            ),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: _StatBox(
                  icon: '📝', label: 'Entrées journal',
                  value: '${entries.length}', color: _kPrimary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatBox(
                  icon: '✅', label: 'Actions du jour',
                  value: '$doneCount/$totalActions', color: _kMedium),
            ),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: _StatBox(
                  icon: '🎯', label: 'Objectifs',
                  value: '$goalsCompleted/${goals.length}',
                  color: const Color(0xFF6A3FAA)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatBox(
                  icon: '💚', label: 'Dons cette année',
                  value: '${totalDonsAnnee.toStringAsFixed(0)} €',
                  color: _kMedium),
            ),
          ]),
          const SizedBox(height: 16),

          // Mood history
          if (moods.isNotEmpty) ...[
            _CardBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Humeurs récentes',
                      style: TextStyle(
                          color: _kTxtDk,
                          fontWeight: FontWeight.w800,
                          fontSize: 14)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: moods.reversed.take(14).map((m) {
                      final mood = kMoodOptions.firstWhere(
                          (mo) => mo.id == m.moodId,
                          orElse: () => kMoodOptions.first);
                      return Tooltip(
                        message:
                            '${m.date.day}/${m.date.month} — ${mood.label}',
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: _kBeige,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _kBorder),
                          ),
                          child: Center(
                            child: Text(mood.emoji,
                                style: const TextStyle(fontSize: 18)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Motivation message (bienveillant)
          _CardBox(
            child: Column(children: [
              const Text('💬', style: TextStyle(fontSize: 32)),
              const SizedBox(height: 8),
              Text(motivMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: _kTxtMid, fontSize: 14, height: 1.5)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _MonthCalendar extends StatelessWidget {
  final List<_DayScore> dayScores;
  final int todayScore, todayMax;

  const _MonthCalendar({
    required this.dayScores,
    required this.todayScore,
    required this.todayMax,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstOfMonth = DateTime(now.year, now.month, 1);
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final startWeekday = firstOfMonth.weekday; // 1=Mon
    final months = [
      '', 'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];

    return _CardBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${months[now.month]} ${now.year}',
              style: const TextStyle(
                  color: _kTxtDk,
                  fontWeight: FontWeight.w800,
                  fontSize: 14)),
          const SizedBox(height: 10),
          // Weekday headers
          Row(
            children: ['L', 'M', 'M', 'J', 'V', 'S', 'D']
                .map((d) => Expanded(
                      child: Center(
                        child: Text(d,
                            style: const TextStyle(
                                color: _kTxtLt,
                                fontSize: 10,
                                fontWeight: FontWeight.w700)),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 6),
          // Days grid
          ...List.generate(6, (week) {
            return Row(
              children: List.generate(7, (weekday) {
                final dayNum =
                    week * 7 + weekday + 1 - (startWeekday - 1);
                if (dayNum < 1 || dayNum > daysInMonth) {
                  return const Expanded(child: SizedBox(height: 32));
                }
                final isToday = dayNum == now.day;
                final isInFuture = dayNum > now.day;

                // Find score for this day
                Color cellColor;
                if (isInFuture) {
                  cellColor = Colors.transparent;
                } else if (isToday) {
                  final pct = todayMax > 0 ? todayScore / todayMax : 0.0;
                  cellColor = pct > 0.7
                      ? _kMedium.withOpacity(0.3)
                      : pct > 0.3
                          ? _kGold.withOpacity(0.3)
                          : pct > 0
                              ? _kGold.withOpacity(0.15)
                              : Colors.transparent;
                } else {
                  // Check dayScores
                  final ds = dayScores.where((d) =>
                      d.date.day == dayNum &&
                      d.date.month == now.month &&
                      d.date.year == now.year);
                  if (ds.isNotEmpty) {
                    final pct = ds.first.scoreMax > 0
                        ? ds.first.score / ds.first.scoreMax
                        : 0.0;
                    cellColor = pct > 0.7
                        ? _kMedium.withOpacity(0.3)
                        : pct > 0.3
                            ? _kGold.withOpacity(0.3)
                            : _kGold.withOpacity(0.15);
                  } else {
                    cellColor = const Color(0xFFE8E0D4);
                  }
                }

                return Expanded(
                  child: Container(
                    height: 32,
                    margin: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      color: cellColor,
                      borderRadius: BorderRadius.circular(6),
                      border: isToday
                          ? Border.all(color: _kPrimary, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Text('$dayNum',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: isToday
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                              color: isInFuture
                                  ? _kTxtLt.withOpacity(0.4)
                                  : isToday
                                      ? _kPrimary
                                      : _kTxtMid)),
                    ),
                  ),
                );
              }),
            );
          }),
          const SizedBox(height: 8),
          // Legend
          Row(children: [
            _CalLegend(color: _kMedium.withOpacity(0.3), label: '>70%'),
            const SizedBox(width: 10),
            _CalLegend(color: _kGold.withOpacity(0.3), label: '30-70%'),
            const SizedBox(width: 10),
            _CalLegend(color: const Color(0xFFE8E0D4), label: '0%'),
          ]),
        ],
      ),
    );
  }
}

class _CalLegend extends StatelessWidget {
  final Color color;
  final String label;
  const _CalLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(color: _kTxtLt, fontSize: 10)),
    ]);
  }
}

class _StatBox extends StatelessWidget {
  final String icon, label, value;
  final Color color;
  const _StatBox(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: const [
          BoxShadow(
              color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900, color: color)),
          Text(label,
              style: const TextStyle(fontSize: 10, color: _kTxtLt)),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SHARED WIDGETS
// ══════════════════════════════════════════════════════════════════

class _CardBox extends StatelessWidget {
  final Widget child;
  const _CardBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder, width: 1.2),
        boxShadow: const [
          BoxShadow(
              color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(children: [
        Text('$label : ',
            style: const TextStyle(
                color: _kTxtLt, fontSize: 12, fontWeight: FontWeight.w600)),
        Text(value,
            style: const TextStyle(
                color: _kPrimary, fontSize: 12, fontWeight: FontWeight.w800)),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// BOTTOM SHEETS
// ══════════════════════════════════════════════════════════════════

// -- Add journal entry sheet (enhanced) --

class _AddEntrySheet extends StatefulWidget {
  final ReflectionPrompt? prompt;
  final String? forceType;
  final Function(String texte, String type) onSave;

  const _AddEntrySheet({this.prompt, this.forceType, required this.onSave});

  @override
  State<_AddEntrySheet> createState() => _AddEntrySheetState();
}

class _AddEntrySheetState extends State<_AddEntrySheet> {
  final TextEditingController _ctrl = TextEditingController();
  late String _type;

  @override
  void initState() {
    super.initState();
    _type = widget.forceType ??
        (widget.prompt != null ? 'reflexion' : 'gratitude');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String get _sheetTitle {
    if (widget.prompt != null) return 'Réflexion du jour';
    switch (_type) {
      case 'note': return 'Note privée';
      case 'lettre': return 'Lettre à moi-même';
      default: return 'Nouvelle entrée';
    }
  }

  String get _hintText {
    switch (_type) {
      case 'note':
        return 'Écris ce qui te passe par l\'esprit, en toute liberté...';
      case 'lettre':
        return 'Cher moi du futur, ...\n\n(Tu recevras un rappel pour relire cette lettre dans 30 jours)';
      case 'reflexion':
        return 'Votre réflexion...';
      default:
        return 'Écrivez votre réflexion spirituelle...';
    }
  }

  @override
  Widget build(BuildContext context) {
    final showTypeSelector =
        widget.prompt == null && widget.forceType == null;

    return Container(
      decoration: const BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: _kBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(_sheetTitle,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: _kTxtDk)),

          if (widget.prompt != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kGoldLt,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(children: [
                Text(widget.prompt!.emoji,
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(widget.prompt!.question,
                      style: const TextStyle(
                          color: _kTxtDk,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                ),
              ]),
            ),
          ],

          if (_type == 'lettre') ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8E8F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(children: [
                Text('✉️', style: TextStyle(fontSize: 16)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                      'Cette lettre sera scellée. Tu recevras un rappel pour la relire dans 30 jours.',
                      style: TextStyle(
                          color: Color(0xFF8A3F6A),
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
              ]),
            ),
          ],
          const SizedBox(height: 14),

          if (showTypeSelector)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                _ChipBtn(label: '💚 Gratitude', selected: _type == 'gratitude',
                    onTap: () => setState(() => _type = 'gratitude')),
                const SizedBox(width: 6),
                _ChipBtn(label: '✅ Action', selected: _type == 'action',
                    onTap: () => setState(() => _type = 'action')),
                const SizedBox(width: 6),
                _ChipBtn(label: '🤲 Du\'a', selected: _type == 'dua',
                    onTap: () => setState(() => _type = 'dua')),
                const SizedBox(width: 6),
                _ChipBtn(label: '📝 Note', selected: _type == 'note',
                    onTap: () => setState(() => _type = 'note')),
                const SizedBox(width: 6),
                _ChipBtn(label: '✉️ Lettre', selected: _type == 'lettre',
                    onTap: () => setState(() => _type = 'lettre')),
              ]),
            ),
          if (showTypeSelector) const SizedBox(height: 14),

          TextField(
            controller: _ctrl,
            maxLines: _type == 'lettre' ? 6 : 4,
            style: const TextStyle(color: _kTxtDk),
            decoration: InputDecoration(
              hintText: _hintText,
              hintStyle: const TextStyle(color: _kTxtLt),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: _kBorder)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: _kBorder)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      const BorderSide(color: _kPrimary, width: 2)),
              filled: true,
              fillColor: _kBeige,
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
              onPressed: () {
                if (_ctrl.text.trim().isNotEmpty) {
                  widget.onSave(_ctrl.text.trim(), _type);
                }
              },
              child: Text(
                  _type == 'lettre' ? 'Sceller ma lettre' : 'Sauvegarder',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// -- Goal picker sheet --

class _GoalPickerSheet extends StatefulWidget {
  final Function(GoalTemplate, int) onSelect;
  const _GoalPickerSheet({required this.onSelect});

  @override
  State<_GoalPickerSheet> createState() => _GoalPickerSheetState();
}

class _GoalPickerSheetState extends State<_GoalPickerSheet> {
  String _filterCat = 'all';

  List<GoalTemplate> get _filtered => _filterCat == 'all'
      ? kGoalTemplates
      : kGoalTemplates.where((g) => g.category == _filterCat).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7),
      decoration: const BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: _kBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Text('Choisir un objectif',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: _kTxtDk)),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              _ChipBtn(label: 'Tous', selected: _filterCat == 'all',
                  onTap: () => setState(() => _filterCat = 'all')),
              const SizedBox(width: 6),
              _ChipBtn(label: '📖 Coran', selected: _filterCat == 'coran',
                  onTap: () => setState(() => _filterCat = 'coran')),
              const SizedBox(width: 6),
              _ChipBtn(label: '🕌 Prière', selected: _filterCat == 'priere',
                  onTap: () => setState(() => _filterCat = 'priere')),
              const SizedBox(width: 6),
              _ChipBtn(label: '🤝 Comportement',
                  selected: _filterCat == 'comportement',
                  onTap: () => setState(() => _filterCat = 'comportement')),
              const SizedBox(width: 6),
              _ChipBtn(label: '📚 Science', selected: _filterCat == 'science',
                  onTap: () => setState(() => _filterCat = 'science')),
            ]),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final tpl = _filtered[index];
                return GestureDetector(
                  onTap: () => widget.onSelect(tpl, 30),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _kBeige,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _kBorder),
                    ),
                    child: Row(children: [
                      Text(tpl.emoji,
                          style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(tpl.title,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _kTxtDk)),
                      ),
                      const Icon(Icons.add_circle_outline_rounded,
                          color: _kPrimary, size: 22),
                    ]),
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

// -- Zakat calculator sheet --

class _ZakatCalculatorSheet extends StatefulWidget {
  final Function(_ZakatRecord) onSave;
  const _ZakatCalculatorSheet({required this.onSave});

  @override
  State<_ZakatCalculatorSheet> createState() => _ZakatCalculatorSheetState();
}

class _ZakatCalculatorSheetState extends State<_ZakatCalculatorSheet> {
  final TextEditingController _amountCtrl = TextEditingController();
  String _selectedType = 'mal';
  double _zakatDue = 0;
  final double _goldPrice = 75.0;

  void _calculate() {
    final amount = double.tryParse(_amountCtrl.text) ?? 0;
    final type = kZakatTypes.firstWhere((z) => z.id == _selectedType);
    final nisabValue = type.nisabOr * _goldPrice;

    setState(() {
      if (amount >= nisabValue && type.tauxPercent > 0) {
        _zakatDue = amount * type.tauxPercent / 100;
      } else {
        _zakatDue = 0;
      }
    });
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedZakat =
        kZakatTypes.firstWhere((z) => z.id == _selectedType);
    final nisabValue = selectedZakat.nisabOr * _goldPrice;

    return Container(
      decoration: const BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20, right: 20, top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: _kBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Text('Calculateur de Zakat',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: _kTxtDk)),
            const SizedBox(height: 14),

            const Text('Type de Zakat',
                style: TextStyle(
                    color: _kTxtMid,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: kZakatTypes
                  .where((z) => z.tauxPercent > 0)
                  .map((z) => _ChipBtn(
                        label: '${z.emoji} ${z.title.replaceAll('Zakât ', '')}',
                        selected: _selectedType == z.id,
                        onTap: () =>
                            setState(() => _selectedType = z.id),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kGoldLt,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(children: [
                const Text('ℹ️ ', style: TextStyle(fontSize: 16)),
                Expanded(
                  child: Text(
                      'Nisâb estimé : ${nisabValue.toStringAsFixed(0)} € (${selectedZakat.nisabOr.toStringAsFixed(0)}g × ${_goldPrice.toStringAsFixed(0)} €/g)',
                      style: const TextStyle(
                          color: _kTxtMid, fontSize: 11)),
                ),
              ]),
            ),
            const SizedBox(height: 14),

            const Text('Montant total de vos biens (€)',
                style: TextStyle(
                    color: _kTxtMid,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            TextField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  color: _kTxtDk, fontSize: 18, fontWeight: FontWeight.w800),
              onChanged: (_) => _calculate(),
              decoration: InputDecoration(
                hintText: '0',
                suffixText: '€',
                hintStyle: const TextStyle(color: _kTxtLt),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: _kBorder)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: _kBorder)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: _kPrimary, width: 2)),
                filled: true,
                fillColor: _kBeige,
              ),
            ),
            const SizedBox(height: 16),

            if (_zakatDue > 0)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_kDeep, _kPrimary],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(children: [
                  const Text('Zakat à verser',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 6),
                  Text('${_zakatDue.toStringAsFixed(2)} €',
                      style: const TextStyle(
                          color: _kGold,
                          fontSize: 32,
                          fontWeight: FontWeight.w900)),
                  Text(
                      '${selectedZakat.tauxPercent}% de ${_amountCtrl.text} €',
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 11)),
                ]),
              ),
            if (_zakatDue == 0 && _amountCtrl.text.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kBeige,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                    'Le montant est en dessous du Nisâb. Pas de Zakat obligatoire.',
                    style: TextStyle(color: _kTxtMid, fontSize: 12),
                    textAlign: TextAlign.center),
              ),
            const SizedBox(height: 14),

            if (_zakatDue > 0)
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
                  onPressed: () {
                    final amount =
                        double.tryParse(_amountCtrl.text) ?? 0;
                    widget.onSave(_ZakatRecord(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      type: _selectedType,
                      amount: amount,
                      zakatDue: _zakatDue,
                      date: DateTime.now(),
                    ));
                  },
                  child: const Text('Enregistrer ce calcul',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800)),
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// -- Zakat type expandable card --

class _ZakatTypeCard extends StatefulWidget {
  final ZakatType zakatType;
  const _ZakatTypeCard({required this.zakatType});

  @override
  State<_ZakatTypeCard> createState() => _ZakatTypeCardState();
}

class _ZakatTypeCardState extends State<_ZakatTypeCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final z = widget.zakatType;
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kBorder, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(z.emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(z.title,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _kTxtDk)),
                    Text(z.description,
                        style:
                            const TextStyle(fontSize: 11, color: _kTxtLt)),
                  ],
                ),
              ),
              Icon(
                  _expanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  color: _kTxtLt),
            ]),
            if (_expanded) ...[
              const Divider(height: 20),
              if (z.tauxPercent > 0) ...[
                _InfoRow(label: 'Taux', value: '${z.tauxPercent}%'),
                _InfoRow(
                    label: 'Nisâb',
                    value: '${z.nisabOr.toStringAsFixed(0)}g d\'or'),
                const SizedBox(height: 8),
              ],
              for (final d in z.details)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ',
                          style: TextStyle(
                              color: _kPrimary, fontWeight: FontWeight.w800)),
                      Expanded(
                        child: Text(d,
                            style: const TextStyle(
                                color: _kTxtMid,
                                fontSize: 12,
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

// -- Zakat record card --

class _ZakatRecordCard extends StatelessWidget {
  final _ZakatRecord record;
  final VoidCallback onToggle;

  const _ZakatRecordCard({required this.record, required this.onToggle});

  static const _months = [
    '', 'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun',
    'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'
  ];

  String _typeName() {
    for (final z in kZakatTypes) {
      if (z.id == record.type) return z.title;
    }
    return record.type;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: record.paid ? const Color(0xFFEEF7F2) : _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: record.paid ? _kMedium : _kBorder, width: 1.2),
      ),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_typeName(),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kTxtDk)),
              Text(
                  'Base : ${record.amount.toStringAsFixed(0)} € → ${record.zakatDue.toStringAsFixed(2)} €',
                  style: const TextStyle(fontSize: 11, color: _kTxtLt)),
              Text(
                  '${record.date.day} ${_months[record.date.month]} ${record.date.year}',
                  style: const TextStyle(fontSize: 10, color: _kTxtLt)),
            ],
          ),
        ),
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: record.paid ? _kMedium : _kGold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              record.paid ? '✓ Versé' : 'Marquer versé',
              style: TextStyle(
                  color: record.paid ? Colors.white : _kGold,
                  fontSize: 11,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ]),
    );
  }
}

// -- Add don sheet --

class _AddDonSheet extends StatefulWidget {
  final Function(_DonRecord) onSave;
  const _AddDonSheet({required this.onSave});

  @override
  State<_AddDonSheet> createState() => _AddDonSheetState();
}

class _AddDonSheetState extends State<_AddDonSheet> {
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  String _selectedCause = 'orphelins';

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cause = kDonCauses.firstWhere((c) => c.id == _selectedCause);

    return Container(
      decoration: const BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20, right: 20, top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: _kBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Text('Enregistrer un don',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: _kTxtDk)),
            const SizedBox(height: 14),

            const Text('Cause',
                style: TextStyle(
                    color: _kTxtMid,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: kDonCauses
                  .map((c) => _ChipBtn(
                        label: '${c.emoji} ${c.title}',
                        selected: _selectedCause == c.id,
                        onTap: () =>
                            setState(() => _selectedCause = c.id),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),

            // Hadith for selected cause
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kGoldLt,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(cause.hadith,
                  style: const TextStyle(
                      color: _kTxtMid,
                      fontSize: 11,
                      fontStyle: FontStyle.italic)),
            ),
            const SizedBox(height: 14),

            const Text('Montant (€)',
                style: TextStyle(
                    color: _kTxtMid,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            TextField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  color: _kTxtDk, fontSize: 18, fontWeight: FontWeight.w800),
              decoration: InputDecoration(
                hintText: '0',
                suffixText: '€',
                hintStyle: const TextStyle(color: _kTxtLt),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: _kBorder)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: _kBorder)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: _kPrimary, width: 2)),
                filled: true,
                fillColor: _kBeige,
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _noteCtrl,
              style: const TextStyle(color: _kTxtDk, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Note (optionnel)',
                hintStyle: const TextStyle(color: _kTxtLt),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: _kBorder)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: _kBorder)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: _kPrimary, width: 2)),
                filled: true,
                fillColor: _kBeige,
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
                onPressed: () {
                  final amount =
                      double.tryParse(_amountCtrl.text) ?? 0;
                  if (amount > 0) {
                    widget.onSave(_DonRecord(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      causeId: _selectedCause,
                      amount: amount,
                      date: DateTime.now(),
                      note: _noteCtrl.text.trim().isEmpty
                          ? null
                          : _noteCtrl.text.trim(),
                    ));
                  }
                },
                child: const Text('Enregistrer mon don',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// -- Shared chip button --

class _ChipBtn extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ChipBtn(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? _kPrimary : _kBeige,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? _kPrimary : _kBorder, width: 1.5),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                color: selected ? Colors.white : _kTxtMid,
                fontWeight:
                    selected ? FontWeight.w800 : FontWeight.w500)),
      ),
    );
  }
}
