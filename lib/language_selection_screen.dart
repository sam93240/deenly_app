// language_selection_screen.dart
// Écran de sélection de langue — premier lancement uniquement
// Flow : Splash → LanguageSelectionScreen → Onboarding / Home

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'app_locale.dart';

// ── Palette identique au splash ───────────────────────────────────────────
const _kGreenDeep = Color(0xFF0A2018);
const _kGreenMid  = Color(0xFF1B4D38);
const _kGold      = Color(0xFFC8933A);

// ══════════════════════════════════════════════════════════════════════════
class LanguageSelectionScreen extends StatefulWidget {
  final Widget nextScreen;
  const LanguageSelectionScreen({super.key, required this.nextScreen});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen>
    with TickerProviderStateMixin {
  // Entrée
  late final AnimationController _enterCtrl;
  late final Animation<double>   _enterFade;
  late final Animation<Offset>   _enterSlide;

  // Étoiles (copié du splash)
  late final AnimationController _starsCtrl;

  // Halo pulsant
  late final AnimationController _haloCtrl;
  late final Animation<double>   _haloScale;

  AppLanguage? _selected;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();

    // ── Entrée ──
    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _enterFade = CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOut);
    _enterSlide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOutCubic));

    // ── Étoiles ──
    _starsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    // ── Halo pulsant ──
    _haloCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _haloScale = Tween<double>(begin: 0.85, end: 1.15)
        .animate(CurvedAnimation(parent: _haloCtrl, curve: Curves.easeInOut));

    _enterCtrl.forward();
  }

  @override
  void dispose() {
    _enterCtrl.dispose();
    _starsCtrl.dispose();
    _haloCtrl.dispose();
    super.dispose();
  }

  Future<void> _selectLanguage(AppLanguage lang) async {
    if (_navigating) return;
    setState(() {
      _selected   = lang;
      _navigating = true;
    });

    await AppLocale().setLanguage(lang);
    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, _, _) => widget.nextScreen,
        transitionDuration: const Duration(milliseconds: 700),
        transitionsBuilder: (_, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kGreenDeep,
      body: AnimatedBuilder(
        animation: Listenable.merge([_starsCtrl, _haloCtrl]),
        builder: (_, __) => Stack(
          children: [
            // ── Fond étoilé ──────────────────────────────────────────────
            Positioned.fill(
              child: CustomPaint(
                painter: _StarsPainter(progress: _starsCtrl.value),
              ),
            ),

            // ── Halo doré ────────────────────────────────────────────────
            Align(
              alignment: const Alignment(0, -0.55),
              child: Transform.scale(
                scale: _haloScale.value,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _kGold.withValues(alpha: 0.08),
                        blurRadius: 90,
                        spreadRadius: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Contenu principal ────────────────────────────────────────
            SafeArea(
              child: FadeTransition(
                opacity: _enterFade,
                child: SlideTransition(
                  position: _enterSlide,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      children: [
                        const Spacer(flex: 2),

                        // Logo
                        _buildLogo(),

                        const Spacer(flex: 1),

                        // Séparateur ornemental
                        _buildOrnament(),
                        const SizedBox(height: 28),

                        // Titres bilingues
                        _buildTitles(),
                        const SizedBox(height: 36),

                        // Cartes langues
                        _LanguageCard(
                          flag: '🇫🇷',
                          label: 'Français',
                          sublabel: 'French',
                          isSelected: _selected == AppLanguage.fr,
                          onTap: () => _selectLanguage(AppLanguage.fr),
                        ),
                        const SizedBox(height: 14),
                        _LanguageCard(
                          flag: '🇬🇧',
                          label: 'English',
                          sublabel: 'Anglais',
                          isSelected: _selected == AppLanguage.en,
                          onTap: () => _selectLanguage(AppLanguage.en),
                        ),

                        const SizedBox(height: 28),
                        _buildOrnament(),
                        const Spacer(flex: 2),

                        // Bismillah
                        Text(
                          'بسم الله الرحمن الرحيم',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.18),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Logo ──────────────────────────────────────────────────────────────
  Widget _buildLogo() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFE8B060), _kGold, Color(0xFFD4A040)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            'ديني',
            style: TextStyle(
              color: Colors.white, // masqué par le shader
              fontSize: 68,
              fontWeight: FontWeight.w300,
              height: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'U P Y O U R D E E N',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 7,
          ),
        ),
      ],
    );
  }

  // ── Titres ────────────────────────────────────────────────────────────
  Widget _buildTitles() {
    return Column(
      children: [
        Text(
          'Choose your language',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Choisissez votre langue',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.40),
            fontSize: 13,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  // ── Ornement ──────────────────────────────────────────────────────────
  Widget _buildOrnament() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _gradientLine(reverse: true),
        Container(
          width: 5,
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: _kGold.withValues(alpha: 0.55),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 3,
          height: 3,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: _kGold.withValues(alpha: 0.30),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 3,
          height: 3,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: _kGold.withValues(alpha: 0.30),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 5,
          height: 5,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: _kGold.withValues(alpha: 0.55),
            shape: BoxShape.circle,
          ),
        ),
        _gradientLine(reverse: false),
      ],
    );
  }

  Widget _gradientLine({required bool reverse}) {
    return Container(
      width: 44,
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: reverse
              ? [_kGold.withValues(alpha: 0.45), Colors.transparent]
              : [Colors.transparent, _kGold.withValues(alpha: 0.45)],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// Carte langue
// ══════════════════════════════════════════════════════════════════════════
class _LanguageCard extends StatelessWidget {
  final String       flag;
  final String       label;
  final String       sublabel;
  final bool         isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.flag,
    required this.label,
    required this.sublabel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    _kGreenMid.withValues(alpha: 0.9),
                    _kGreenMid.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.05),
                    Colors.white.withValues(alpha: 0.03),
                  ],
                ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? _kGold.withValues(alpha: 0.80)
                : Colors.white.withValues(alpha: 0.10),
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: _kGold.withValues(alpha: 0.15),
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Drapeau avec fond circulaire
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.07),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(flag, style: const TextStyle(fontSize: 26)),
            ),
            const SizedBox(width: 16),

            // Textes
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.85),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    sublabel,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.38),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Indicateur animé
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: isSelected
                  ? Container(
                      key: const ValueKey('check'),
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: _kGold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    )
                  : Container(
                      key: const ValueKey('arrow'),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: _kGold.withValues(alpha: 0.6),
                        size: 13,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// Étoiles scintillantes (identique au splash)
// ══════════════════════════════════════════════════════════════════════════
class _StarsPainter extends CustomPainter {
  final double progress;
  _StarsPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(42);
    for (int i = 0; i < 60; i++) {
      final x       = rng.nextDouble() * size.width;
      final y       = rng.nextDouble() * size.height;
      final baseR   = rng.nextDouble() * 1.5 + 0.3;
      final phase   = rng.nextDouble() * math.pi * 2;
      final twinkle = 0.3 + 0.7 * ((math.sin(progress * math.pi * 2 + phase) + 1) / 2);
      final r       = baseR * twinkle;
      final o       = (rng.nextDouble() * 0.07 + 0.02) * twinkle;
      canvas.drawCircle(
        Offset(x, y),
        r,
        Paint()..color = Colors.white.withValues(alpha: o),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StarsPainter old) => old.progress != progress;
}
