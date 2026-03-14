import 'package:flutter/material.dart';
import 'learning_models.dart';
import 'lesson_screen.dart';
import 'lesson_generator.dart';
import 'learning_service.dart';
import 'quiz_screen.dart';

// ─── Palette UpYourDeen ─────────────────────────────────────────────────
const _kGreenDeep    = Color(0xFF0A2018);
const _kGreenPrimary = Color(0xFF1B4D38);
const _kGreenMedium  = Color(0xFF2A7A52);
const _kGold         = Color(0xFFC8933A);
const _kGoldLight    = Color(0xFFE8BF6A);
const _kBeige        = Color(0xFFF6F0E3);
const _kBeigeCard    = Color(0xFFFFFFFF);
const _kBeigeBorder  = Color(0xFFD6C9AF);
const _kTextDark     = Color(0xFF1A130A);
const _kTextMid      = Color(0xFF5A4833);
const _kTextLight    = Color(0xFF8A7863);

// ─── Path Config ─────────────────────────────────────────────────
class _PathConfig {
  final String title, subtitle, emoji;
  final Color  primary, light;
  final List<Color> gradient;
  const _PathConfig({
    required this.title, required this.subtitle, required this.emoji,
    required this.primary, required this.light, required this.gradient,
  });
}

const _configs = <LearningPathType, _PathConfig>{
  LearningPathType.debutant: _PathConfig(
    title: 'Parcours Débutant', subtitle: 'Courtes sourates du Juz 30', emoji: '🌱',
    primary: _kGreenPrimary, light: Color(0xFFE8F4EE),
    gradient: [Color(0xFF2A7A52), Color(0xFF0A2018)]),

  LearningPathType.priere: _PathConfig(
    title: 'Parcours Prière', subtitle: 'Sourates essentielles de la prière', emoji: '🕌',
    primary: Color(0xFF1A5C8A), light: Color(0xFFE3EDF7),
    gradient: [Color(0xFF1E88E5), Color(0xFF0D47A1)]),

  LearningPathType.protection: _PathConfig(
    title: 'Parcours Protection', subtitle: 'Sourates de protection et de refuge', emoji: '🛡️',
    primary: Color(0xFFA85C00), light: Color(0xFFFAEBD7),
    gradient: [Color(0xFFFF9800), Color(0xFFE65100)]),

  LearningPathType.importantes: _PathConfig(
    title: 'Grandes Sourates', subtitle: 'Les sourates les plus importantes', emoji: '⭐',
    primary: _kGold, light: Color(0xFFFFF4DC),
    gradient: [Color(0xFFE8BF6A), Color(0xFFC8933A)]),

  LearningPathType.juzAmma: _PathConfig(
    title: 'Juz Amma', subtitle: 'Le 30e juz complet · 37 sourates', emoji: '📖',
    primary: Color(0xFF6A3FAA), light: Color(0xFFF3ECFA),
    gradient: [Color(0xFF8549BA), Color(0xFF4A148C)]),

  LearningPathType.libre: _PathConfig(
    title: 'Mode Libre', subtitle: 'Toutes les sourates du Coran', emoji: '🔓',
    primary: _kTextMid, light: Color(0xFFEDE7D9),
    gradient: [Color(0xFF5A4833), Color(0xFF2C1A0E)]),
};

// ─── Groupe de données par sourate ───────────────────────────────
class _SourateGroup {
  final int    surahNumber;
  final String name, nameFr, signification, icon;
  final int    total, completed;
  final bool   isStarted;
  final List<LearningLesson> lessons;

  _SourateGroup({
    required this.surahNumber,
    required this.name,
    required this.nameFr,
    required this.signification,
    required this.icon,
    required this.total,
    required this.completed,
    required this.isStarted,
    required this.lessons,
  });

  bool get isMastered => completed == total && total > 0;
}

// ─── Items pour la vue détail d'une sourate ───────────────────────
sealed class _ListItem {}

class _LessonItem extends _ListItem {
  final LearningLesson lesson;
  final int            globalIndex;
  _LessonItem({required this.lesson, required this.globalIndex});
}

