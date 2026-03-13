// home_screen.dart — Deenly · Page d'accueil v3

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'quran_screen.dart';
import 'hadith_screen.dart';
import 'journal_screen.dart';
import 'famille_screen.dart';
import 'learning/learning_home_screen.dart';
import 'spiritualite_screen.dart';
import 'protection_screen.dart';
import 'decouvrir_screen.dart';
import 'user_profile.dart';
import 'profile_screen.dart';
import 'notification_data.dart';
import 'notification_service.dart';
import 'settings_screen.dart';
import 'consent_dialog.dart';

// ── Palette ────────────────────────────────────────────────────────────────
const _kGreenDeep    = Color(0xFF0A2018);
const _kGreenPrimary = Color(0xFF1B4D38);
const _kGreenMedium  = Color(0xFF2A7A52);
const _kGold         = Color(0xFFC8933A);
const _kGoldLight    = Color(0xFFE8BF6A);
const _kBeige        = Color(0xFFF6F0E3);
const _kBeigeBorder  = Color(0xFFD6C9AF);
const _kTextDark     = Color(0xFF1A130A);
const _kTextMid      = Color(0xFF5A4833);
const _kTextLight    = Color(0xFF8A7863);
const _kWhite        = Color(0xFFFDFAF4);

// ── Données défi du jour ────────────────────────────────────────────────
const _kDailyDefis = <Map<String, String>>[
  {'emoji': '📖', 'defi': 'Lis 5 versets du Coran', 'xp': '+15 XP'},
  {'emoji': '🤲', 'defi': 'Fais 33 Subhanallah après la prière', 'xp': '+10 XP'},
  {'emoji': '😊', 'defi': 'Souris à 3 personnes aujourd\'hui', 'xp': '+10 XP'},
  {'emoji': '💧', 'defi': 'Fais tes ablutions avec soin', 'xp': '+10 XP'},
  {'emoji': '🕌', 'defi': 'Prie une prière à la mosquée', 'xp': '+20 XP'},
  {'emoji': '📿', 'defi': 'Récite Ayat al-Kursi 3 fois', 'xp': '+15 XP'},
  {'emoji': '🤝', 'defi': 'Rends service à quelqu\'un', 'xp': '+15 XP'},
  {'emoji': '🌙', 'defi': 'Lis les adhkar du soir', 'xp': '+10 XP'},
  {'emoji': '💝', 'defi': 'Fais une Sadaqa, même petite', 'xp': '+20 XP'},
  {'emoji': '📚', 'defi': 'Apprends un nouveau hadith', 'xp': '+15 XP'},
  {'emoji': '🤲', 'defi': 'Fais une du\'a pour tes parents', 'xp': '+10 XP'},
  {'emoji': '🌿', 'defi': 'Dis Astaghfirullah 100 fois', 'xp': '+15 XP'},
];

const _kVersets = <Map<String, String>>[
  {
    'arabe': 'إِنَّ مَعَ الْعُسْرِ يُسْرًا',
    'traduction': '« Certes, avec la difficulté vient la facilité. »',
    'reference': 'Ash-Sharh · 94:6',
  },
  {
    'arabe': 'وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ',
    'traduction': '« Quiconque place sa confiance en Allah, Il lui suffit. »',
    'reference': 'At-Talaq · 65:3',
  },
  {
    'arabe': 'فَاذْكُرُونِي أَذْكُرْكُمْ',
    'traduction': '« Souvenez-vous de Moi, Je Me souviendrai de vous. »',
    'reference': 'Al-Baqara · 2:152',
  },
  {
    'arabe': 'وَلَسَوْفَ يُعْطِيكَ رَبُّكَ فَتَرْضَىٰ',
    'traduction': '« Ton Seigneur t\'accordera tant que tu seras satisfait. »',
    'reference': 'Ad-Duha · 93:5',
  },
  {
    'arabe': 'إِنَّ اللَّهَ مَعَ الصَّابِرِينَ',
    'traduction': '« Allah est avec les patients. »',
    'reference': 'Al-Baqara · 2:153',
  },
  {
    'arabe': 'وَهُوَ مَعَكُمْ أَيْنَ مَا كُنتُمْ',
    'traduction': '« Il est avec vous où que vous soyez. »',
    'reference': 'Al-Hadid · 57:4',
  },
  {
    'arabe': 'رَبِّ اشْرَحْ لِي صَدْرِي',
    'traduction': '« Seigneur, ouvre-moi ma poitrine. »',
    'reference': 'Ta-Ha · 20:25',
  },
];

