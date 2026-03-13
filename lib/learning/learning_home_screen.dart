import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'learning_models.dart';
import 'learning_path_screen.dart';
import 'review_screen.dart';
import 'progress_screen.dart';
import 'lesson_generator.dart';
import 'learning_service.dart';
import 'priere_guide_screen.dart';

// ─── Palette Deenly — Module Apprentissage ─────────────────────────
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

// ─── Learning Home Screen ─────────────────────────────────────────
class LearningHomeScreen extends StatefulWidget {
  const LearningHomeScreen({Key? key}) : super(key: key);

  @override
  State<LearningHomeScreen> createState() => _LearningHomeScreenState();
}

class _LearningHomeScreenState extends State<LearningHomeScreen>
    with SingleTickerProviderStateMixin {

  bool                 _loading          = true;
  UserStats            _stats            = UserStats();
  List<LearningLesson> _currentPath      = [];
  LearningLesson?      _nextLesson;
  List<LearningVerset> _reviewDue        = [];
  LearningPathType     _currentPathType  = LearningPathType.debutant;

  static const _kLastPathKey = 'deenly_learning_last_path';

  late AnimationController _pulseCtrl;
  late Animation<double>   _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    _load();
  }

  Future<void> _saveLastPathType(LearningPathType type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLastPathKey, type.name);
  }

  Future<void> _load() async {
    final stats = await LearningService.instance.loadStats();

    // Charger le dernier parcours ouvert (défaut : débutant)
    final prefs         = await SharedPreferences.getInstance();
    final savedPathName = prefs.getString(_kLastPathKey);
    LearningPathType pathType = LearningPathType.debutant;
    if (savedPathName != null) {
      try { pathType = LearningPathType.values.byName(savedPathName); } catch (_) {}
    }

    final path = LessonGenerator.buildPath(pathType);
    await LearningService.instance.applyMasteryToLessons(path);

    final next = path.firstWhere(
      (l) => !l.isCompleted && l.isUnlocked,
      orElse: () => path.first,
    );
    final due = LessonGenerator.getReviewDue(path);

    if (mounted) {
      setState(() {
        _stats           = stats;
        _currentPath     = path;
        _nextLesson      = next;
        _reviewDue       = due;
        _currentPathType = pathType;
        _loading         = false;
      });
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) _pulseCtrl.repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: _kGreenDeep,
        body: Center(child: CircularProgressIndicator(color: _kGold)),
      );
    }

    return Scaffold(
      backgroundColor: _kBeige,
      body: CustomScrollView(
        slivers: [
          // ── En-tête vert profond ──────────────────────────────
          SliverToBoxAdapter(child: _buildHeader(context)),

          // ── Corps beige ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              color: _kBeige,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Boutons d'action rapide
                    _buildQuickActions(),
                    const SizedBox(height: 16),

                    // Objectif quotidien
                    _DailyGoalCard(stats: _stats),
                    const SizedBox(height: 16),

                    // Révision si dispo
                    if (_reviewDue.isNotEmpty) ...[
                      _ReviewBanner(count: _reviewDue.length, versets: _reviewDue, stats: _stats),
                      const SizedBox(height: 16),
                    ],

                    // Section parcours
                    _sectionTitle('✦  Parcours d\'apprentissage'),
                    const SizedBox(height: 12),
                    _buildPathList(),
                    const SizedBox(height: 20),

                    // Stats semaine
                    _sectionTitle('✦  Ma semaine'),
                    const SizedBox(height: 12),
                    _StatsCard(stats: _stats),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── En-tête vert dégradé ──────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_kGreenDeep, _kGreenPrimary],
          stops: [0.0, 1.0],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Barre top : retour + titre + stats
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  // Bouton retour
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
                  const SizedBox(width: 12),
                  // Titre
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Apprentissage',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.3,
                            )),
                        Text('Apprends le Coran, verset par verset',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.55),
                                fontSize: 11)),
                      ],
                    ),
                  ),
                  // Bouton progression
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ProgressLearningScreen(stats: _stats)));
                      _load();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                      ),
                      child: const Text('📊', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Chips stat : streak / XP / niveau
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                _StatChip(icon: '🔥', value: '${_stats.streak}', label: 'jours',
                    color: const Color(0xFFFF8C42)),
                const SizedBox(width: 8),
                _StatChip(icon: '⚡', value: '${_stats.xp}', label: 'XP',
                    color: _kGoldLight),
                const SizedBox(width: 8),
                _StatChip(icon: '🏆', value: 'Nv.${_stats.level}',
                    label: _stats.levelTitle, color: _kGoldLight),
              ]),
            ),
            const SizedBox(height: 16),

            // Barre XP
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Niveau ${_stats.level} · ${_stats.levelTitle}',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6), fontSize: 11)),
                      Text('${_stats.xp} / ${_stats.xpForNextLevel} XP',
                          style: const TextStyle(
                              color: _kGoldLight, fontSize: 11, fontWeight: FontWeight.w800)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value:           _stats.levelProgress.clamp(0.0, 1.0),
                      minHeight:       7,
                      backgroundColor: Colors.white.withOpacity(0.15),
                      valueColor:      const AlwaysStoppedAnimation(_kGold),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 24),

            // Vague de transition bas header → corps beige
            ClipPath(
              clipper: _WaveClipper(),
              child: Container(height: 32, color: _kBeige),
            ),
          ],
        ),
      ),
    );
  }

  // ── Boutons action rapide ──────────────────────────────────────
  Widget _buildQuickActions() {
    return Row(children: [
      // Continuer mon parcours
      Expanded(
        child: ScaleTransition(
          scale: _pulseAnim,
          child: GestureDetector(
            onTap: () {
              if (_nextLesson != null) {
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => LearningPathScreen(
                        pathType: _currentPathType, stats: _stats)));
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kGreenPrimary, _kGreenMedium],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: _kGreenPrimary.withOpacity(0.35),
                      blurRadius: 16, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('▶', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(_nextLesson?.icon ?? '📖',
                      style: const TextStyle(fontSize: 26)),
                  const SizedBox(height: 6),
                  const Text('Continuer',
                      style: TextStyle(color: Colors.white,
                          fontSize: 14, fontWeight: FontWeight.w900)),
                  Text(_nextLesson?.surahNameFr ?? 'Débutant',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
                ],
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      // Explorer librement
      Expanded(
        child: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (_) => LearningPathScreen(
                  pathType: LearningPathType.libre, stats: _stats))),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8549BA), Color(0xFF5B2E8A)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Color(0x408549BA),
                    blurRadius: 16, offset: Offset(0, 5)),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🔓', style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 8),
                Text('📚', style: TextStyle(fontSize: 26)),
                SizedBox(height: 6),
                Text('Explorer',
                    style: TextStyle(color: Colors.white,
                        fontSize: 14, fontWeight: FontWeight.w900)),
                Text('114 sourates',
                    style: TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  // ── Liste verticale des parcours ──────────────────────────────
  Widget _buildPathList() {
    final paths = [
      _PathData('🌱', 'Débutant',    'Courtes sourates pour commencer',  '20 leçons',
          _kGreenPrimary, const Color(0xFFE8F4EE), LearningPathType.debutant),
      _PathData('🕌', 'Prière',      'Sourates récitées en prière',      '9 leçons',
          const Color(0xFF1A5C8A), const Color(0xFFE3EDF7), LearningPathType.priere),
      _PathData('🛡️', 'Protection',  'Sourates de protection & refuge',  '4 leçons',
          const Color(0xFFA85C00), const Color(0xFFFAEBD7), LearningPathType.protection),
      _PathData('⭐', 'Importantes', 'Les grandes sourates du Coran',    '9 leçons',
          _kGold, const Color(0xFFFFF4DC), LearningPathType.importantes),
      _PathData('📖', 'Juz Amma',    '30e juz complet (sourates 78–114)','37 leçons',
          const Color(0xFF6A3FAA), const Color(0xFFF3ECFA), LearningPathType.juzAmma),
      _PathData('🔓', 'Mode Libre',  'Toutes les 114 sourates',          '114 sourates',
          _kTextMid, const Color(0xFFEDE7D9), LearningPathType.libre),
    ];

    return Column(
      children: [
        // ── Carte spéciale : Guide de la Prière ──────────────────
        _PriereGuideCard(),
        const SizedBox(height: 10),
        // ── Parcours Coran ────────────────────────────────────────
        ...paths.map((p) => _PathRow(
          data:             p,
          stats:            _stats,
          onBeforeNavigate: () => _saveLastPathType(p.type),
        )),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Row(children: [
      Container(width: 3, height: 18, decoration: BoxDecoration(
        color: _kGold, borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 8),
      Text(text,
          style: const TextStyle(
              color: _kTextDark, fontSize: 15, fontWeight: FontWeight.w800,
              letterSpacing: 0.2)),
    ]);
  }
}

// ─── Wave Clipper ─────────────────────────────────────────────────
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.25, 0,
        size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.8,
        size.width, size.height * 0.3);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ─── Stat Chip ────────────────────────────────────────────────────
class _StatChip extends StatelessWidget {
  final String icon, value, label;
  final Color  color;
  const _StatChip({required this.icon, required this.value,
      required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
        ),
        child: Column(children: [
          Text(icon,  style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(
              color: color, fontSize: 14, fontWeight: FontWeight.w900)),
          Text(label, style: TextStyle(
              color: Colors.white.withOpacity(0.45), fontSize: 9)),
        ]),
      ),
    );
  }
}

// ─── Daily Goal Card ──────────────────────────────────────────────
class _DailyGoalCard extends StatelessWidget {
  final UserStats stats;
  const _DailyGoalCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final reached = stats.dailyGoalReached;
    final pct     = stats.dailyGoalProgress;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: reached ? const Color(0xFFB8DFB8) : _kBeigeBorder,
          width: 1.5,
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 3)),
        ],
      ),
      child: Row(children: [
        Container(
          width: 46, height: 46,
          decoration: BoxDecoration(
            color: reached ? const Color(0xFFE8F4EE) : const Color(0xFFFFF4DC),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(child: Text(reached ? '🎯' : '🔥',
              style: const TextStyle(fontSize: 22))),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reached ? 'Objectif atteint !' : 'Objectif du jour',
                  style: TextStyle(
                    color: reached ? _kGreenPrimary : _kTextDark,
                    fontSize: 13, fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '${stats.dailyXpToday} / ${stats.dailyXpGoal} XP',
                  style: TextStyle(
                    color: reached ? _kGreenMedium : _kGold,
                    fontSize: 11, fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value:           pct,
                minHeight:       7,
                backgroundColor: reached
                    ? const Color(0xFFD0EAD8)
                    : const Color(0xFFEDE0C4),
                valueColor: AlwaysStoppedAnimation(
                  reached ? _kGreenMedium : _kGold,
                ),
              ),
            ),
          ],
        )),
      ]),
    );
  }
}