class _QuizItem extends _ListItem {
  final int                  surahNumber;
  final String               surahName, surahNameFr;
  final int                  quizIndex;
  final List<LearningLesson> lessons;
  final bool                 allComplete;
  final bool                 done;
  _QuizItem({
    required this.surahNumber, required this.surahName, required this.surahNameFr,
    required this.quizIndex,   required this.lessons,
    required this.allComplete, required this.done,
  });
}

class _FinalQuizItem extends _ListItem {
  final int                  surahNumber;
  final String               surahName, surahNameFr;
  final List<LearningLesson> lessons;
  final bool                 allComplete;
  final bool                 done;
  _FinalQuizItem({
    required this.surahNumber, required this.surahName, required this.surahNameFr,
    required this.lessons,     required this.allComplete, required this.done,
  });
}

// ══════════════════════════════════════════════════════════════════
// SCREEN PRINCIPAL — liste des sourates
// ══════════════════════════════════════════════════════════════════
class LearningPathScreen extends StatefulWidget {
  final LearningPathType pathType;
  final UserStats        stats;
  const LearningPathScreen({Key? key, this.pathType = LearningPathType.debutant, required this.stats}) : super(key: key);

  @override
  State<LearningPathScreen> createState() => _LearningPathScreenState();
}

class _LearningPathScreenState extends State<LearningPathScreen> {
  bool                   _loading  = true;
  List<LearningLesson>   _lessons  = [];
  List<_SourateGroup>    _groups   = [];
  UserStats              _stats    = UserStats();
  Set<String>            _completedQuizzes = {};

  @override
  void initState() {
    super.initState();
    _stats = widget.stats;
    _load();
  }

  Future<void> _load() async {
    final lessons  = LessonGenerator.buildPath(widget.pathType);
    await LearningService.instance.applyMasteryToLessons(lessons);
    final quizDone = await LearningService.instance.loadCompletedQuizzes();
    if (mounted) {
      setState(() {
        _lessons          = lessons;
        _completedQuizzes = quizDone;
        _groups           = _buildGroups(lessons);
        _loading          = false;
      });
    }
  }

  List<_SourateGroup> _buildGroups(List<LearningLesson> lessons) {
    final groups  = <_SourateGroup>[];
    final grouped = <int, List<LearningLesson>>{};
    for (final l in lessons) {
      grouped.putIfAbsent(l.surahNumber, () => []).add(l);
    }
    for (final surahNum in grouped.keys) {
      final group = grouped[surahNum]!;
      final l0    = group.first;
      final done  = group.where((x) => x.isCompleted).length;
      groups.add(_SourateGroup(
        surahNumber:   surahNum,
        name:          l0.surahName,
        nameFr:        l0.surahNameFr,
        signification: l0.signification,
        icon:          l0.icon,
        total:         group.length,
        completed:     done,
        isStarted:     group.any((x) => x.isUnlocked || x.isCompleted),
        lessons:       group,
      ));
    }
    return groups;
  }

  Future<void> _onLessonComplete(LearningLesson l) async {
    if (l.isCompleted) return;
    setState(() {
      l.isCompleted = true;
      _stats.addXP(l.xpReward);
      _stats.updateStreak();
      final idx = _lessons.indexOf(l);
      if (idx >= 0 && idx + 1 < _lessons.length) {
        _lessons[idx + 1].isUnlocked = true;
      }
      _groups = _buildGroups(_lessons);
    });
    await LearningService.instance.saveStats(_stats);
  }

