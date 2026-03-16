// auth_screen.dart
// Écran de connexion / création de compte Firebase
// Design : cohérent avec la palette vert foncé / or de l'app

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth_service.dart';
import 'services/sync_service.dart';
import 'user_profile.dart';
import 'app_locale.dart';

// ── Palette ───────────────────────────────────────────────────────────────
const _kGreen     = Color(0xFF1B4D38);
const _kGreenDeep = Color(0xFF0A2018);
const _kGreenMid  = Color(0xFF2A7A52);
const _kGold      = Color(0xFFC8933A);
const _kBeige     = Color(0xFFF6F0E3);

// ══════════════════════════════════════════════════════════════════════════
enum _AuthMode { createAccount, login }

class AuthScreen extends StatefulWidget {
  /// Mode initial (création ou connexion)
  final _AuthMode initialMode;

  const AuthScreen.createAccount({super.key})
      : initialMode = _AuthMode.createAccount;

  const AuthScreen.login({super.key})
      : initialMode = _AuthMode.login;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late _AuthMode _mode;

  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey      = GlobalKey<FormState>();

  bool _loading      = false;
  bool _obscure      = true;
  String? _errorMsg;

  late final AnimationController _shakeCtrl;
  late final Animation<double>   _shakeAnim;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;

    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8),  weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: -6),  weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6, end: 6),  weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6, end: 0),   weight: 1),
    ]).animate(_shakeCtrl);
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _shakeCtrl.dispose();
    super.dispose();
  }

  // ── Actions ───────────────────────────────────────────────────────────

  Future<void> _handleGoogleSignIn() async {
    setState(() { _loading = true; _errorMsg = null; });
    try {
      final user = await AuthService.instance.signInWithGoogle();
      if (user != null && mounted) await _onSuccess(user);
    } on AuthException catch (e) {
      _showError(e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _handleEmailSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() { _loading = true; _errorMsg = null; });
    try {
      User? user;
      if (_mode == _AuthMode.createAccount) {
        user = await AuthService.instance.createAccountWithEmail(
          _emailCtrl.text, _passwordCtrl.text,
        );
      } else {
        user = await AuthService.instance.signInWithEmail(
          _emailCtrl.text, _passwordCtrl.text,
        );
      }
      if (user != null && mounted) await _onSuccess(user);
    } on AuthException catch (e) {
      _showError(e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _onSuccess(User user) async {
    // Sync local → Firebase
    final provider = DeenlyProfileScope.maybeOf(context);
    if (provider != null) {
      await SyncService.instance.syncAfterLogin(
        user:            user,
        profileProvider: provider,
      );
    }
    if (mounted) Navigator.pop(context, true); // true = connecté avec succès
  }

  void _showError(String msg) {
    setState(() => _errorMsg = msg);
    _shakeCtrl.forward(from: 0);
  }

  void _toggleMode() {
    setState(() {
      _mode = _mode == _AuthMode.createAccount
          ? _AuthMode.login
          : _AuthMode.createAccount;
      _errorMsg = null;
    });
  }

  // ── UI ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isCreate = _mode == _AuthMode.createAccount;
    final locale   = AppLocale();

    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: _kGreen),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // ── Titre ────────────────────────────────────────────
                Text(
                  isCreate
                      ? locale.tr('Créer un compte', 'Create account')
                      : locale.tr('Se connecter', 'Sign in'),
                  style: const TextStyle(
                    color:      _kGreen,
                    fontSize:   26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isCreate
                      ? locale.tr(
                          'Sauvegarde ta progression sur tous tes appareils.',
                          'Save your progress across all your devices.',
                        )
                      : locale.tr(
                          'Retrouve ta progression et continue là où tu t\'es arrêté.',
                          'Recover your progress and continue where you left off.',
                        ),
                  style: const TextStyle(
                    color:    Color(0xFF5A4833),
                    fontSize: 14,
                    height:   1.5,
                  ),
                ),

                const SizedBox(height: 32),

                // ── Bouton Google (primaire) ──────────────────────────
                _GoogleButton(
                  loading:  _loading,
                  onPressed: _handleGoogleSignIn,
                  label:     isCreate
                      ? locale.tr('Continuer avec Google', 'Continue with Google')
                      : locale.tr('Connexion avec Google', 'Sign in with Google'),
                ),

                const SizedBox(height: 20),

                // ── Séparateur ────────────────────────────────────────
                Row(children: [
                  const Expanded(child: Divider(color: Color(0xFFD6C9AF))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      locale.tr('ou par email', 'or by email'),
                      style: const TextStyle(
                        color: Color(0xFF8A7863), fontSize: 12),
                    ),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFD6C9AF))),
                ]),

                const SizedBox(height: 20),

                // ── Champ email ───────────────────────────────────────
                _DeenlyField(
                  controller:  _emailCtrl,
                  label:       locale.tr('Adresse email', 'Email address'),
                  icon:        Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator:   (v) {
                    if (v == null || v.trim().isEmpty) {
                      return locale.tr('Champ requis', 'Required field');
                    }
                    if (!v.contains('@')) {
                      return locale.tr('Email invalide', 'Invalid email');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // ── Champ mot de passe ────────────────────────────────
                _DeenlyField(
                  controller:  _passwordCtrl,
                  label:       locale.tr('Mot de passe', 'Password'),
                  icon:        Icons.lock_outline_rounded,
                  obscureText: _obscure,
                  suffixIcon:  IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: const Color(0xFF8A7863),
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  validator:   (v) {
                    if (v == null || v.isEmpty) {
                      return locale.tr('Champ requis', 'Required field');
                    }
                    if (isCreate && v.length < 6) {
                      return locale.tr(
                          '6 caractères minimum', 'Minimum 6 characters');
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 8),

                // ── Message d'erreur ──────────────────────────────────
                AnimatedBuilder(
                  animation: _shakeAnim,
                  builder: (_, child) => Transform.translate(
                    offset: Offset(_shakeAnim.value, 0),
                    child: child,
                  ),
                  child: AnimatedOpacity(
                    opacity:  _errorMsg != null ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      margin:  const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color:        const Color(0xFFFFEDED),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE57373)),
                      ),
                      child: Row(children: [
                        const Icon(Icons.error_outline_rounded,
                            color: Color(0xFFE57373), size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMsg ?? '',
                            style: const TextStyle(
                                color: Color(0xFFB71C1C), fontSize: 13),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Bouton principal ──────────────────────────────────
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _loading
                      ? const Center(
                          child: SizedBox(
                            width: 28, height: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: _kGreen,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: _handleEmailSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _kGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            isCreate
                                ? locale.tr('Créer mon compte', 'Create my account')
                                : locale.tr('Se connecter', 'Sign in'),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                        ),
                ),

                const SizedBox(height: 20),

                // ── Toggle mode ───────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isCreate
                          ? locale.tr('Déjà un compte ? ', 'Already have an account? ')
                          : locale.tr('Pas encore de compte ? ', "Don't have an account? "),
                      style: const TextStyle(
                          color: Color(0xFF8A7863), fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: _toggleMode,
                      child: Text(
                        isCreate
                            ? locale.tr('Se connecter', 'Sign in')
                            : locale.tr('Créer un compte', 'Create account'),
                        style: const TextStyle(
                          color:      _kGreen,
                          fontSize:   13,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: _kGreen,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// Bouton Google stylisé
// ══════════════════════════════════════════════════════════════════════════
class _GoogleButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPressed;
  final String label;

  const _GoogleButton({
    required this.loading,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color:        Colors.white,
          borderRadius: BorderRadius.circular(14),
          border:       Border.all(color: const Color(0xFFD6C9AF)),
          boxShadow: [
            BoxShadow(
              color:      Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset:     const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Google (SVG-like via Text)
            _GoogleLogo(),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color:      Color(0xFF1A130A),
                fontSize:   15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoogleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width  / 2;
    final cy = size.height / 2;
    final r  = size.width  / 2;

    // Cercle de fond blanc
    canvas.drawCircle(
      Offset(cx, cy), r,
      Paint()..color = Colors.white,
    );

    // Dessin simplifié du logo Google avec des arcs colorés
    final colors = [
      const Color(0xFF4285F4), // Bleu
      const Color(0xFF34A853), // Vert
      const Color(0xFFFBBC05), // Jaune
      const Color(0xFFEA4335), // Rouge
    ];

    final startAngles = [0.0, 90.0, 180.0, 270.0];
    for (int i = 0; i < 4; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.65),
        _deg(startAngles[i]),
        _deg(80),
        false,
        paint,
      );
    }
  }

  double _deg(double d) => d * 3.14159265 / 180;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ══════════════════════════════════════════════════════════════════════════
// Champ de texte stylisé
// ══════════════════════════════════════════════════════════════════════════
class _DeenlyField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const _DeenlyField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:   controller,
      keyboardType: keyboardType,
      obscureText:  obscureText,
      validator:    validator,
      style: const TextStyle(color: Color(0xFF1A130A), fontSize: 15),
      decoration: InputDecoration(
        labelText:    label,
        labelStyle:   const TextStyle(color: Color(0xFF8A7863), fontSize: 14),
        prefixIcon:   Icon(icon, color: _kGreen, size: 20),
        suffixIcon:   suffixIcon,
        filled:       true,
        fillColor:    Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:   const BorderSide(color: Color(0xFFD6C9AF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:   const BorderSide(color: Color(0xFFD6C9AF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:   const BorderSide(color: _kGreen, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE57373)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE57373), width: 1.5),
        ),
      ),
    );
  }
}
