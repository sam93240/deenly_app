// profile_screen.dart
// Écran de profil utilisateur — Application UpYourDeen

import 'package:flutter/material.dart';
import 'user_profile.dart';
import 'onboarding_screen.dart';

// ── Palette ──────────────────────────────────────────────────────────
const _kGreen = Color(0xFF1B4D38);
const _kGreenDk = Color(0xFF0A2018);
const _kGreenMd = Color(0xFF2A7A52);
const _kGold = Color(0xFFC8933A);
const _kGoldLt = Color(0xFFE8BF6A);
const _kBeige = Color(0xFFF6F0E3);
const _kCard = Color(0xFFFDFAF4);
const _kTxtDk = Color(0xFF1A130A);
const _kTxtMd = Color(0xFF5A4833);
const _kTxtLt = Color(0xFF8A7863);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = DeenlyProfileScope.of(context);
    final profile = provider.profile;

    if (profile == null) {
      return const Scaffold(
        backgroundColor: _kBeige,
        body: Center(child: Text('Aucun profil')),
      );
    }

    return Scaffold(
      backgroundColor: _kBeige,
      body: CustomScrollView(
        slivers: [
          // ── Header profil ──
          SliverToBoxAdapter(child: _ProfileHeader(profile: profile)),
          // ── Stats ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: _StatsSection(profile: profile),
            ),
          ),
          // ── Badges ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: _BadgesSection(profile: profile),
            ),
          ),
          // ── Objectifs ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: _ObjectifsSection(profile: profile),
            ),
          ),
          // ── Paramètres ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: _SettingsSection(profile: profile),
            ),
          ),
          // ── Bouton modifier / supprimer ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
              child: Column(
                children: [
                  _ActionButton(
                    icon: Icons.edit_rounded,
                    label: 'Modifier mon profil',
                    color: _kGreen,
                    onTap: () => _showEditSheet(context, provider, profile),
                  ),
                  const SizedBox(height: 10),
                  _ActionButton(
                    icon: Icons.logout_rounded,
                    label: 'Réinitialiser le profil',
                    color: Colors.red.shade400,
                    onTap: () => _confirmReset(context, provider),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditSheet(
      BuildContext context, UserProfileProvider provider, UserProfile profile) {
    String prenom = profile.prenom;
    int age = profile.age;
    DeenlyLevel niveau = profile.niveau;
    String avatar = profile.avatar;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _kBeige,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => Padding(
          padding: EdgeInsets.fromLTRB(
              24, 20, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _kTxtLt.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Modifier mon profil',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _kTxtDk)),
              const SizedBox(height: 20),

              // Prénom
              TextField(
                controller: TextEditingController(text: prenom),
                onChanged: (v) => prenom = v,
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: _kGreen.withOpacity(0.15)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Âge slider
              Row(
                children: [
                  Text('Âge : $age ans',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: _kTxtDk)),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: _kGreen,
                  inactiveTrackColor: _kGreen.withOpacity(0.12),
                  thumbColor: _kGold,
                ),
                child: Slider(
                  value: age.toDouble(),
                  min: 6,
                  max: 90,
                  divisions: 84,
                  onChanged: (v) => setLocal(() => age = v.round()),
                ),
              ),
              const SizedBox(height: 12),

              // Avatar
              const Text('Avatar',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: _kTxtDk)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: kAvatarOptions.map((a) {
                  final sel = a == avatar;
                  return GestureDetector(
                    onTap: () => setLocal(() => avatar = a),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: sel
                            ? _kGreen.withOpacity(0.12)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: sel ? _kGreen : _kGreen.withOpacity(0.1),
                          width: sel ? 2 : 1,
                        ),
                      ),
                      child: Center(
                          child:
                              Text(a, style: const TextStyle(fontSize: 20))),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Sauvegarder
              GestureDetector(
                onTap: () async {
                  await provider.updateProfile(
                    prenom: prenom.trim(),
                    age: age,
                    niveau: niveau,
                    avatar: avatar,
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [_kGreen, _kGreenMd]),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Text('Sauvegarder',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context, UserProfileProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _kBeige,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Réinitialiser le profil ?',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text(
            'Toutes tes données (XP, badges, progression) seront perdues.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler', style: TextStyle(color: _kTxtMd)),
          ),
          TextButton(
            onPressed: () async {
              await provider.deleteProfile();
              if (ctx.mounted) Navigator.pop(ctx);
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const OnboardingScreen()),
                  (route) => false,
                );
              }
            },
            child: Text('Réinitialiser',
                style: TextStyle(color: Colors.red.shade400)),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// HEADER PROFIL
// ══════════════════════════════════════════════════════════════════════
class _ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kGreenDk, Color(0xFF122E22)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
          child: Column(
            children: [
              // Top bar
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white70, size: 18),
                  ),
                  const Spacer(),
                  Text('Mon Profil',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1)),
                  const Spacer(),
                  const SizedBox(width: 18),
                ],
              ),
              const SizedBox(height: 24),

              // Avatar
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [_kGold, _kGoldLt]),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: _kGold.withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(profile.avatar,
                      style: const TextStyle(fontSize: 34)),
                ),
              ),
              const SizedBox(height: 14),

              // Nom + titre
              Text(profile.prenom,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _kGold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(profile.titreNiveau,
                    style: const TextStyle(
                        color: _kGoldLt,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 6),
              Text('${profile.niveauLabel} · ${profile.age} ans',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// STATISTIQUES
// ══════════════════════════════════════════════════════════════════════
class _StatsSection extends StatelessWidget {
  final UserProfile profile;
  const _StatsSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mes statistiques',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: _kTxtDk)),
        const SizedBox(height: 12),
        Row(
          children: [
            _StatCard(
                emoji: '🔥',
                value: '${profile.streak}',
                label: 'Jours de suite',
                color: const Color(0xFFFF6B35)),
            const SizedBox(width: 10),
            _StatCard(
                emoji: '⭐',
                value: '${profile.xpTotal}',
                label: 'XP Total',
                color: _kGold),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _StatCard(
                emoji: '📖',
                value: '${profile.versetsLus}',
                label: 'Versets lus',
                color: _kGreen),
            const SizedBox(width: 10),
            _StatCard(
                emoji: '🏆',
                value: '${profile.badges.length}',
                label: 'Badges',
                color: const Color(0xFF6B4CE6)),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String emoji, value, label;
  final Color color;
  const _StatCard({
    required this.emoji,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.12)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child:
                  Center(child: Text(emoji, style: const TextStyle(fontSize: 18))),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: color)),
                Text(label,
                    style: TextStyle(
                        fontSize: 10,
                        color: _kTxtMd.withOpacity(0.5))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// BADGES
// ══════════════════════════════════════════════════════════════════════
class _BadgesSection extends StatelessWidget {
  final UserProfile profile;
  const _BadgesSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Mes badges',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: _kTxtDk)),
            const Spacer(),
            Text('${profile.badges.length}/${kBadgeDefinitions.length}',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _kGold)),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: kBadgeDefinitions.entries.map((e) {
            final unlocked = profile.badges.contains(e.key);
            final data = e.value;
            return Container(
              width: 100,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: unlocked ? _kCard : _kCard.withOpacity(0.5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: unlocked
                      ? _kGold.withOpacity(0.3)
                      : _kTxtLt.withOpacity(0.1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    unlocked ? data['emoji']! : '🔒',
                    style: TextStyle(
                      fontSize: 24,
                      color: unlocked ? null : Colors.grey.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data['titre']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: unlocked ? _kTxtDk : _kTxtLt.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data['desc']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8,
                      color: unlocked
                          ? _kTxtMd.withOpacity(0.5)
                          : _kTxtLt.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// OBJECTIFS
// ══════════════════════════════════════════════════════════════════════
class _ObjectifsSection extends StatelessWidget {
  final UserProfile profile;
  const _ObjectifsSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile.objectifs.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mes objectifs',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: _kTxtDk)),
        const SizedBox(height: 12),
        ...profile.objectifs.map((g) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: _kCard,
                  borderRadius: BorderRadius.circular(14),
                  border:
                      Border.all(color: _kGreen.withOpacity(0.10)),
                ),
                child: Row(
                  children: [
                    Text(kGoalEmojis[g] ?? '🎯',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(kGoalLabels[g] ?? '',
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _kTxtDk)),
                    ),
                    Icon(Icons.check_circle_rounded,
                        color: _kGreen.withOpacity(0.4), size: 18),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// PARAMÈTRES
// ══════════════════════════════════════════════════════════════════════
class _SettingsSection extends StatelessWidget {
  final UserProfile profile;
  const _SettingsSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Informations',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: _kTxtDk)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kGreen.withOpacity(0.08)),
          ),
          child: Column(
            children: [
              _InfoRow(
                  icon: Icons.calendar_today_rounded,
                  label: 'Membre depuis',
                  value: _formatDate(profile.dateInscription)),
              const Divider(height: 20),
              _InfoRow(
                  icon: Icons.school_rounded,
                  label: 'Niveau',
                  value: profile.niveauLabel),
              const Divider(height: 20),
              _InfoRow(
                  icon: Icons.cake_rounded,
                  label: 'Âge',
                  value: '${profile.age} ans'),
              const Divider(height: 20),
              _InfoRow(
                  icon: Icons.emoji_events_rounded,
                  label: 'Titre',
                  value: profile.titreNiveau),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime d) {
    const mois = [
      '', 'jan.', 'fév.', 'mars', 'avr.', 'mai', 'juin',
      'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.'
    ];
    return '${d.day} ${mois[d.month]} ${d.year}';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _InfoRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: _kGreen.withOpacity(0.5)),
        const SizedBox(width: 10),
        Text(label,
            style: TextStyle(
                fontSize: 13, color: _kTxtMd.withOpacity(0.6))),
        const Spacer(),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _kTxtDk)),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// BOUTON ACTION
// ══════════════════════════════════════════════════════════════════════
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
      ),
    );
  }
}