  Future<void> _onQuizComplete(String quizKey, int xpBonus) async {
    _completedQuizzes.add(quizKey);
    _stats.addXP(xpBonus);
    setState(() { _groups = _buildGroups(_lessons); });
    await LearningService.instance.saveQuizCompleted(quizKey);
    await LearningService.instance.saveStats(_stats);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: _kGreenDeep,
        body: Center(child: CircularProgressIndicator(color: _kGold)),
      );
    }

    final cfg            = _configs[widget.pathType]!;
    final completedCount = _lessons.where((l) => l.isCompleted).length;
    final progress       = _lessons.isEmpty ? 0.0 : completedCount / _lessons.length;

    return Scaffold(
      backgroundColor: _kBeige,
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: _buildHeader(context, cfg, completedCount, progress)),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => _SourateCard(
                group:  _groups[i],
                config: cfg,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _SourateDetailScreen(
                        group:            _groups[i],
                        config:           cfg,
                        stats:            _stats,
                        completedQuizzes: Set.from(_completedQuizzes),
                        onLessonComplete: _onLessonComplete,
                        onQuizComplete:   _onQuizComplete,
                      ),
                    ),
                  );
                  // Rafraîchir les cartes au retour
                  if (mounted) setState(() { _groups = _buildGroups(_lessons); });
                },
              ),
              childCount: _groups.length,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildHeader(BuildContext ctx, _PathConfig cfg, int done, double progress) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: cfg.gradient,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                GestureDetector(
                  onTap: () => Navigator.pop(ctx),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(cfg.title,
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                ),
              ]),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 42),
                child: Text(cfg.subtitle,
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13)),
              ),
              const SizedBox(height: 20),

              Row(children: [
                _chip('🔥', '${_stats.streak}',    'streak',          const Color(0xFFFF8C42)),
                const SizedBox(width: 8),
                _chip('⚡', '${_stats.xp}',        'XP',              _kGoldLight),
                const SizedBox(width: 8),
                _chip('🏆', 'Nv.${_stats.level}',  _stats.levelTitle, _kGoldLight),
              ]),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$done/${_lessons.length} versets appris',
                          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                      Text('${(progress * 100).round()}%',
                          style: const TextStyle(color: _kGoldLight, fontSize: 13, fontWeight: FontWeight.w800)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value:           progress,
                      minHeight:       10,
                      backgroundColor: Colors.white.withOpacity(0.25),
                      valueColor:      const AlwaysStoppedAnimation(_kGold),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String icon, String val, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
        ),
        child: Column(children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 2),
          Text(val,   style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w900)),
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10)),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// CARTE SOURATE — niveau 1 (cliquable)
// ══════════════════════════════════════════════════════════════════
class _SourateCard extends StatelessWidget {
  final _SourateGroup group;
  final _PathConfig   config;
  final VoidCallback  onTap;
  const _SourateCard({required this.group, required this.config, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final pct      = group.total == 0 ? 0.0 : group.completed / group.total;
    final mastered = group.isMastered;
    final started  = group.isStarted && !mastered;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: mastered ? config.primary.withOpacity(0.5)
                 : started  ? config.primary.withOpacity(0.25)
                 : _kBeigeBorder,
            width: mastered ? 1.8 : 1.2,
          ),
          boxShadow: [
            if (mastered) BoxShadow(color: config.primary.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 4)),
            const BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Ligne 1 : icône + noms + badge statut ──
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: mastered ? config.primary
                           : started  ? config.light
                           : const Color(0xFFF3EFE8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: mastered ? config.primary
                             : started  ? config.primary.withOpacity(0.3)
                             : _kBeigeBorder,
                        width: 1.2,
                      ),
                    ),
                    child: Center(
                      child: mastered
                        ? const Icon(Icons.check_rounded, color: Colors.white, size: 22)
                        : Text(group.icon, style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            group.nameFr,
                            style: const TextStyle(
                              color: _kTextDark, fontSize: 15,
                              fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            group.name,
                            style: const TextStyle(color: _kTextLight, fontSize: 13),
                          ),
                        ]),
                        const SizedBox(height: 3),
                        Text(
                          group.signification,
                          style: const TextStyle(color: _kTextLight, fontSize: 11),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _statusBadge(mastered, started),
                ],
              ),

              const SizedBox(height: 14),

              // ── Ligne 2 : barre de progression ──
              Row(children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value:           pct,
                      minHeight:       6,
                      backgroundColor: _kBeigeBorder.withOpacity(0.5),
                      valueColor:      AlwaysStoppedAnimation(
                        mastered ? config.primary : config.primary.withOpacity(0.65)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${group.completed}/${group.total} versets',
                  style: TextStyle(
                    color: mastered ? config.primary : _kTextLight,
                    fontSize: 11, fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.chevron_right_rounded,
                  color: mastered ? config.primary : _kTextLight,
                  size: 20,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(bool mastered, bool started) {
    final color = mastered ? config.primary
                : started  ? config.primary
                : _kTextLight;
    final bg    = mastered ? config.light
                : started  ? config.light
                : const Color(0xFFF0EBE3);
    final label = mastered ? '✓ Maîtrisée'
                : started  ? 'En cours'
                : 'Commencer';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800)),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SCREEN DÉTAIL — versets d'une sourate (niveau 2)
// ══════════════════════════════════════════════════════════════════
class _SourateDetailScreen extends StatefulWidget {
  final _SourateGroup                            group;
  final _PathConfig                              config;
  final UserStats                                stats;
  final Set<String>                              completedQuizzes;
  final Future<void> Function(LearningLesson)    onLessonComplete;
  final Future<void> Function(String, int)       onQuizComplete;

  const _SourateDetailScreen({
    required this.group,
    required this.config,
    required this.stats,
    required this.completedQuizzes,
    required this.onLessonComplete,
    required this.onQuizComplete,
  });

  @override
  State<_SourateDetailScreen> createState() => _SourateDetailScreenState();
}

class _SourateDetailScreenState extends State<_SourateDetailScreen> {
  late List<_ListItem> _items;
  late Set<String>     _completedQuizzes;

  @override
  void initState() {
    super.initState();
    _completedQuizzes = Set.from(widget.completedQuizzes);
    _rebuildItems();
  }

  void _rebuildItems() {
    final items   = <_ListItem>[];
    final lessons = widget.group.lessons;
    int quizIdx   = 0;

    for (int j = 0; j < lessons.length; j++) {
      items.add(_LessonItem(lesson: lessons[j], globalIndex: j));

      final posInSurah = j + 1;
      if (posInSurah % 5 == 0) {
        quizIdx++;
        final quizLessons = lessons.sublist(0, posInSurah);
        final allComplete = quizLessons.every((l) => l.isCompleted);
        final key         = LearningService.intermediateQuizKey(widget.group.surahNumber, quizIdx);
        final done        = _completedQuizzes.contains(key);
        items.add(_QuizItem(
          surahNumber:  widget.group.surahNumber,
          surahName:    widget.group.name,
          surahNameFr:  widget.group.nameFr,
          quizIndex:    quizIdx,
          lessons:      quizLessons,
          allComplete:  allComplete,
          done:         done,
        ));
      }
    }

    final finalKey = LearningService.finalQuizKey(widget.group.surahNumber);
    final allDone  = lessons.every((l) => l.isCompleted);
    items.add(_FinalQuizItem(
      surahNumber:  widget.group.surahNumber,
      surahName:    widget.group.name,
      surahNameFr:  widget.group.nameFr,
      lessons:      lessons,
      allComplete:  allDone,
      done:         _completedQuizzes.contains(finalKey),
    ));

    _items = items;
  }

  Future<void> _handleLessonComplete(LearningLesson l) async {
    await widget.onLessonComplete(l);
    if (mounted) setState(() => _rebuildItems());
  }

  Future<void> _handleQuizComplete(String key, int xp) async {
    _completedQuizzes.add(key);
    await widget.onQuizComplete(key, xp);
    if (mounted) setState(() => _rebuildItems());
  }

  @override
  Widget build(BuildContext context) {
    final cfg   = widget.config;
    final group = widget.group;
    final pct   = group.total == 0 ? 0.0 : group.completed / group.total;

    return Scaffold(
      backgroundColor: _kBeige,
      body: CustomScrollView(slivers: [

        // ── En-tête de la sourate ────────────────────────────────
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: cfg.gradient,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back + noms
                    Row(children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(group.nameFr,
                              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                          Text(group.name,
                              style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 16)),
                        ],
                      )),
                      Text(group.icon, style: const TextStyle(fontSize: 32)),
                    ]),
                    const SizedBox(height: 10),

                    // Signification
                    Padding(
                      padding: const EdgeInsets.only(left: 42),
                      child: Text(
                        group.signification,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Barre de progression de la sourate
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                      ),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${group.completed}/${group.total} versets appris',
                                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                            Text('${(pct * 100).round()}%',
                                style: const TextStyle(color: _kGoldLight, fontSize: 13, fontWeight: FontWeight.w800)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: LinearProgressIndicator(
                            value:           pct,
                            minHeight:       8,
                            backgroundColor: Colors.white.withOpacity(0.25),
                            valueColor:      const AlwaysStoppedAnimation(_kGold),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ── Liste versets + quiz ─────────────────────────────────
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                final item = _items[i];

                if (item is _LessonItem) {
                  final l = item.lesson;
                  return _LessonTile(
                    lesson: l,
                    index:  item.globalIndex,
                    config: cfg,
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LessonScreen(lesson: l)));
                      if (l.versets.isNotEmpty &&
                          l.versets.every((v) => v.mastery == MasteryLevel.mastered)) {
                        await _handleLessonComplete(l);
                      }
                    },
                  );
                } else if (item is _QuizItem) {
                  return _QuizTile(
                    quizItem: item,
                    config:   cfg,
                    onTap: () async {
                      if (!item.allComplete) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:  const Text('🔒 Termine les 5 versets précédents d\'abord'),
                          backgroundColor: _kGreenPrimary,
                          behavior: SnackBarBehavior.floating,
                          shape:    RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          margin:   const EdgeInsets.all(16),
                        ));
                        return;
                      }
                      final passed = await Navigator.push<bool>(context,
                          MaterialPageRoute(builder: (_) => QuizScreen(
                            lessons:      item.lessons,
                            surahName:    item.surahName,
                            surahNameFr:  item.surahNameFr,
                            surahNumber:  item.surahNumber,
                            stats:        widget.stats,
                            isFinalQuiz:  false,
                            quizIndex:    item.quizIndex,
                          )));
                      if (passed == true) {
                        final key = LearningService.intermediateQuizKey(item.surahNumber, item.quizIndex);
                        await _handleQuizComplete(key, 25);
                      }
                    },
                  );
                } else if (item is _FinalQuizItem) {
                  return _FinalQuizTile(
                    quizItem: item,
                    config:   cfg,
                    onTap: () async {
                      if (!item.allComplete) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:  const Text('🔒 Termine tous les versets de la sourate d\'abord'),
                          backgroundColor: _kGreenPrimary,
                          behavior: SnackBarBehavior.floating,
                          shape:    RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          margin:   const EdgeInsets.all(16),
                        ));
                        return;
                      }
                      final passed = await Navigator.push<bool>(context,
                          MaterialPageRoute(builder: (_) => QuizScreen(
                            lessons:      item.lessons,
                            surahName:    item.surahName,
                            surahNameFr:  item.surahNameFr,
                            surahNumber:  item.surahNumber,
                            stats:        widget.stats,
                            isFinalQuiz:  true,
                          )));
                      if (passed == true) {
                        final key = LearningService.finalQuizKey(item.surahNumber);
                        await _handleQuizComplete(key, 50);
                      }
                    },
                  );
                }
                return const SizedBox.shrink();
              },
              childCount: _items.length,
            ),
          ),
        ),
      ]),
    );
  }
}