// ─── Review Banner ────────────────────────────────────────────────
class _ReviewBanner extends StatelessWidget {
  final int                  count;
  final List<LearningVerset> versets;
  final UserStats            stats;
  const _ReviewBanner({required this.count, required this.versets, required this.stats});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => ReviewScreen(versets: versets, stats: stats))),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFEEF6F1),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFB8D8C8), width: 1.5),
          boxShadow: const [
            BoxShadow(color: Color(0x12000000), blurRadius: 8, offset: Offset(0, 3)),
          ],
        ),
        child: Row(children: [
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(
                color: const Color(0xFFD0E8DC),
                borderRadius: BorderRadius.circular(14)),
            child: const Center(child: Text('🔄', style: TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$count versets à réviser',
                  style: const TextStyle(
                      color: _kTextDark, fontSize: 14, fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              const Text('Consolide ta mémoire maintenant',
                  style: TextStyle(color: _kTextMid, fontSize: 11)),
            ],
          )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _kGreenPrimary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: _kGreenPrimary.withOpacity(0.35),
                    blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: const Text('Réviser',
                style: TextStyle(
                    color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ]),
      ),
    );
  }
}

// ─── Carte Guide de la Prière ─────────────────────────────────────
class _PriereGuideCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const PriereGuideScreen())),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A5C8A), Color(0xFF2A7AAA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Color(0x401A5C8A),
                blurRadius: 16, offset: Offset(0, 5)),
          ],
        ),
        child: Row(children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('🕌', style: TextStyle(fontSize: 26)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Guide de la Prière',
                    style: TextStyle(
                      color: Colors.white, fontSize: 15,
                      fontWeight: FontWeight.w900,
                    )),
                const SizedBox(height: 3),
                Text(
                  'Ablution · Positions · Rak\'ahs · Sunnah',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.65), fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Nouveau',
                style: TextStyle(
                    color: Colors.white, fontSize: 10,
                    fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 6),
          Icon(Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.7), size: 20),
        ]),
      ),
    );
  }
}

