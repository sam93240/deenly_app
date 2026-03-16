// main_nav_screen.dart
// Barre de navigation principale – Application UpYourDeen

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'quran_screen.dart';
import 'hadith_screen.dart';
import 'journal_screen.dart';
import 'learning/learning_home_screen.dart';
import 'translations.dart';

// ── Palette UpYourDeen ──────────────────────────────────────────────────
const _kGreenDeep    = Color(0xFF0A2018);
const _kGold         = Color(0xFFC8933A);
const _kBeige        = Color(0xFFF6F0E3);

// ── Écran principal avec navigation ───────────────────────────────
class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;

  // On conserve les écrans en mémoire pour éviter les rechargements
  static const List<Widget> _screens = [
    HomeScreen(),
    QuranScreen(),
    LearningHomeScreen(),
    HadithScreen(),
    JournalScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _DeenlyBottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

// ── Barre de navigation UpYourDeen ───────────────────────────────────────
class _DeenlyBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _DeenlyBottomNav({required this.currentIndex, required this.onTap});

  static const _items = [
    _NavItem(icon: Icons.home_rounded,        label: 'navHome'),
    _NavItem(icon: Icons.menu_book_rounded,   label: 'navQuran'),
    _NavItem(icon: Icons.school_rounded,      label: 'navLearn'),
    _NavItem(icon: Icons.format_quote_rounded, label: 'navHadith'),
    _NavItem(icon: Icons.book_rounded,        label: 'navJournal'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _kGreenDeep,
        border: Border(top: BorderSide(color: Color(0xFF1B4D38), width: 1)),
        boxShadow: [
          BoxShadow(color: Color(0x40000000), blurRadius: 20, offset: Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_items.length, (i) {
              final selected = i == currentIndex;
              final item = _items[i];

              // Onglet central "Apprendre" légèrement mis en avant
              if (i == 2) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(i),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selected
                                ? _kGold
                                : Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: selected
                                ? [BoxShadow(
                                    color: _kGold.withValues(alpha: 0.4),
                                    blurRadius: 12, offset: const Offset(0, 2))]
                                : [],
                          ),
                          child: Icon(item.icon,
                              color: selected ? Colors.white : Colors.white.withValues(alpha: 0.4),
                              size: 22),
                        ),
                        const SizedBox(height: 3),
                        Text(_getLabelText(context, item.label),
                            style: TextStyle(
                              color: selected ? _kGold : Colors.white.withValues(alpha: 0.35),
                              fontSize: 9,
                              fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                );
              }

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.white.withValues(alpha: 0.12)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(item.icon,
                            color: selected ? Colors.white : Colors.white.withValues(alpha: 0.35),
                            size: 20),
                      ),
                      const SizedBox(height: 2),
                      Text(_getLabelText(context, item.label),
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.white.withValues(alpha: 0.35),
                            fontSize: 9,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                          )),
                      // Indicateur sélection
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(top: 2),
                        width: selected ? 16 : 0,
                        height: 2,
                        decoration: BoxDecoration(
                          color: _kGold,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  String _getLabelText(BuildContext context, String labelKey) {
    switch (labelKey) {
      case 'navHome':
        return context.t.navHome;
      case 'navQuran':
        return context.t.navQuran;
      case 'navLearn':
        return context.t.navLearn;
      case 'navHadith':
        return context.t.navHadith;
      case 'navJournal':
        return context.t.navJournal;
      default:
        return labelKey;
    }
  }
}

class _NavItem {
  final IconData icon;
  final String   label;
  const _NavItem({required this.icon, required this.label});
}
