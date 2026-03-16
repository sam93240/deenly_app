// widgets/save_progress_banner.dart
// Bannière d'invitation à créer un compte — affichée en haut du Home
// Disparaît automatiquement quand l'utilisateur est connecté.
// Peut être fermée définitivement par l'utilisateur.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_screen.dart';
import '../services/auth_service.dart';
import '../services/engagement_service.dart';
import '../app_locale.dart';

// ══════════════════════════════════════════════════════════════════════════
class SaveProgressBanner extends StatefulWidget {
  const SaveProgressBanner({super.key});

  @override
  State<SaveProgressBanner> createState() => _SaveProgressBannerState();
}

class _SaveProgressBannerState extends State<SaveProgressBanner>
    with SingleTickerProviderStateMixin {
  bool _dismissed = false;
  bool _ready      = false;

  late final AnimationController _slideCtrl;
  late final Animation<Offset>   _slideAnim;
  late final Animation<double>   _fadeAnim;

  @override
  void initState() {
    super.initState();
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end:   Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));
    _fadeAnim = CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut);

    _checkDismissed();
  }

  @override
  void dispose() {
    _slideCtrl.dispose();
    super.dispose();
  }

  Future<void> _checkDismissed() async {
    final dismissed = await EngagementService.instance.isBannerDismissed();
    if (mounted) {
      setState(() {
        _dismissed = dismissed;
        _ready     = true;
      });
      if (!dismissed) _slideCtrl.forward();
    }
  }

  Future<void> _dismiss() async {
    await _slideCtrl.reverse();
    await EngagementService.instance.dismissBanner();
    if (mounted) setState(() => _dismissed = true);
  }

  void _openAuth(_AuthIntent intent) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => intent == _AuthIntent.create
            ? const AuthScreen.createAccount()
            : const AuthScreen.login(),
        fullscreenDialog: true,
      ),
    );
    // Si connexion réussie → fermer la bannière
    if (result == true && mounted) {
      await _slideCtrl.reverse();
      if (mounted) setState(() => _dismissed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Écoute l'état de connexion Firebase
    return StreamBuilder<User?>(
      stream: AuthService.instance.authStateChanges,
      builder: (context, snapshot) {
        final loggedIn = snapshot.data != null;

        if (!_ready || _dismissed || loggedIn) return const SizedBox.shrink();

        return SlideTransition(
          position: _slideAnim,
          child: FadeTransition(
            opacity: _fadeAnim,
            child: _BannerCard(
              onDismiss:     _dismiss,
              onCreateTap:   () => _openAuth(_AuthIntent.create),
              onLoginTap:    () => _openAuth(_AuthIntent.login),
              onSkipTap:     _dismiss,
            ),
          ),
        );
      },
    );
  }
}

// ── Intent ────────────────────────────────────────────────────────────────
enum _AuthIntent { create, login }

// ══════════════════════════════════════════════════════════════════════════
// Carte visuelle
// ══════════════════════════════════════════════════════════════════════════
class _BannerCard extends StatelessWidget {
  final VoidCallback onDismiss;
  final VoidCallback onCreateTap;
  final VoidCallback onLoginTap;
  final VoidCallback onSkipTap;

  const _BannerCard({
    required this.onDismiss,
    required this.onCreateTap,
    required this.onLoginTap,
    required this.onSkipTap,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B4D38), Color(0xFF0A2018)],
          begin:  Alignment.topLeft,
          end:    Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color:      const Color(0xFF1B4D38).withValues(alpha: 0.25),
            blurRadius: 16,
            offset:     const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Motif décoratif
          Positioned(
            right: -20,
            top:   -20,
            child: Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -30,
            child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.03),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── En-tête ──────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color:        const Color(0xFFC8933A).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.cloud_done_rounded,
                          color: Color(0xFFC8933A), size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.tr(
                              'Sauvegarde ta progression',
                              'Save your progress',
                            ),
                            style: const TextStyle(
                              color:      Colors.white,
                              fontSize:   14,
                              fontWeight: FontWeight.w700,
                              height:     1.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            locale.tr(
                              'Crée un compte gratuit pour ne jamais perdre ton Coran, tes leçons et ta série.',
                              'Create a free account to keep your Quran, lessons and streak safe.',
                            ),
                            style: TextStyle(
                              color:    Colors.white.withValues(alpha: 0.65),
                              fontSize: 12,
                              height:   1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Croix de fermeture
                    GestureDetector(
                      onTap: onDismiss,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(Icons.close_rounded,
                            color: Colors.white.withValues(alpha: 0.4), size: 18),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ── Boutons ───────────────────────────────────────────
                Row(children: [
                  // Créer un compte (primaire)
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: onCreateTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color:        const Color(0xFFC8933A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          locale.tr('Créer un compte', 'Create account'),
                          style: const TextStyle(
                            color:      Colors.white,
                            fontSize:   12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Connexion (secondaire)
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: onLoginTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color:        Colors.white.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.20)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          locale.tr('Connexion', 'Sign in'),
                          style: TextStyle(
                            color:      Colors.white.withValues(alpha: 0.9),
                            fontSize:   12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Plus tard (texte)
                  GestureDetector(
                    onTap: onSkipTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        locale.tr('Plus tard', 'Later'),
                        style: TextStyle(
                          color:    Colors.white.withValues(alpha: 0.35),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