// ─── Path Data ────────────────────────────────────────────────────
class _PathData {
  final String icon, title, subtitle, count;
  final Color  primary, bg;
  final LearningPathType type;
  const _PathData(this.icon, this.title, this.subtitle, this.count,
      this.primary, this.bg, this.type);
}

// ─── Path Row ─────────────────────────────────────────────────────
class _PathRow extends StatelessWidget {
  final _PathData      data;
  final UserStats      stats;
  final VoidCallback?  onBeforeNavigate;
  const _PathRow({required this.data, required this.stats, this.onBeforeNavigate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          onBeforeNavigate?.call();
          Navigator.push(context,
              MaterialPageRoute(builder: (_) =>
                  LearningPathScreen(pathType: data.type, stats: stats)));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _kBeigeCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _kBeigeBorder, width: 1.2),
            boxShadow: const [
              BoxShadow(color: Color(0x0E000000), blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Row(children: [
            // Icône
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: data.bg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: data.primary.withOpacity(0.2), width: 1),
              ),
              child: Center(child: Text(data.icon,
                  style: const TextStyle(fontSize: 22))),
            ),
            const SizedBox(width: 14),
            // Texte
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title,
                    style: TextStyle(
                        color: data.primary,
                        fontSize: 15, fontWeight: FontWeight.w900)),
                const SizedBox(height: 3),
                Text(data.subtitle,
                    style: const TextStyle(color: _kTextLight, fontSize: 11)),
              ],
            )),
            // Compteur + flèche
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: data.bg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(data.count,
                      style: TextStyle(
                          color: data.primary,
                          fontSize: 10, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(height: 6),
                Icon(Icons.chevron_right_rounded,
                    color: data.primary.withOpacity(0.6), size: 20),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

// ─── Stats Card ───────────────────────────────────────────────────
class _StatsCard extends StatelessWidget {
  final UserStats stats;
  const _StatsCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => ProgressLearningScreen(stats: stats))),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: _kBeigeBorder, width: 1.2),
          boxShadow: const [
            BoxShadow(color: Color(0x10000000), blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ma semaine',
                  style: TextStyle(
                      color: _kTextDark, fontWeight: FontWeight.w800, fontSize: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4DC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('🔥 ${stats.streak} jours',
                    style: const TextStyle(
                        color: Color(0xFFA85C00),
                        fontSize: 11, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _DayStrip(streak: stats.streak),
          const SizedBox(height: 16),
          // Mini stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MiniStat('📖', '${stats.masteredVersets}', 'Maîtrisés',  _kGreenPrimary),
              _MiniStat('✅', '${stats.totalExercises}',  'Exercices',  const Color(0xFF1A5C8A)),
              _MiniStat('🎯', '${(stats.accuracy * 100).round()}%', 'Précision', const Color(0xFF6A3FAA)),
              _MiniStat('⚡', '${stats.xp}',             'XP total',   _kGold),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ProgressLearningScreen(stats: stats))),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: _kBeigeBorder),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text('Voir ma progression →',
                  style: TextStyle(
                      color: _kTextMid, fontWeight: FontWeight.w700, fontSize: 13)),
            ),
          ),
        ]),
      ),
    );
  }
}