// ══════════════════════════════════════════════════════════════════════════
// ÉCRAN D'ACCUEIL
// ══════════════════════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _enterCtrl;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;

  final _notifService = NotificationService();
  DeenlyNotif? _currentNotif;
  bool _notifDismissed = false;

  @override
  void initState() {
    super.initState();
    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeIn = CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOut));
    _enterCtrl.forward();
    // Popup consentement analytics au premier lancement
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) showConsentIfNeeded(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadNotification();
  }

  Future<void> _loadNotification() async {
    final provider = DeenlyProfileScope.maybeOf(context);
    final notif = await _notifService.pickNotification(provider?.profile);
    if (mounted && notif != null) {
      setState(() => _currentNotif = notif);
    }
  }

  void _dismissNotif() {
    _notifService.dismiss();
    setState(() => _notifDismissed = true);
  }

  void _navigateToRoute(BuildContext context, String route) {
    Widget? screen;
    switch (route) {
      case 'quran':
        screen = const QuranScreen();
        break;
      case 'learning':
        screen = const LearningHomeScreen();
        break;
      case 'hadith':
        screen = const HadithScreen();
        break;
      case 'spiritualite':
        screen = const SpiritualiteScreen();
        break;
      case 'famille':
        screen = const FamilleScreen();
        break;
    }
    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen!));
    }
  }

  @override
  void dispose() {
    _enterCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dayOfYear =
        DateTime.now().difference(DateTime(2025, 1, 1)).inDays;
    final verset = _kVersets[dayOfYear % _kVersets.length];
    final defi = _kDailyDefis[dayOfYear % _kDailyDefis.length];

    return Scaffold(
      backgroundColor: _kBeige,
      body: FadeTransition(
        opacity: _fadeIn,
        child: SlideTransition(
          position: _slideUp,
          child: CustomScrollView(
        slivers: [
          // ── Header compact ──
          SliverToBoxAdapter(child: _buildHeader(context)),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Notification ami ──
                if (_currentNotif != null && !_notifDismissed)
                  _NotifCard(
                    notif: _currentNotif!,
                    onDismiss: _dismissNotif,
                    onAction: _currentNotif!.actionRoute != null
                        ? () => _navigateToRoute(context, _currentNotif!.actionRoute!)
                        : null,
                  ),
                if (_currentNotif != null && !_notifDismissed)
                  const SizedBox(height: 12),

                // ── Verset du jour ──
                _VersetMini(data: verset),
                const SizedBox(height: 12),

                // ── Défi du jour ──
                _DefiCard(data: defi),
                const SizedBox(height: 20),

                // ── Continuer mon parcours ──
                _ContinueCard(onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const LearningHomeScreen()),
                )),
                const SizedBox(height: 24),

                // ── Accès rapide ──
                const _SectionTitle(
                    title: 'Accès rapide', subtitle: 'Tes outils du quotidien'),
                const SizedBox(height: 12),
                _QuickAccess(context: context),
                const SizedBox(height: 24),

                // ── Tous les modules ──
                const _SectionTitle(
                    title: 'Explorer', subtitle: 'Tous les modules'),
                const SizedBox(height: 12),
                _buildModulesGrid(context),
              ]),
            ),
          ),
        ],
      ),
      ),
      ),
    );
  }

  // ── Header compact premium ─────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kGreenDeep, Color(0xFF122E22)],
        ),
      ),
      child: Stack(children: [
        Positioned.fill(child: CustomPaint(painter: _HeaderBgPainter())),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Builder(builder: (ctx) {
              final provider = DeenlyProfileScope.maybeOf(ctx);
              final profile = provider?.profile;
              return Column(
                children: [
                  // ── Top row : salutation + avatar ──
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile != null
                                  ? '${profile.salutation}, ${profile.prenom}'
                                  : 'السلام عليكم',
                              style: TextStyle(
                                color: Colors.white
                                    .withOpacity(profile != null ? 0.92 : 0.5),
                                fontSize: profile != null ? 18 : 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            if (profile != null)
                              Text(profile.titreNiveau,
                                  style: TextStyle(
                                    color: _kGoldLight.withOpacity(0.55),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ))
                            else
                              Text('Lumière sur ta foi',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 11,
                                    fontStyle: FontStyle.italic,
                                  )),
                          ],
                        ),
                      ),
                      // Logo ديني compact
                      Column(
                        children: [
                          Text('ديني',
                              style: TextStyle(
                                color: _kGold.withOpacity(0.7),
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
                              )),
                        ],
                      ),
                      const SizedBox(width: 14),
                      // Paramètres
                      GestureDetector(
                        onTap: () => Navigator.push(
                            ctx,
                            MaterialPageRoute(
                                builder: (_) => const SettingsScreen())),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.10)),
                          ),
                          child: const Icon(Icons.settings_rounded,
                              color: Colors.white60, size: 18),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Avatar / Profil
                      if (profile != null)
                        GestureDetector(
                          onTap: () => Navigator.push(
                              ctx,
                              MaterialPageRoute(
                                  builder: (_) => const ProfileScreen())),
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                _kGold.withOpacity(0.35),
                                _kGold.withOpacity(0.15),
                              ]),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: _kGold.withOpacity(0.3)),
                            ),
                            child: Center(
                                child: Text(profile.avatar,
                                    style: const TextStyle(fontSize: 20))),
                          ),
                        )
                      else
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.10)),
                          ),
                          child: const Icon(Icons.person_outline_rounded,
                              color: Colors.white38, size: 18),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Stats chips ──
                  Row(children: [
                    _StatChip(
                        icon: '🔥',
                        value: '${profile?.streak ?? 0}',
                        label: 'Série'),
                    const SizedBox(width: 8),
                    _StatChip(
                        icon: '⭐',
                        value: '${profile?.xpTotal ?? 0}',
                        label: 'XP'),
                    const SizedBox(width: 8),
                    _StatChip(
                        icon: '📖',
                        value: '${profile?.versetsLus ?? 0}',
                        label: 'Versets'),
                    const SizedBox(width: 8),
                    _StatChip(
                        icon: '🏆',
                        value: '${profile?.badges.length ?? 0}',
                        label: 'Badges'),
                  ]),
                ],
              );
            }),
          ),
        ),
      ]),
    );
  }

  // ── Grille des modules (3 colonnes, compact) ───────────────────────────
  Widget _buildModulesGrid(BuildContext context) {
    final modules = [
      _ModuleData(
        title: 'Coran',
        assetPath: 'assets/modules/module_coran.jpg',
        colors: [const Color(0xFF0D2820), _kGreenPrimary],
        glow: _kGreenPrimary,
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const QuranScreen())),
      ),
      _ModuleData(
        title: 'Apprentissage',
        assetPath: 'assets/modules/module_learning.jpg',
        colors: [const Color(0xFF4A2006), const Color(0xFFB06028)],
        glow: const Color(0xFFB06028),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const LearningHomeScreen())),
      ),
      _ModuleData(
        title: 'Hadiths',
        assetPath: 'assets/modules/module_hadith.jpg',
        colors: [const Color(0xFF0D1C30), const Color(0xFF1A3C6A)],
        glow: const Color(0xFF1A3C6A),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const HadithScreen())),
      ),
      _ModuleData(
        title: 'Journal',
        assetPath: 'assets/modules/module_journal.jpg',
        colors: [const Color(0xFF281040), const Color(0xFF5A3A8A)],
        glow: const Color(0xFF5A3A8A),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const JournalScreen())),
      ),
      _ModuleData(
        title: 'Spiritualité',
        assetPath: 'assets/modules/module_dhikr.jpg',
        colors: [const Color(0xFF0A1E1E), const Color(0xFF145454)],
        glow: const Color(0xFF145454),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const SpiritualiteScreen())),
      ),
      _ModuleData(
        title: 'Protection',
        assetPath: 'assets/modules/module_protection.jpg',
        colors: [const Color(0xFF1A0A2E), const Color(0xFF2D1B4E)],
        glow: const Color(0xFF5A3A8A),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ProtectionScreen())),
      ),
      _ModuleData(
        title: 'Famille',
        assetPath: 'assets/modules/module_children.jpg',
        colors: [const Color(0xFF0A1830), const Color(0xFF1B2D60)],
        glow: const Color(0xFF1B2D60),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const FamilleScreen())),
      ),
      _ModuleData(
        title: 'Découvrir',
        assetPath: 'assets/modules/module_decouvrir.jpg',
        colors: [const Color(0xFF0A1628), const Color(0xFF1A3A5C)],
        glow: const Color(0xFF2D6A9F),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const DecouvrirScreen())),
      ),
      _ModuleData(
        title: 'Boutique',
        assetPath: 'assets/modules/module_boutique.jpg',
        colors: [const Color(0xFF2A1A0A), const Color(0xFF8B6914)],
        glow: const Color(0xFFC8933A),
        onTap: () => _showComingSoon(context, 'Boutique'),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: modules.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (_, i) => _ModuleCard(data: modules[i]),
    );
  }

  void _showComingSoon(BuildContext context, String module) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Le module "$module" arrive bientôt, إن شاء الله !'),
      backgroundColor: _kGreenPrimary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}

