// onboarding_screen.dart
// Parcours d'accueil – Application UpYourDeen

import 'package:flutter/material.dart';
import 'user_profile.dart';
import 'main_nav_screen.dart';

// ── Palette ──────────────────────────────────────────────────────────
const _kGreen = Color(0xFF1B4D38);
const _kGreenDk = Color(0xFF0A2018);
const _kGreenMd = Color(0xFF2A7A52);
const _kGold = Color(0xFFC8933A);
const _kGoldLt = Color(0xFFE8BF6A);
const _kBeige = Color(0xFFF6F0E3);
const _kTxtDk = Color(0xFF1A130A);
const _kTxtMd = Color(0xFF5A4833);

class OnboardingScreen extends StatefulWidget {
  final bool editMode;
  const OnboardingScreen({super.key, this.editMode = false});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageCtrl = PageController();
  int _step = 0;

  // Données collectées
  String _prenom = '';
  int _age = 25;
  DeenlyLevel _niveau = DeenlyLevel.debutant;
  final Set<DeenlyGoal> _objectifs = {};
  String _avatar = '🌙';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.editMode) {
      final provider = DeenlyProfileScope.maybeOf(context);
      final p = provider?.profile;
      if (p != null) {
        _prenom = p.prenom;
        _age = p.age;
        _niveau = p.niveau;
        _objectifs.addAll(p.objectifs);
        _avatar = p.avatar;
      }
    }
  }

  void _next() {
    if (_step == 0 && _prenom.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Entre ton prénom pour continuer'),
          backgroundColor: _kGreen,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }
    if (_step < 3) {
      setState(() => _step++);
      _pageCtrl.animateToPage(_step,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut);
    } else {
      _finish();
    }
  }

  void _back() {
    if (_step > 0) {
      setState(() => _step--);
      _pageCtrl.animateToPage(_step,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut);
    }
  }

  Future<void> _finish() async {
    final provider = DeenlyProfileScope.of(context);

    if (widget.editMode && provider.profile != null) {
      // Mode édition : garder la progression (XP, streak, badges…)
      final existing = provider.profile!;
      await provider.save(existing.copyWith(
        prenom: _prenom.trim(),
        age: _age,
        niveau: _niveau,
        objectifs: _objectifs.toList(),
        avatar: _avatar,
      ));
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      // Nouveau profil
      final profile = UserProfile(
        prenom: _prenom.trim(),
        age: _age,
        niveau: _niveau,
        objectifs: _objectifs.toList(),
        dateInscription: DateTime.now(),
        avatar: _avatar,
        xpTotal: 50,
        streak: 1,
        badges: ['premier_pas'],
      );
      await provider.save(profile);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavScreen()),
      );
    }
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      body: SafeArea(
        child: Column(
          children: [
            // ── Progress bar ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                children: [
                  if (_step > 0)
                    GestureDetector(
                      onTap: _back,
                      child: const Icon(Icons.arrow_back_ios_rounded,
                          size: 18, color: _kTxtMd),
                    ),
                  if (_step > 0) const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: List.generate(4, (i) {
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: i <= _step
                                  ? _kGreen
                                  : _kGreen.withOpacity(0.12),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // ── Pages ──
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _StepPrenom(
                    prenom: _prenom,
                    onChanged: (v) => setState(() => _prenom = v),
                  ),
                  _StepAge(
                    age: _age,
                    niveau: _niveau,
                    onAgeChanged: (v) => setState(() => _age = v),
                    onNiveauChanged: (v) => setState(() => _niveau = v),
                  ),
                  _StepObjectifs(
                    selected: _objectifs,
                    onToggle: (g) => setState(() {
                      if (_objectifs.contains(g)) {
                        _objectifs.remove(g);
                      } else {
                        _objectifs.add(g);
                      }
                    }),
                  ),
                  _StepAvatar(
                    selected: _avatar,
                    prenom: _prenom,
                    onChanged: (v) => setState(() => _avatar = v),
                  ),
                ],
              ),
            ),

            // ── Bouton continuer ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: GestureDetector(
                onTap: _next,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [_kGreen, _kGreenMd]),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: _kGreen.withOpacity(0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _step == 3
                            ? (widget.editMode ? 'Enregistrer' : 'Bismillah, c\'est parti !')
                            : 'Continuer',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        _step == 3
                            ? (widget.editMode ? Icons.check_rounded : Icons.rocket_launch_rounded)
                            : Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// ÉTAPE 1 : Prénom
// ══════════════════════════════════════════════════════════════════════
class _StepPrenom extends StatelessWidget {
  final String prenom;
  final ValueChanged<String> onChanged;

  const _StepPrenom({required this.prenom, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('بسم الله الرحمن الرحيم',
              style: TextStyle(fontSize: 22, color: _kGold)),
          const SizedBox(height: 24),
          const Text('Bienvenue sur UpYourDeen',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: _kTxtDk)),
          const SizedBox(height: 8),
          Text('Lumière sur ta foi',
              style: TextStyle(
                  fontSize: 14,
                  color: _kTxtMd.withOpacity(0.6),
                  fontStyle: FontStyle.italic)),
          const SizedBox(height: 48),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Comment tu t\'appelles ?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _kTxtDk)),
          ),
          const SizedBox(height: 12),
          TextField(
            onChanged: onChanged,
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: prenom,
                selection: TextSelection.collapsed(offset: prenom.length),
              ),
            ),
            style: const TextStyle(fontSize: 18, color: _kTxtDk),
            decoration: InputDecoration(
              hintText: 'Ton prénom...',
              hintStyle: TextStyle(color: _kTxtMd.withOpacity(0.35)),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: _kGreen.withOpacity(0.15)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: _kGreen.withOpacity(0.15)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: _kGreen, width: 2),
              ),
              prefixIcon:
                  Icon(Icons.person_rounded, color: _kGreen.withOpacity(0.4)),
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// ÉTAPE 2 : Âge + Niveau
// ══════════════════════════════════════════════════════════════════════
class _StepAge extends StatelessWidget {
  final int age;
  final DeenlyLevel niveau;
  final ValueChanged<int> onAgeChanged;
  final ValueChanged<DeenlyLevel> onNiveauChanged;

  const _StepAge({
    required this.age,
    required this.niveau,
    required this.onAgeChanged,
    required this.onNiveauChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          const Text('Parle-nous de toi',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _kTxtDk)),
          const SizedBox(height: 8),
          Text('Pour adapter le contenu à ton profil',
              style: TextStyle(
                  fontSize: 13, color: _kTxtMd.withOpacity(0.6))),
          const SizedBox(height: 40),

          // Âge
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Ton âge',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _kTxtDk)),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _kGreen.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Text('$age ans',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _kGreen)),
                const Spacer(),
                _ageLabel(age),
              ],
            ),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: _kGreen,
              inactiveTrackColor: _kGreen.withOpacity(0.12),
              thumbColor: _kGold,
              overlayColor: _kGold.withOpacity(0.15),
            ),
            child: Slider(
              value: age.toDouble(),
              min: 6,
              max: 90,
              divisions: 84,
              onChanged: (v) => onAgeChanged(v.round()),
            ),
          ),
          const SizedBox(height: 28),

          // Niveau
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Ton niveau en sciences islamiques',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _kTxtDk)),
          ),
          const SizedBox(height: 12),
          ...DeenlyLevel.values.map((n) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: () => onNiveauChanged(n),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: niveau == n
                          ? _kGreen.withOpacity(0.08)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: niveau == n
                            ? _kGreen
                            : _kGreen.withOpacity(0.12),
                        width: niveau == n ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(_niveauEmoji(n), style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_niveauLabel(n),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: niveau == n
                                          ? _kGreen
                                          : _kTxtDk)),
                              Text(_niveauDesc(n),
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: _kTxtMd.withOpacity(0.6))),
                            ],
                          ),
                        ),
                        if (niveau == n)
                          const Icon(Icons.check_circle_rounded,
                              color: _kGreen, size: 20),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _ageLabel(int a) {
    String label;
    String emoji;
    if (a < 13) {
      label = 'Enfant';
      emoji = '🧒';
    } else if (a < 18) {
      label = 'Adolescent';
      emoji = '🌟';
    } else if (a < 60) {
      label = 'Adulte';
      emoji = '👤';
    } else {
      label = 'Senior';
      emoji = '🤍';
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 4),
        Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _kTxtMd.withOpacity(0.5))),
      ],
    );
  }

  String _niveauEmoji(DeenlyLevel n) {
    switch (n) {
      case DeenlyLevel.debutant:
        return '🌱';
      case DeenlyLevel.intermediaire:
        return '🌿';
      case DeenlyLevel.avance:
        return '🌳';
    }
  }

  String _niveauLabel(DeenlyLevel n) {
    switch (n) {
      case DeenlyLevel.debutant:
        return 'Débutant';
      case DeenlyLevel.intermediaire:
        return 'Intermédiaire';
      case DeenlyLevel.avance:
        return 'Avancé';
    }
  }

  String _niveauDesc(DeenlyLevel n) {
    switch (n) {
      case DeenlyLevel.debutant:
        return 'Je découvre les bases de l\'Islam';
      case DeenlyLevel.intermediaire:
        return 'Je connais les fondements et je veux approfondir';
      case DeenlyLevel.avance:
        return 'Je maîtrise bien les sciences islamiques';
    }
  }
}