// ─── Day Strip ────────────────────────────────────────────────────
class _DayStrip extends StatelessWidget {
  final int streak;
  const _DayStrip({required this.streak});

  @override
  Widget build(BuildContext context) {
    final days = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final active = i < (streak % 7 == 0 ? 7 : streak % 7);
        return Column(children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300 + i * 60),
            width: 36, height: 36,
            decoration: BoxDecoration(
              gradient: active ? const LinearGradient(
                colors: [Color(0xFFFFB020), Color(0xFFFF6B00)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ) : null,
              color: active ? null : const Color(0xFFEDE3CC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(active ? '🔥' : '○',
                  style: TextStyle(
                      fontSize: active ? 16 : 14,
                      color: active ? null : _kTextLight)),
            ),
          ),
          const SizedBox(height: 4),
          Text(days[i],
              style: const TextStyle(
                  color: _kTextMid, fontSize: 10, fontWeight: FontWeight.w600)),
        ]);
      }),
    );
  }
}

// ─── Mini Stat ────────────────────────────────────────────────────
class _MiniStat extends StatelessWidget {
  final String icon, value, label;
  final Color  color;
  const _MiniStat(this.icon, this.value, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(icon,  style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 3),
      Text(value, style: TextStyle(
          color: color, fontSize: 15, fontWeight: FontWeight.w900)),
      Text(label, style: const TextStyle(
          color: _kTextLight, fontSize: 9, fontWeight: FontWeight.w600)),
    ]);
  }
}