// ══════════════════════════════════════════════════════════════════════════
// WIDGET : Stat chip (header)
// ══════════════════════════════════════════════════════════════════════════
class _StatChip extends StatelessWidget {
  final String icon, value, label;
  const _StatChip(
      {required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(
                  color: _kGoldLight,
                  fontSize: 14,
                  fontWeight: FontWeight.w900)),
          Text(label,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.35),
                  fontSize: 8,
                  fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// WIDGET : Carte de notification (ton meilleur ami)
// ══════════════════════════════════════════════════════════════════════════
class _NotifCard extends StatefulWidget {
  final DeenlyNotif notif;
  final VoidCallback onDismiss;
  final VoidCallback? onAction;
  const _NotifCard({
    required this.notif,
    required this.onDismiss,
    this.onAction,
  });

  @override
  State<_NotifCard> createState() => _NotifCardState();
}

class _NotifCardState extends State<_NotifCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fadeSlide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeSlide = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _dismiss() {
    _ctrl.reverse().then((_) => widget.onDismiss());
  }

  Color get _accentColor {
    switch (widget.notif.type) {
      case NotifType.motivation:
        return _kGreenMedium;
      case NotifType.streak:
        return const Color(0xFFE87D2F);
      case NotifType.bienEtre:
        return const Color(0xFF6B8DD6);
      case NotifType.comeback:
        return const Color(0xFF9B6DC6);
      case NotifType.defiJour:
        return _kGold;
      case NotifType.rappelPriere:
        return _kGreenPrimary;
      case NotifType.sadaqaJariya:
        return const Color(0xFFD4637A);
      case NotifType.celebration:
        return const Color(0xFFE8A820);
    }
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.notif;
    final accent = _accentColor;

    return FadeTransition(
      opacity: _fadeSlide,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.15),
          end: Offset.zero,
        ).animate(_fadeSlide),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent.withOpacity(0.20)),
            boxShadow: [
              BoxShadow(
                color: accent.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header : emoji + titre + close ──
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(n.emoji,
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(n.titre,
                            style: TextStyle(
                              color: _kTextDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            )),
                        const SizedBox(height: 2),
                        Text(_typeLabel(n.type),
                            style: TextStyle(
                              color: accent,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _dismiss,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.close_rounded,
                          size: 14, color: _kTextLight),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ── Message ──
              Text(n.message,
                  style: const TextStyle(
                    color: _kTextMid,
                    fontSize: 12.5,
                    height: 1.6,
                  )),

              // ── Bouton action ──
              if (n.actionLabel != null) ...[
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: () {
                    _dismiss();
                    if (widget.onAction != null) widget.onAction!();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        accent,
                        accent.withOpacity(0.8),
                      ]),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(n.actionLabel!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _typeLabel(NotifType type) {
    switch (type) {
      case NotifType.motivation:
        return 'MOTIVATION';
      case NotifType.streak:
        return 'SÉRIE';
      case NotifType.bienEtre:
        return 'BIEN-ÊTRE';
      case NotifType.comeback:
        return 'BON RETOUR';
      case NotifType.defiJour:
        return 'DÉFI';
      case NotifType.rappelPriere:
        return 'RAPPEL';
      case NotifType.sadaqaJariya:
        return 'SADAQA JARIYA';
      case NotifType.celebration:
        return 'FÉLICITATIONS';
    }
  }
}

// ══════════════════════════════════════════════════════════════════════════
// WIDGET : Verset du jour (version mini)
// ══════════════════════════════════════════════════════════════════════════
class _VersetMini extends StatelessWidget {
  final Map<String, String> data;
  const _VersetMini({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBeigeBorder.withOpacity(0.5)),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tag + référence
          Row(
            children: [
              Container(
                width: 16,
                height: 2,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [_kGold, Colors.transparent]),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              const SizedBox(width: 6),
              const Text('VERSET DU JOUR',
                  style: TextStyle(
                      color: _kGold,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2)),
              const Spacer(),
              Text(data['reference'] ?? '',
                  style: const TextStyle(
                      color: _kTextLight,
                      fontSize: 9,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),

          // Texte arabe
          Text(data['arabe'] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24, color: _kTextDark, height: 1.8)),
          const SizedBox(height: 8),

          // Traduction
          Text(data['traduction'] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: _kTextMid,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  height: 1.4)),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// WIDGET : Défi du jour
// ══════════════════════════════════════════════════════════════════════════
class _DefiCard extends StatefulWidget {
  final Map<String, String> data;
  const _DefiCard({required this.data});

  @override
  State<_DefiCard> createState() => _DefiCardState();
}

class _DefiCardState extends State<_DefiCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (context, child) {
        final glow = 0.10 + 0.06 * _shimmer.value;
        return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _kGold.withOpacity(glow),
            _kGold.withOpacity(glow * 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kGold.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _kGold.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Text(data['emoji'] ?? '✨',
                    style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('DÉFI DU JOUR',
                    style: TextStyle(
                        color: _kGold,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1)),
                const SizedBox(height: 3),
                Text(data['defi'] ?? '',
                    style: const TextStyle(
                        color: _kTextDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _kGold.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(data['xp'] ?? '',
                style: const TextStyle(
                    color: _kGold,
                    fontSize: 11,
                    fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// WIDGET : Continuer mon apprentissage
// ══════════════════════════════════════════════════════════════════════════
class _ContinueCard extends StatefulWidget {
  final VoidCallback onTap;
  const _ContinueCard({required this.onTap});

  @override
  State<_ContinueCard> createState() => _ContinueCardState();
}

class _ContinueCardState extends State<_ContinueCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_kGreenPrimary, _kGreenMedium],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: _kGreenPrimary.withOpacity(0.30),
                blurRadius: 16,
                offset: const Offset(0, 6)),
          ],
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CONTINUER',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.50),
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1)),
                const SizedBox(height: 4),
                const Text('Al-Fatiha · Leçon 4',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                // Barre de progression
                LayoutBuilder(
                    builder: (_, c) => Stack(children: [
                          Container(
                              height: 4,
                              width: c.maxWidth,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(99),
                              )),
                          Container(
                              height: 4,
                              width: c.maxWidth * 0.40,
                              decoration: BoxDecoration(
                                color: _kGoldLight,
                                borderRadius: BorderRadius.circular(99),
                              )),
                        ])),
                const SizedBox(height: 4),
                Text('40 %',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.45), fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.20)),
            ),
            child: const Icon(Icons.play_arrow_rounded,
                color: Colors.white, size: 20),
          ),
        ]),
      ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// WIDGET : Accès rapide (horizontal scroll)
// ══════════════════════════════════════════════════════════════════════════
class _QuickAccess extends StatelessWidget {
  final BuildContext context;
  const _QuickAccess({required this.context});

  @override
  Widget build(BuildContext _) {
    final items = <_QuickItem>[
      _QuickItem('📖', 'Coran', const Color(0xFF1B4D38),
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuranScreen()))),
      _QuickItem('🤲', 'Dhikr', const Color(0xFF145454),
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SpiritualiteScreen()))),
      _QuickItem('🛡️', 'Roqya', const Color(0xFF2D1B4E),
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProtectionScreen()))),
      _QuickItem('💬', 'Assistant', const Color(0xFF1A6B4A),
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DecouvrirScreen()))),
      _QuickItem('✍️', 'Journal', const Color(0xFF5A3A8A),
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const JournalScreen()))),
      _QuickItem('📜', 'Hadiths', const Color(0xFF1A3C6A),
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HadithScreen()))),
    ];

    return SizedBox(
      height: 82,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, i) {
          final it = items[i];
          return _QuickAccessItem(item: it);
        },
      ),
    );
  }
}

