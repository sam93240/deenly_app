// splash_screen.dart
// Écran de démarrage animé — Application UpYourDeen

import 'dart:math' as math;
import 'package:flutter/material.dart';

// ── Palette ──────────────────────────────────────────────────────────
const _kGreenDeep = Color(0xFF0A2018);
const _kGreen = Color(0xFF1B4D38);
const _kGold = Color(0xFFC8933A);
const _kGoldLt = Color(0xFFE8BF6A);

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;
  const SplashScreen({super.key, required this.nextScreen});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoCtrl;
  late final AnimationController _fadeCtrl;
  late final AnimationController _starsCtrl;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _textOpacity;
  late final Animation<double> _subtitleOpacity;
  late final Animation<double> _globalFade;

  @override
  void initState() {
    super.initState();

    // Logo : scale + opacity
    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoCtrl,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoCtrl,
        curve: const Interval(0.35, 0.65, curve: Curves.easeIn),
      ),
    );
    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoCtrl,
        curve: const Interval(0.55, 0.85, curve: Curves.easeIn),
      ),
    );

    // Étoiles scintillantes
    _starsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    // Fondu de sortie
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _globalFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut),
    );

    // Séquence
    _logoCtrl.forward();
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      _fadeCtrl.forward().then((_) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => widget.nextScreen,
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(opacity: anim, child: child);
            },
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _fadeCtrl.dispose();
    _starsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_logoCtrl, _fadeCtrl, _starsCtrl]),
      builder: (context, _) {
        return Opacity(
          opacity: _globalFade.value,
          child: Scaffold(
            backgroundColor: _kGreenDeep,
            body: Stack(
              children: [
                // ── Étoiles animées ──
                Positioned.fill(
                  child: CustomPaint(
                    painter: _StarsPainter(
                        progress: _starsCtrl.value,
                        opacity: _logoOpacity.value),
                  ),
                ),

                // ── Halo doré central ──
                Center(
                  child: Opacity(
                    opacity: _logoOpacity.value * 0.4,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _kGold.withOpacity(0.15),
                            blurRadius: 80,
                            spreadRadius: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Contenu central ──
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Ornement haut
                      Opacity(
                        opacity: _subtitleOpacity.value,
                        child: _buildOrnament(),
                      ),
                      const SizedBox(height: 16),

                      // ديني
                      Transform.scale(
                        scale: _logoScale.value,
                        child: Opacity(
                          opacity: _logoOpacity.value,
                          child: const Text('ديني',
                              style: TextStyle(
                                color: _kGold,
                                fontSize: 72,
                                fontWeight: FontWeight.w300,
                                height: 1.0,
                              )),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // D E E N L Y
                      Opacity(
                        opacity: _textOpacity.value,
                        child: const Text('D E E N L Y',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 8,
                            )),
                      ),
                      const SizedBox(height: 10),

                      // Slogan
                      Opacity(
                        opacity: _subtitleOpacity.value,
                        child: Text('Lumière sur ta foi',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.5,
                            )),
                      ),
                      const SizedBox(height: 16),

                      // Ornement bas
                      Opacity(
                        opacity: _subtitleOpacity.value,
                        child: _buildOrnament(),
                      ),

                      const SizedBox(height: 40),

                      // Bismillah
                      Opacity(
                        opacity: _subtitleOpacity.value,
                        child: Text(
                          'بسم الله الرحمن الرحيم',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.25),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrnament() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.transparent,
              _kGold.withOpacity(0.5),
            ]),
          ),
        ),
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: _kGold.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 40,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              _kGold.withOpacity(0.5),
              Colors.transparent,
            ]),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// PAINTER : Étoiles scintillantes
// ══════════════════════════════════════════════════════════════════════════
class _StarsPainter extends CustomPainter {
  final double progress;
  final double opacity;
  _StarsPainter({required this.progress, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(42);
    for (int i = 0; i < 60; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final baseR = rng.nextDouble() * 1.5 + 0.3;
      final phase = rng.nextDouble() * math.pi * 2;
      final twinkle =
          0.3 + 0.7 * ((math.sin(progress * math.pi * 2 + phase) + 1) / 2);
      final r = baseR * twinkle;
      final o = opacity * (rng.nextDouble() * 0.06 + 0.02) * twinkle;
      canvas.drawCircle(
          Offset(x, y), r, Paint()..color = Colors.white.withOpacity(o));
    }
  }

  @override
  bool shouldRepaint(covariant _StarsPainter old) => true;
}
