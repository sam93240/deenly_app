// main.dart
// Application Deenly : Lumière sur ta foi
// Framework : Flutter | Langage : Dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_nav_screen.dart';
import 'user_profile.dart';
import 'onboarding_screen.dart';
import 'splash_screen.dart';

void main() {
  runApp(const DeenlyApp());
}

class DeenlyApp extends StatefulWidget {
  const DeenlyApp({super.key});

  /// Permet aux enfants d'accéder à l'état de l'app pour changer le thème
  static _DeenlyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_DeenlyAppState>();
  }

  @override
  State<DeenlyApp> createState() => _DeenlyAppState();
}

class _DeenlyAppState extends State<DeenlyApp> {
  final _profileProvider = UserProfileProvider();
  bool _isDarkMode = false;
  bool _themeLoaded = false;

  @override
  void initState() {
    super.initState();
    _profileProvider.load();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('deenly_dark_mode') ?? false;
      _themeLoaded = true;
    });
  }

  void setDarkMode(bool value) {
    setState(() => _isDarkMode = value);
  }

  // ── Thème clair ──
  ThemeData get _lightTheme => ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1B4D38),
      brightness: Brightness.light,
      primary: const Color(0xFF1B4D38),
      secondary: const Color(0xFFC8933A),
      surface: const Color(0xFFF6F0E3),
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF6F0E3),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1B4D38),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1B4D38),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? const Color(0xFF1B4D38)
            : null,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? const Color(0xFF2A7A52)
            : null,
      ),
    ),
  );

  // ── Thème sombre ──
  ThemeData get _darkTheme => ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1B4D38),
      brightness: Brightness.dark,
      primary: const Color(0xFF2A7A52),
      secondary: const Color(0xFFC8933A),
      surface: const Color(0xFF121212),
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0A2018),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2A7A52),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? const Color(0xFF2A7A52)
            : null,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? const Color(0xFF1B4D38)
            : null,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DeenlyProfileScope(
      provider: _profileProvider,
      child: ListenableBuilder(
        listenable: _profileProvider,
        builder: (context, _) {
          return MaterialApp(
            title: 'Deenly – Lumière sur ta foi',
            debugShowCheckedModeBanner: false,
            theme: _lightTheme,
            darkTheme: _darkTheme,
            themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: _buildHome(),
          );
        },
      ),
    );
  }

  Widget _buildHome() {
    if (!_profileProvider.loaded) {
      return SplashScreen(
        nextScreen: _profileProvider.hasProfile
            ? const MainNavScreen()
            : const OnboardingScreen(),
      );
    }

    if (!_profileProvider.hasProfile) {
      return SplashScreen(nextScreen: const OnboardingScreen());
    }

    return SplashScreen(nextScreen: const MainNavScreen());
  }
}