class _QuickItem {
  final String emoji, label;
  final Color color;
  final VoidCallback onTap;
  const _QuickItem(this.emoji, this.label, this.color, this.onTap);
}

// ── Quick access item avec animation tap ──
class _QuickAccessItem extends StatefulWidget {
  final _QuickItem item;
  const _QuickAccessItem({required this.item});

  @override
  State<_QuickAccessItem> createState() => _QuickAccessItemState();
}

class _QuickAccessItemState extends State<_QuickAccessItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 180),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final it = widget.item;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        it.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: SizedBox(
          width: 62,
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: it.color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: it.color.withOpacity(0.12)),
                ),
                child: Center(
                    child: Text(it.emoji,
                        style: const TextStyle(fontSize: 24))),
              ),
              const SizedBox(height: 6),
              Text(it.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: _kTextMid,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// WIDGET : Titre de section
// ══════════════════════════════════════════════════════════════════════════
class _SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  const _SectionTitle({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w800, color: _kTextDark)),
      if (subtitle != null)
        Text(subtitle!,
            style: const TextStyle(fontSize: 11, color: _kTextLight)),
    ]);
  }
}

// ══════════════════════════════════════════════════════════════════════════
// DONNÉES MODULE
// ══════════════════════════════════════════════════════════════════════════
class _ModuleData {
  final String title, assetPath;
  final List<Color> colors;
  final Color glow;
  final VoidCallback onTap;

