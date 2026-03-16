import 'package:flutter/material.dart';
import '../translations.dart';
import '../app_locale.dart';
import 'learning_models.dart';

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

// ─── Progress Screen ──────────────────────────────────────────────
class ProgressLearningScreen extends StatelessWidget {
  final UserStats stats;
  const ProgressLearningScreen({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: _buildHeader(context)),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _LevelCard(stats: stats),
              const SizedBox(height: 16),
              _DailyGoalCard(stats: stats),
              const SizedBox(height: 16),
              _WeekCard(stats: stats),
              const SizedBox(height: 16),
              _StatsGrid(stats: stats),
              const SizedBox(height: 16),
              _BadgesCard(stats: stats),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_kGreenDeep, _kGreenPrimary],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
          child: Row(children: [
            GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.t.progressMyProgress,
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                Text(context.t.progressStayMotivated,
                    style: const TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

// ─── Level Card ───────────────────────────────────────────────────
class _LevelCard extends StatelessWidget {
  final UserStats stats;
  const _LevelCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kBeigeBorder),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 16, offset: Offset(0, 4))],
      ),
      child: Column(children: [
        Row(children: [
          Container(
            width: 70, height: 70,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kGreenPrimary, _kGreenMedium],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [BoxShadow(color: _kGreenPrimary.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 4))],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🏆', style: TextStyle(fontSize: 22)),
                Text('${stats.level}',
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_s('Niveau ${stats.level} · ${stats.levelTitle}', 'Level ${stats.level} · ${stats.levelTitle}'),
                  style: const TextStyle(color: _kTextDark, fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text('${stats.xp} / ${stats.xpForNextLevel} XP',
                  style: const TextStyle(color: _kTextLight, fontSize: 13)),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value:           stats.levelProgress.clamp(0.0, 1.0),
                  minHeight:       12,
                  backgroundColor: const Color(0xFFD6E8DC),
                  valueColor:      const AlwaysStoppedAnimation(_kGreenMedium),
                ),
              ),
              const SizedBox(height: 6),
              Text(_s('Encore ${stats.xpForNextLevel - stats.xp} XP pour le niveau ${stats.level + 1}', 'Only ${stats.xpForNextLevel - stats.xp} XP left for level ${stats.level + 1}'),
                  style: const TextStyle(color: _kGreenPrimary, fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          )),
        ]),
        const SizedBox(height: 20),
        const Divider(color: _kBeigeBorder),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _LevelMilestone(_s('Débutant', 'Beginner'),    1, stats.level, _kTextLight),
            const _LevelArrow(),
            _LevelMilestone(_s('Récitant', 'Reciter'),    3, stats.level, _kGreenMedium),
            const _LevelArrow(),
            _LevelMilestone(_s('Mémorisateur', 'Memorizer'),6, stats.level, _kGold),
            const _LevelArrow(),
            _LevelMilestone(_s('Hafidh', 'Hafidh'),      10, stats.level, _kGreenPrimary),
          ],
        ),
      ]),
    );
  }
}

class _LevelMilestone extends StatelessWidget {
  final String label;
  final int    threshold, current;
  final Color  color;
  const _LevelMilestone(this.label, this.threshold, this.current, this.color);

  @override
  Widget build(BuildContext context) {
    final reached = current >= threshold;
    return Column(children: [
      Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color:  reached ? color.withValues(alpha: 0.15) : _kBeigeBorder.withValues(alpha: 0.3),
          shape:  BoxShape.circle,
          border: Border.all(color: reached ? color : _kBeigeBorder, width: 2),
        ),
        child: Center(child: Text(
          reached ? '✓' : '○',
          style: TextStyle(color: reached ? color : _kTextLight, fontSize: 16, fontWeight: FontWeight.w900),
        )),
      ),
      const SizedBox(height: 5),
      Text(label,
          style: TextStyle(
            color: reached ? color : _kTextLight,
            fontSize: 10, fontWeight: FontWeight.w700,
          )),
    ]);
  }
}

class _LevelArrow extends StatelessWidget {
  const _LevelArrow();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.arrow_forward_ios_rounded, color: _kBeigeBorder, size: 12);
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

    const kGreenLight  = Color(0xFFE8F4EE);
    const kOrange      = Color(0xFFFF9600);
    const kOrangeLight = Color(0xFFFFF0D0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kBeigeBorder),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 16, offset: Offset(0, 4))],
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_s('🎯 Objectif du jour', '🎯 Daily goal'),
                style: const TextStyle(color: _kTextDark, fontSize: 16, fontWeight: FontWeight.w800)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: reached ? kGreenLight : kOrangeLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                reached ? _s('✅ Atteint !', '✅ Reached!') : '${stats.dailyXpToday} / ${stats.dailyXpGoal} XP',
                style: TextStyle(
                  color: reached ? _kGreenDeep : kOrange,
                  fontSize: 12, fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value:           pct,
            minHeight:       14,
            backgroundColor: reached ? kGreenLight : kOrangeLight,
            valueColor:      AlwaysStoppedAnimation(reached ? _kGreenPrimary : kOrange),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          reached
              ? _s('🎉 Bravo ! Tu as atteint ton objectif quotidien.', '🎉 Congratulations! You\'ve reached your daily goal.')
              : _s('Plus que ${stats.dailyXpGoal - stats.dailyXpToday} XP pour atteindre ton objectif !', 'Only ${stats.dailyXpGoal - stats.dailyXpToday} XP left to reach your goal!'),
          style: TextStyle(
            color: reached ? _kGreenDeep : _kTextLight,
            fontSize: 12, fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}

// ─── Week Card ────────────────────────────────────────────────────
class _WeekCard extends StatelessWidget {
  final UserStats stats;
  const _WeekCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final days   = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
    final active = List.generate(7, (i) =>
        i < (stats.streak % 7 == 0 && stats.streak > 0 ? 7 : stats.streak % 7));

    const kOrange = Color(0xFFFF9600);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kBeigeBorder),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 16, offset: Offset(0, 4))],
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_s('📅 Cette semaine', '📅 This week'),
                style: const TextStyle(color: _kTextDark, fontSize: 16, fontWeight: FontWeight.w800)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF9600), Color(0xFFFF6B00)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(_s('🔥 ${stats.streak} jours', '🔥 ${stats.streak} days'),
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900)),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (i) => Column(children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200 + i * 60),
              width: 40, height: 40,
              decoration: BoxDecoration(
                gradient: active[i] ? const LinearGradient(
                  colors: [Color(0xFFFF9600), Color(0xFFFF6B00)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ) : null,
                color: active[i] ? null : _kBeigeBorder.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(14),
                boxShadow: active[i]
                    ? [BoxShadow(color: kOrange.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 3))]
                    : [],
              ),
              child: Center(child: Text(
                active[i] ? '🔥' : '·',
                style: TextStyle(fontSize: 20, color: active[i] ? null : _kTextLight),
              )),
            ),
            const SizedBox(height: 6),
            Text(days[i], style: const TextStyle(color: _kTextLight, fontSize: 11, fontWeight: FontWeight.w700)),
          ])),
        ),
      ]),
    );
  }
}