// ─── Lesson Tile (1 verset) ───────────────────────────────────────
class _LessonTile extends StatelessWidget {
  final LearningLesson  lesson;
  final int             index;
  final _PathConfig     config;
  final VoidCallback    onTap;
  const _LessonTile({required this.lesson, required this.index, required this.config, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final locked  = !lesson.isUnlocked;
    final done    = lesson.isCompleted;
    final current = lesson.isUnlocked && !lesson.isCompleted;

    return GestureDetector(
      onTap: locked ? () => _showLockedSnack(context) : onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: locked ? 0.45 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: _kBeigeCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: done    ? config.primary.withOpacity(0.4)
                  : current ? config.primary
                  : _kBeigeBorder,
              width: current ? 2.0 : 1.2,
            ),
            boxShadow: [
              if (current) BoxShadow(color: config.primary.withOpacity(0.15), blurRadius: 16, offset: const Offset(0, 4)),
              const BoxShadow(color: Color(0x08000000), blurRadius: 6, offset: Offset(0, 2)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                  color: done    ? config.primary
                       : current ? config.light
                       : locked  ? _kBeigeBorder.withOpacity(0.4)
                       : const Color(0xFFF5F0E8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: done ? config.primary : current ? config.primary : _kBeigeBorder,
                    width: current ? 1.5 : 1,
                  ),
                ),
                child: Center(
                  child: locked
                    ? const Icon(Icons.lock_outline_rounded, color: _kTextLight, size: 16)
                    : done
                      ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
                      : Text('${lesson.versetNumero}',
                          style: TextStyle(
                            color: current ? config.primary : _kTextLight,
                            fontSize: 15, fontWeight: FontWeight.w900)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(child: _buildContent(done, current, locked)),
              const SizedBox(width: 6),
              Icon(
                locked ? Icons.lock_rounded : Icons.arrow_forward_ios_rounded,
                color: locked ? _kTextLight : current ? config.primary : _kBeigeBorder,
                size:  locked ? 15 : 13,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool done, bool current, bool locked) {
    final v = lesson.versets.isNotEmpty ? lesson.versets.first : null;
    final phonSnippet = v != null
        ? v.phonetique.split(' ').take(5).join(' ') + (v.phonetique.split(' ').length > 5 ? '...' : '')
        : '';
    final frSnippet = v != null
        ? v.francais.split(' ').take(6).join(' ') + (v.francais.split(' ').length > 6 ? '...' : '')
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          phonSnippet,
          style: TextStyle(
            color: locked ? _kTextLight : _kTextDark,
            fontSize: 14, fontWeight: FontWeight.w700,
          ),
          maxLines: 1, overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          frSnippet,
          style: TextStyle(
            color: locked ? _kBeigeBorder : _kTextLight,
            fontSize: 11,
          ),
          maxLines: 1, overflow: TextOverflow.ellipsis,
        ),
        if (!locked) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (done)
                _badge('✓ Maîtrisé', config.primary, config.light)
              else if (current)
                _badge('À apprendre', config.primary, config.primary),
              const Spacer(),
              Text('⚡ ${lesson.xpReward} XP',
                  style: const TextStyle(color: _kGold, fontSize: 10, fontWeight: FontWeight.w800)),
            ],
          ),
        ],
        if (locked)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(children: const [
              Icon(Icons.lock_outline_rounded, color: _kTextLight, size: 11),
              SizedBox(width: 3),
              Text('Termine le verset précédent',
                  style: TextStyle(color: _kTextLight, fontSize: 10)),
            ]),
          ),
      ],
    );
  }

  Widget _badge(String text, Color fg, Color bg) {
    final isDark = bg == fg;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color:        isDark ? fg : bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text,
          style: TextStyle(
            color: isDark ? Colors.white : fg,
            fontSize: 9, fontWeight: FontWeight.w900,
          )),
    );
  }

  void _showLockedSnack(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:  const Text('🔒 Termine le verset précédent pour débloquer'),
      backgroundColor: _kGreenPrimary,
      behavior: SnackBarBehavior.floating,
      shape:    RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin:   const EdgeInsets.all(16),
    ));
  }
}