  const _ModuleData({
    required this.title,
    required this.assetPath,
    required this.colors,
    required this.glow,
    required this.onTap,
  });
}

// ══════════════════════════════════════════════════════════════════════════
// WIDGET : Carte module (compact, 3 colonnes) — avec micro-animation tap
// ══════════════════════════════════════════════════════════════════════════
class _ModuleCard extends StatefulWidget {
  final _ModuleData data;
  const _ModuleCard({super.key, required this.data});

  @override
  State<_ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<_ModuleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _ctrl.forward();
  void _onTapUp(TapUpDetails _) {
    _ctrl.reverse();
    widget.data.onTap();
  }

  void _onTapCancel() => _ctrl.reverse();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) => Transform.scale(
        scale: _scale.value,
        child: child,
      ),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Container(
          decoration: BoxDecoration(
            color: widget.data.colors[0],
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: widget.data.glow.withOpacity(0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 5)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(children: [
              // Photo
              Positioned.fill(
                child: Image.asset(
                  widget.data.assetPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: widget.data.colors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),
              // Voile dégradé
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.75),
                        Colors.black.withOpacity(0.15),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
              // Titre
              Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Text(widget.data.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(color: Colors.black54, blurRadius: 6)
                      ],
                    )),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// PAINTER : Fond du header
// ══════════════════════════════════════════════════════════════════════════
class _HeaderBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(7);

    // Étoiles
    for (int i = 0; i < 40; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final r = rng.nextDouble() * 1.2 + 0.3;
      canvas.drawCircle(
          Offset(x, y),
          r,
          Paint()
            ..color = Colors.white
                .withOpacity(rng.nextDouble() * 0.06 + 0.01));
    }

    // Croissant doré petit (haut-droite)
    final mc = Offset(size.width * 0.90, size.height * 0.25);
    final mr = size.width * 0.055;
    final crescent = Path.combine(
      PathOperation.difference,
      Path()..addOval(Rect.fromCircle(center: mc, radius: mr)),
      Path()
        ..addOval(Rect.fromCircle(
            center: Offset(mc.dx + mr * 0.40, mc.dy - mr * 0.08),
            radius: mr * 0.82)),
    );
    canvas.drawPath(crescent, Paint()..color = _kGold.withOpacity(0.20));

    // Arc discret
    final arcP = Paint()
      ..color = Colors.white.withOpacity(0.02)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.width * 0.92, 0),
            width: size.width * 0.50,
            height: size.width * 0.50),
        math.pi * 0.25,
        math.pi * 0.95,
        false,
        arcP);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