// ─── Stats Grid ───────────────────────────────────────────────────
class _StatsGrid extends StatelessWidget {
  final UserStats stats;
  const _StatsGrid({required this.stats});

  @override
  Widget build(BuildContext context) {
    final items = [
      _S('⚡', '${stats.xp}',                       _s('XP Total', 'Total XP'),   _kGold,                    _kGoldLight),
      _S('🔥', '${stats.streak}j',                  _s('Streak', 'Streak'),     const Color(0xFFFF9600),    const Color(0xFFFFF0D0)),
      _S('📖', '${stats.masteredVersets}',           _s('Maîtrisés', 'Mastered'),  _kGreenPrimary,             const Color(0xFFE8F4EE)),
      _S('✅', '${stats.totalExercises}',            _s('Exercices', 'Exercises'),  const Color(0xFF1CB0F6),    const Color(0xFFE7F7FF)),
      _S('🏆', 'Nv.${stats.level}',                 _s('Niveau', 'Level'),     const Color(0xFF8549BA),    const Color(0xFFF0E8FF)),
      _S('🎯', '${(stats.accuracy * 100).round()}%',_s('Précision', 'Accuracy'),  const Color(0xFFFF4B4B),    const Color(0xFFFFEBEB)),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 10, mainAxisSpacing: 10,
      childAspectRatio: 1.05,
      children: items.map((s) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kBeigeBorder),
          boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(s.icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 6),
            Text(s.value, style: TextStyle(color: s.color, fontSize: 17, fontWeight: FontWeight.w900)),
            Text(s.label, style: const TextStyle(color: _kTextLight, fontSize: 10, fontWeight: FontWeight.w600)),
          ],
        ),
      )).toList(),
    );
  }
}

class _S {
  final String icon, value, label;
  final Color  color, bg;
  const _S(this.icon, this.value, this.label, this.color, this.bg);
}

// ─── Badges Card ─────────────────────────────────────────────────
class _BadgesCard extends StatelessWidget {
  final UserStats stats;
  const _BadgesCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final badges = [
      _Badge('🌟', _s('Premier pas', 'First steps'),   _s('Terminer ta 1ère leçon', 'Complete your 1st lesson'),    stats.totalExercises > 0),
      _Badge('🔥', _s('Série de 7', '7-day streak'),    _s('Streak 7 jours', '7 day streak'),             stats.streak >= 7),
      _Badge('💎', _s('Expert', 'Expert'),        _s('100 exercices réussis', '100 successful exercises'),       stats.correctExercises >= 100),
      _Badge('📖', _s('Lecteur', 'Reader'),       _s('10 leçons terminées', '10 lessons completed'),        stats.xp >= 200),
      _Badge('🏆', _s('Mémorisateur', 'Memorizer'),  _s('50 versets maîtrisés', '50 verses mastered'),       stats.masteredVersets >= 50),
      _Badge('⭐', _s('Étoile', 'Star'),        _s('Niveau 5 atteint', 'Reached level 5'),           stats.level >= 5),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kBeigeBorder),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 16, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_s('🎖️ Badges', '🎖️ Badges'),
                  style: const TextStyle(color: _kTextDark, fontSize: 16, fontWeight: FontWeight.w800)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: _kGoldLight, borderRadius: BorderRadius.circular(20)),
                child: Text('${badges.where((b) => b.earned).length}/${badges.length}',
                    style: const TextStyle(color: _kGold, fontSize: 12, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 10, mainAxisSpacing: 10,
            childAspectRatio: 0.88,
            children: badges.map((b) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: b.earned ? _kGoldLight : _kBeigeBorder.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: b.earned ? _kGold.withValues(alpha: 0.4) : _kBeigeBorder,
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  b.earned
                      ? Text(b.icon, style: const TextStyle(fontSize: 28))
                      : const Text('🔒', style: TextStyle(fontSize: 28)),
                  const SizedBox(height: 6),
                  Text(b.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: b.earned ? const Color(0xFFB06000) : _kTextLight,
                        fontSize: 10, fontWeight: FontWeight.w800,
                      )),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _Badge {
  final String icon, title, desc;
  final bool   earned;
  const _Badge(this.icon, this.title, this.desc, this.earned);
}