// ─── Quiz intermédiaire Tile ──────────────────────────────────────
class _QuizTile extends StatelessWidget {
  final _QuizItem    quizItem;
  final _PathConfig  config;
  final VoidCallback onTap;
  const _QuizTile({required this.quizItem, required this.config, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final locked  = !quizItem.allComplete;
    final done    = quizItem.done;
    final active  = quizItem.allComplete && !done;

    final bgColor     = done    ? const Color(0xFFE8F4EE)
                      : active  ? const Color(0xFFFFF8EC)
                      : const Color(0xFFF8F4ED);
    final borderColor = done    ? _kGreenPrimary.withOpacity(0.50)
                      : active  ? _kGold
                      : _kBeigeBorder;
    final labelColor  = done    ? _kGreenPrimary
                      : active  ? _kGold
                      : _kTextLight;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: locked ? 0.55 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor, width: active ? 2.0 : 1.2),
            boxShadow: [
              if (active) BoxShadow(color: _kGold.withOpacity(0.18), blurRadius: 16, offset: const Offset(0, 4)),
              const BoxShadow(color: Color(0x06000000), blurRadius: 6, offset: Offset(0, 2)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            child: Row(children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                  color: done   ? _kGreenPrimary
                       : active ? _kGold.withOpacity(0.18)
                       : _kBeigeBorder.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: done ? _kGreenPrimary : active ? _kGold : _kBeigeBorder, width: 1.2),
                ),
                child: Center(child: done
                    ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
                    : locked
                      ? const Icon(Icons.lock_outline_rounded, color: _kTextLight, size: 16)
                      : const Text('⚡', style: TextStyle(fontSize: 18))),
              ),
              const SizedBox(width: 14),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quiz · Versets 1–${quizItem.lessons.length}',
                    style: TextStyle(
                      color: done ? _kGreenPrimary : active ? _kTextDark : _kTextLight,
                      fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    done    ? '✓ Réussi · +25 XP'
                    : active ? '5 questions · tous les versets précédents'
                    :          'Termine les 5 versets précédents',
                    style: TextStyle(color: labelColor, fontSize: 11),
                  ),
                ],
              )),
              const SizedBox(width: 6),
              Icon(
                locked && !done ? Icons.lock_rounded : Icons.arrow_forward_ios_rounded,
                color: locked && !done ? _kTextLight : active ? _kGold : _kBeigeBorder,
                size:  locked && !done ? 15 : 13,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ─── Quiz final Tile ──────────────────────────────────────────────
class _FinalQuizTile extends StatelessWidget {
  final _FinalQuizItem quizItem;
  final _PathConfig    config;
  final VoidCallback   onTap;
  const _FinalQuizTile({required this.quizItem, required this.config, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final locked = !quizItem.allComplete;
    final done   = quizItem.done;
    final active = quizItem.allComplete && !done;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: locked ? 0.55 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(top: 4, bottom: 16),
          decoration: BoxDecoration(
            gradient: done
                ? const LinearGradient(
                    colors: [Color(0xFF0D3A25), Color(0xFF1B5E40)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight)
                : active
                  ? LinearGradient(
                      colors: [_kGold.withOpacity(0.85), const Color(0xFFA87020)],
                      begin: Alignment.topLeft, end: Alignment.bottomRight)
                  : null,
            color: done || active ? null : const Color(0xFFF0EBE2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: done   ? const Color(0xFF2A7A52)
                   : active ? _kGold
                   : _kBeigeBorder,
              width: active ? 2.0 : 1.2,
            ),
            boxShadow: [
              if (active) BoxShadow(color: _kGold.withOpacity(0.30), blurRadius: 20, offset: const Offset(0, 6)),
              if (done)   BoxShadow(color: _kGreenPrimary.withOpacity(0.25), blurRadius: 20, offset: const Offset(0, 6)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(children: [
              Text(done ? '🏆' : active ? '🎯' : '🔒',
                  style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quiz Final · ${quizItem.surahNameFr}',
                    style: TextStyle(
                      color: done || active ? Colors.white : _kTextLight,
                      fontSize: 15, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    done    ? '✓ Sourate maîtrisée · +50 XP'
                    : active ? '${quizItem.lessons.length} versets · minimum 10 questions'
                    :          'Termine tous les versets de la sourate',
                    style: TextStyle(
                      color: done || active ? Colors.white.withOpacity(0.75) : _kTextLight,
                      fontSize: 11),
                  ),
                ],
              )),
              const SizedBox(width: 6),
              Icon(
                locked && !done ? Icons.lock_rounded : Icons.arrow_forward_ios_rounded,
                color: done || active ? Colors.white.withOpacity(0.7) : _kBeigeBorder,
                size: 15,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
