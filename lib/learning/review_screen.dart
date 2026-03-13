import 'dart:async' show unawaited;
import 'package:flutter/material.dart';
import 'learning_models.dart';
import 'learning_service.dart';

// ─── Palette Deenly ─────────────────────────────────────────────────
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
const _kGreenLight   = Color(0xFFE8F4EE);
const _kBlue         = Color(0xFF1CB0F6);
const _kBlueLight    = Color(0xFFE7F7FF);
const _kRed          = Color(0xFFFF4B4B);
const _kRedLight     = Color(0xFFFFEBEB);
const _kOrange       = Color(0xFFFF9600);
const _kOrangeLight  = Color(0xFFFFF0D0);

// ─── Review Screen (Révision espacée SRS) ─────────────────────────
class ReviewScreen extends StatefulWidget {
  final List<LearningVerset> versets;
  final UserStats            stats;
  const ReviewScreen({Key? key, required this.versets, required this.stats}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> with TickerProviderStateMixin {
  int  _index    = 0;
  bool _flipped  = false;
  bool _done     = false;
  int  _mastered = 0;
  int  _toReview = 0;

  late AnimationController _flipCtrl;
  late Animation<double>   _flipAnim;
  late AnimationController _slideCtrl;
  late Animation<Offset>   _slideAnim;
  late AnimationController _celebCtrl;
  late Animation<double>   _celebAnim;

  @override
  void initState() {
    super.initState();
    _flipCtrl = AnimationController(duration: const Duration(milliseconds: 450), vsync: this);
    _flipAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _flipCtrl, curve: Curves.easeInOutCubic));

    _slideCtrl = AnimationController(duration: const Duration(milliseconds: 280), vsync: this);
    _slideAnim = Tween<Offset>(begin: Offset.zero, end: const Offset(-1.5, 0)).animate(
        CurvedAnimation(parent: _slideCtrl, curve: Curves.easeInCubic));

    _celebCtrl = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _celebAnim = CurvedAnimation(parent: _celebCtrl, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _flipCtrl.dispose();
    _slideCtrl.dispose();
    _celebCtrl.dispose();
    super.dispose();
  }

  void _flip() {
    if (_flipped) return;
    setState(() => _flipped = true);
    _flipCtrl.forward();
  }

  Future<void> _respond(bool mastered) async {
    final v = widget.versets[_index];
    final now = DateTime.now();

    v.reviewCount++;
    v.lastReviewed = now;

    if (mastered) {
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
      widget.stats.addXP(5);
      widget.stats.totalExercises++;
      widget.stats.correctExercises++;
      setState(() => _mastered++);
    } else {
      switch (v.mastery) {
        case MasteryLevel.mastered:
        case MasteryLevel.reviewing:
          v.mastery = MasteryLevel.learning;
          break;
        case MasteryLevel.learning:
        case MasteryLevel.notSeen:
          v.mastery = MasteryLevel.learning;
          break;
      }
      widget.stats.totalExercises++;
      setState(() => _toReview++);
    }

    unawaited(LearningService.instance.saveVersetMastery(
      v.surahNumber, v.numero, v.mastery, now,
    ));
    unawaited(LearningService.instance.saveStats(widget.stats));

    await _slideCtrl.forward();
    if (_index + 1 >= widget.versets.length) {
      setState(() => _done = true);
      _celebCtrl.forward();
    } else {
      setState(() { _index++; _flipped = false; });
      _flipCtrl.reset();
      _slideCtrl.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      body: SafeArea(
        child: _done ? _buildSummary(context) : _buildReview(context),
      ),
    );
  }

  Widget _buildReview(BuildContext context) {
    final v        = widget.versets[_index];
    final progress = _index / widget.versets.length;

    return Column(children: [
      _buildTopBar(context, progress),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Column(children: [
            // Flashcard
            Expanded(
              child: SlideTransition(
                position: _slideAnim,
                child: GestureDetector(
                  onTap: _flip,
                  child: AnimatedBuilder(
                    animation: _flipAnim,
                    builder: (_, __) {
                      final angle    = _flipAnim.value * 3.14159;
                      final showBack = _flipAnim.value > 0.5;
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(showBack ? angle - 3.14159 : angle),
                        alignment: Alignment.center,
                        child: showBack ? _buildBack(v) : _buildFront(v),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Hint
            AnimatedOpacity(
              opacity: _flipped ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _kBlueLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: const [
                  Icon(Icons.touch_app_rounded, color: _kBlue, size: 16),
                  SizedBox(width: 6),
                  Text('Appuie pour voir la réponse',
                      style: TextStyle(color: _kBlue, fontSize: 12, fontWeight: FontWeight.w700)),
                ]),
              ),
            ),
            const SizedBox(height: 16),

            // Boutons réponse
            AnimatedSlide(
              offset: _flipped ? Offset.zero : const Offset(0, 0.4),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: _flipped ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: _buildButtons(),
              ),
            ),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    ]);
  }

  Widget _buildTopBar(BuildContext context, double progress) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      decoration: const BoxDecoration(
        color: _kBeigeCard,
        border: Border(bottom: BorderSide(color: _kBeigeBorder)),
        boxShadow: [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(children: [
        Row(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kBeigeBorder.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.close_rounded, color: _kTextLight, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Stack(children: [
              Container(height: 12, decoration: BoxDecoration(color: _kBeigeBorder, borderRadius: BorderRadius.circular(99))),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [_kGreenPrimary, _kGreenMedium]),
                    borderRadius: BorderRadius.circular(99),
                    boxShadow: [BoxShadow(color: _kGreenPrimary.withOpacity(0.4), blurRadius: 6)],
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(width: 12),
          Text('${_index + 1}/${widget.versets.length}',
              style: const TextStyle(color: _kTextLight, fontSize: 12, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pill('✅ $_mastered maîtrisés',   _kGreenLight,  _kGreenPrimary),
            const SizedBox(width: 8),
            _pill('🔄 $_toReview à revoir',    _kGoldLight,   _kGold),
          ],
        ),
      ]),
    );
  }

  Widget _pill(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w800)),
    );
  }

  Widget _buildFront(LearningVerset v) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_kGreenDeep, _kGreenPrimary],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: _kGreenPrimary.withOpacity(0.40), blurRadius: 28, offset: const Offset(0, 8))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Verset ${v.numero}',
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(v.arabe,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color: _kGold, fontSize: 30, fontWeight: FontWeight.w600,
                height: 2.3, fontFamily: 'serif',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('👆 Appuie pour voir',
                style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildBack(LearningVerset v) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _kBeigeBorder, width: 1.5),
        boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 20, offset: Offset(0, 6))],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(children: [
          Text(v.arabe,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: const TextStyle(color: _kTextDark, fontSize: 24, fontWeight: FontWeight.w600,
                height: 2.1, fontFamily: 'serif'),
          ),
          const SizedBox(height: 20),
          const Divider(color: _kBeigeBorder),
          const SizedBox(height: 20),

          // Phonétique
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: _kBlueLight, borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Icon(Icons.record_voice_over_rounded, color: _kBlue, size: 16),
                SizedBox(width: 6),
                Text('PHONÉTIQUE', style: TextStyle(color: _kBlue, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
              ]),
              const SizedBox(height: 8),
              Text(v.phonetique, textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF1565C0), fontSize: 15,
                      fontStyle: FontStyle.italic, height: 1.5, fontWeight: FontWeight.w600)),
            ]),
          ),
          const SizedBox(height: 12),

          // Traduction
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: _kGoldLight, borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Text('🌍', style: TextStyle(fontSize: 14)),
                SizedBox(width: 6),
                Text('TRADUCTION', style: TextStyle(color: Color(0xFFA85C00), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
              ]),
              const SizedBox(height: 8),
              Text(v.francais, textAlign: TextAlign.center,
                  style: const TextStyle(color: _kTextMid, fontSize: 14, height: 1.6, fontWeight: FontWeight.w600)),
            ]),
          ),

          const SizedBox(height: 16),
          _MasteryBadge(level: v.mastery),
        ]),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(children: [
      Expanded(
        child: GestureDetector(
          onTap: () => _respond(false),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: _kBeigeCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _kRed.withOpacity(0.6), width: 2.5),
              boxShadow: [BoxShadow(color: _kRed.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Column(children: const [
              Text('🔄', style: TextStyle(fontSize: 26)),
              SizedBox(height: 6),
              Text('À revoir', style: TextStyle(color: _kRed, fontSize: 14, fontWeight: FontWeight.w900)),
            ]),
          ),
        ),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: GestureDetector(
          onTap: () => _respond(true),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: _kGreenLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _kGreenPrimary, width: 2.5),
              boxShadow: [BoxShadow(color: _kGreenPrimary.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Column(children: const [
              Text('✅', style: TextStyle(fontSize: 26)),
              SizedBox(height: 6),
              Text('Maîtrisé !', style: TextStyle(color: _kGreenDeep, fontSize: 14, fontWeight: FontWeight.w900)),
            ]),
          ),
        ),
      ),
    ]);
  }

  Widget _buildSummary(BuildContext context) {
    final total = widget.versets.length;
    final pct   = total == 0 ? 0 : (_mastered / total * 100).round();
    final xp    = _mastered * 5;
    final emoji = pct >= 80 ? '🏆' : pct >= 50 ? '⭐' : '📖';
    final color = pct >= 80 ? _kGreenPrimary : pct >= 50 ? _kGold : _kBlue;
    final msg   = pct >= 80 ? 'Révision parfaite !' : pct >= 50 ? 'Bon travail !' : 'Continue à pratiquer !';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(children: [
        const SizedBox(height: 20),
        ScaleTransition(scale: _celebAnim, child: Text(emoji, style: const TextStyle(fontSize: 80))),
        const SizedBox(height: 16),
        Text(msg, style: TextStyle(color: color, fontSize: 26, fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        const Text('Session de révision terminée !',
            style: TextStyle(color: _kTextLight, fontSize: 14)),
        const SizedBox(height: 32),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12, mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _summTile('✅', '$_mastered',  'Maîtrisés',  _kGreenPrimary, _kGreenLight),
            _summTile('🔄', '$_toReview',  'À revoir',   _kRed,          _kRedLight),
            _summTile('⚡', '+$xp',        'XP gagnés',  _kGold,         _kGoldLight),
            _summTile('🎯', '$pct%',       'Précision',  _kBlue,         _kBlueLight),
          ],
        ),
        const SizedBox(height: 32),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _kGreenPrimary,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: _kGreenPrimary.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            child: const Text('Retour 🎉',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
          ),
        ),
      ]),
    );
  }

  Widget _summTile(String icon, String val, String label, Color fg, Color bg) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(val,   style: TextStyle(color: fg, fontSize: 20, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(color: _kTextLight, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ─── Mastery Badge ────────────────────────────────────────────────
class _MasteryBadge extends StatelessWidget {
  final MasteryLevel level;
  const _MasteryBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    final data = switch (level) {
      MasteryLevel.notSeen   => ('🔘', 'Jamais vu',   _kBeigeBorder,  _kTextLight),
      MasteryLevel.learning  => ('📚', 'En cours',     _kOrangeLight,  _kOrange),
      MasteryLevel.reviewing => ('🔄', 'En révision',  _kBlueLight,    _kBlue),
      MasteryLevel.mastered  => ('⭐', 'Maîtrisé',     _kGreenLight,   _kGreenDeep),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: data.$3,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(data.$1, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 6),
        Text(data.$2, style: TextStyle(color: data.$4, fontSize: 12, fontWeight: FontWeight.w800)),
      ]),
    );
  }
}
