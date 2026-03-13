// settings_screen.dart
// Écran Paramètres — Application Deenly

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_screen.dart';
import 'main.dart';
import 'user_profile.dart';
import 'onboarding_screen.dart';

// ── Palette ──────────────────────────────────────────────────────────
const _kGreen = Color(0xFF1B4D38);
const _kGold = Color(0xFFC8933A);
const _kBeige = Color(0xFFF6F0E3);
const _kCard = Color(0xFFFDFAF4);
const _kTxtDk = Color(0xFF1A130A);
const _kTxtMd = Color(0xFF5A4833);
const _kTxtLt = Color(0xFF8A7863);

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _analyticsConsent = false;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('deenly_dark_mode') ?? false;
      _analyticsConsent = prefs.getBool('deenly_analytics_consent') ?? false;
      _loaded = true;
    });
  }

  Future<void> _toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('deenly_dark_mode', value);
    setState(() => _darkMode = value);
    // Notifier l'app du changement de thème
    DeenlyApp.of(context)?.setDarkMode(value);
  }

  Future<void> _toggleAnalytics(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('deenly_analytics_consent', value);
    setState(() => _analyticsConsent = value);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : _kBeige;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : _kCard;
    final txtDk = isDark ? Colors.white : _kTxtDk;
    final txtMd = isDark ? Colors.white70 : _kTxtMd;
    final txtLt = isDark ? Colors.white54 : _kTxtLt;
    final divColor = isDark ? Colors.white12 : const Color(0xFFE8DFD0);

    if (!_loaded) {
      return Scaffold(
        backgroundColor: bgColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: _kGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Apparence ──
          _SectionHeader(title: 'Apparence', icon: Icons.palette_rounded, color: txtDk),
          const SizedBox(height: 8),
          _SettingsCard(
            cardColor: cardColor,
            children: [
              _SettingsTile(
                icon: Icons.dark_mode_rounded,
                iconColor: const Color(0xFF5C5CFF),
                title: 'Mode sombre',
                subtitle: 'Repose tes yeux la nuit',
                titleColor: txtDk,
                subtitleColor: txtLt,
                trailing: Switch(
                  value: _darkMode,
                  onChanged: _toggleDarkMode,
                  activeColor: _kGreen,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── Confidentialité ──
          _SectionHeader(title: 'Confidentialité', icon: Icons.shield_rounded, color: txtDk),
          const SizedBox(height: 8),
          _SettingsCard(
            cardColor: cardColor,
            children: [
              _SettingsTile(
                icon: Icons.analytics_rounded,
                iconColor: const Color(0xFF4CAF50),
                title: 'Données d\'usage anonymes',
                subtitle: 'Aide-nous à améliorer Deenly',
                titleColor: txtDk,
                subtitleColor: txtLt,
                trailing: Switch(
                  value: _analyticsConsent,
                  onChanged: _toggleAnalytics,
                  activeColor: _kGreen,
                ),
              ),
              Divider(height: 1, color: divColor, indent: 56),
              _SettingsTile(
                icon: Icons.description_rounded,
                iconColor: _kGold,
                title: 'Politique de confidentialité',
                subtitle: 'Tes données te sont privées',
                titleColor: txtDk,
                subtitleColor: txtLt,
                trailing: Icon(Icons.chevron_right_rounded, color: txtLt),
                onTap: () => _showPrivacyPolicy(context, isDark),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── Compte ──
          _SectionHeader(title: 'Compte', icon: Icons.person_rounded, color: txtDk),
          const SizedBox(height: 8),
          _SettingsCard(
            cardColor: cardColor,
            children: [
              _SettingsTile(
                icon: Icons.edit_rounded,
                iconColor: _kGold,
                title: 'Modifier mon profil',
                subtitle: 'Changer prénom, objectifs, niveau',
                titleColor: txtDk,
                subtitleColor: txtLt,
                trailing: Icon(Icons.chevron_right_rounded, color: txtLt),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OnboardingScreen(editMode: true)),
                ),
              ),
              Divider(height: 1, color: divColor, indent: 56),
              _SettingsTile(
                icon: Icons.delete_outline_rounded,
                iconColor: const Color(0xFFE57373),
                title: 'Réinitialiser le profil',
                subtitle: 'Tout effacer et recommencer',
                titleColor: txtDk,
                subtitleColor: txtLt,
                trailing: Icon(Icons.chevron_right_rounded, color: txtLt),
                onTap: () => _confirmReset(context, isDark),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── À propos ──
          _SectionHeader(title: 'À propos', icon: Icons.info_rounded, color: txtDk),
          const SizedBox(height: 8),
          _SettingsCard(
            cardColor: cardColor,
            children: [
              _SettingsTile(
                icon: Icons.mosque_rounded,
                iconColor: _kGreen,
                title: 'À propos de Deenly',
                subtitle: 'Version, crédits et remerciements',
                titleColor: txtDk,
                subtitleColor: txtLt,
                trailing: Icon(Icons.chevron_right_rounded, color: txtLt),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // ── Version ──
          Center(
            child: Text(
              'Deenly v1.0.0',
              style: TextStyle(fontSize: 12, color: txtLt),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              '© 2026 Deenly. Tous droits réservés.',
              style: TextStyle(fontSize: 11, color: txtLt),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _confirmReset(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Réinitialiser le profil ?',
          style: TextStyle(color: isDark ? Colors.white : _kTxtDk, fontSize: 17, fontWeight: FontWeight.w700)),
        content: Text(
          'Tu vas revenir à l\'écran de bienvenue. Ta progression (XP, série, badges) sera perdue.',
          style: TextStyle(color: isDark ? Colors.white70 : _kTxtMd, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Annuler', style: TextStyle(color: isDark ? Colors.white54 : _kTxtLt)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final provider = DeenlyProfileScope.of(context);
              await provider.deleteProfile();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                  (_) => false,
                );
              }
            },
            child: const Text('Réinitialiser', style: TextStyle(color: Color(0xFFE57373), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context, bool isDark) {
    final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final txtColor = isDark ? Colors.white : _kTxtDk;
    final txtLtColor = isDark ? Colors.white70 : _kTxtMd;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Politique de confidentialité',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: txtColor),
            ),
            const SizedBox(height: 16),
            Text(
              'Dernière mise à jour : Mars 2026',
              style: TextStyle(fontSize: 12, color: txtLtColor),
            ),
            const SizedBox(height: 16),
            _PolicySection(title: 'Données collectées', content:
              'Deenly ne collecte aucune donnée personnelle identifiable. '
              'Si tu actives les données d\'usage anonymes, nous collectons uniquement : '
              'les écrans visités, le temps d\'utilisation, le pays et la langue de l\'appareil, '
              'et les événements d\'utilisation (verset lu, défi complété…). '
              'Ces données sont entièrement anonymes et ne permettent pas de t\'identifier.',
              titleColor: txtColor, contentColor: txtLtColor,
            ),
            _PolicySection(title: 'Stockage local', content:
              'Ton profil, tes préférences et ta progression sont stockés uniquement '
              'sur ton appareil via SharedPreferences. Aucune donnée n\'est envoyée '
              'sur nos serveurs sans ton consentement explicite.',
              titleColor: txtColor, contentColor: txtLtColor,
            ),
            _PolicySection(title: 'Partage de données', content:
              'Nous ne partageons, ne vendons et ne transférons aucune donnée '
              'à des tiers. Jamais. C\'est un engagement.',
              titleColor: txtColor, contentColor: txtLtColor,
            ),
            _PolicySection(title: 'Tes droits', content:
              'Tu peux à tout moment désactiver la collecte de données anonymes '
              'dans les Paramètres. Tu peux aussi supprimer toutes tes données locales '
              'en supprimant l\'application.',
              titleColor: txtColor, contentColor: txtLtColor,
            ),
            _PolicySection(title: 'Contact', content:
              'Pour toute question sur la confidentialité, contacte-nous à :\n'
              'contact@deenly.app',
              titleColor: txtColor, contentColor: txtLtColor,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ── Widgets réutilisables ────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _SectionHeader({required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: _kGold),
          const SizedBox(width: 8),
          Text(title, style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w700, color: color,
            letterSpacing: 0.5,
          )),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  final Color cardColor;

  const _SettingsCard({required this.children, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.subtitleColor,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: titleColor,
                  )),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(
                    fontSize: 11, color: subtitleColor,
                  )),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String content;
  final Color titleColor;
  final Color contentColor;

  const _PolicySection({
    required this.title,
    required this.content,
    required this.titleColor,
    required this.contentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w700, color: titleColor,
          )),
          const SizedBox(height: 6),
          Text(content, style: TextStyle(
            fontSize: 13, color: contentColor, height: 1.5,
          )),
        ],
      ),
    );
  }
}