// ══════════════════════════════════════════════════════════════════════
// ÉTAPE 3 : Objectifs
// ══════════════════════════════════════════════════════════════════════
class _StepObjectifs extends StatelessWidget {
  final Set<DeenlyGoal> selected;
  final ValueChanged<DeenlyGoal> onToggle;

  const _StepObjectifs({required this.selected, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          const Text('Tes objectifs',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _kTxtDk)),
          const SizedBox(height: 8),
          Text('Choisis ce qui te motive (plusieurs possibles)',
              style: TextStyle(
                  fontSize: 13, color: _kTxtMd.withOpacity(0.6))),
          const SizedBox(height: 32),
          ...DeenlyGoal.values.map((g) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () => onToggle(g),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: selected.contains(g)
                          ? _kGreen.withOpacity(0.08)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected.contains(g)
                            ? _kGreen
                            : _kGreen.withOpacity(0.12),
                        width: selected.contains(g) ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(kGoalEmojis[g]!,
                            style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(kGoalLabels[g]!,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: selected.contains(g)
                                      ? _kGreen
                                      : _kTxtDk)),
                        ),
                        if (selected.contains(g))
                          const Icon(Icons.check_circle_rounded,
                              color: _kGreen, size: 20)
                        else
                          Icon(Icons.circle_outlined,
                              color: _kGreen.withOpacity(0.2), size: 20),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// ÉTAPE 4 : Avatar
// ══════════════════════════════════════════════════════════════════════
class _StepAvatar extends StatelessWidget {
  final String selected;
  final String prenom;
  final ValueChanged<String> onChanged;

  const _StepAvatar({
    required this.selected,
    required this.prenom,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Choisis ton avatar',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _kTxtDk)),
          const SizedBox(height: 8),
          Text('L\'icône qui te représentera dans UpYourDeen',
              style: TextStyle(
                  fontSize: 13, color: _kTxtMd.withOpacity(0.6))),
          const SizedBox(height: 32),

          // Preview
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_kGreen, _kGreenMd]),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: _kGreen.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(selected, style: const TextStyle(fontSize: 38)),
            ),
          ),
          const SizedBox(height: 8),
          Text(prenom,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _kTxtDk)),
          const SizedBox(height: 28),

          // Grid
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: kAvatarOptions.map((a) {
              final isSelected = a == selected;
              return GestureDetector(
                onTap: () => onChanged(a),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _kGreen.withOpacity(0.12)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? _kGreen
                          : _kGreen.withOpacity(0.10),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(a, style: const TextStyle(fontSize: 24)),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
