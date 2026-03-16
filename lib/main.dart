// main.dart
// Application UpYourDeen : Lumière sur ta foi
// Framework : Flutter | Langage : Dart

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'main_nav_screen.dart';
import 'user_profile.dart';
import 'onboarding_screen.dart';
import 'splash_screen.dart';
import 'app_locale.dart';
import 'language_selection_screen.dart';
import 'sourate_repository.dart';
import 'hadith_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Charger la locale AVANT runApp pour éviter la race condition ──────
  // Sans ça, _locale.load() peut se terminer après le premier build du
  // SplashScreen et changer widget.nextScreen, sautant l'écran de langue.
  await AppLocale().load();

  // ── Firebase et assets JSON — chargement en arrière-plan ─────────────
  // Sur web : Firebase n'est pas configuré → on évite complètement l'init.
  if (!kIsWeb) {
    () async {
      try {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);
      } catch (e) {
        debugPrint('⚠️ Firebase: $e');
      }
    }();
  }

  SourateRepository.instance.initialize();
  HadithRepository.instance.initialize();

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
  final _locale = AppLocale();
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _profileProvider.load();
    _locale.load();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('deenly_dark_mode') ?? false;
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
    return AppLocaleScope(
      locale: _locale,
      child: DeenlyProfileScope(
        provider: _profileProvider,
        child: ListenableBuilder(
          listenable: Listenable.merge([_profileProvider, _locale]),
          builder: (context, _) {
            return MaterialApp(
              title: _locale.tr('UpYourDeen – Élève ta foi', 'UpYourDeen – Elevate your faith'),
              debugShowCheckedModeBanner: false,
              theme: _lightTheme,
              darkTheme: _darkTheme,
              themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: _buildHome(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHome() {
    // Attendre que la locale soit chargée avant de décider de l'écran suivant.
    // (Sécurité supplémentaire — la locale est déjà pré-chargée dans main().)
    if (!_locale.loaded) {
      return const Scaffold(backgroundColor: Color(0xFF0A2018));
    }

    // Destination finale selon le profil
    final destination = _profileProvider.hasProfile
        ? const MainNavScreen()
        : const OnboardingScreen();

    // Si la langue n'a pas encore été choisie → on insère l'écran de sélection
    final nextAfterSplash = _locale.languageSelected
        ? destination
        : LanguageSelectionScreen(nextScreen: destination);

    return SplashScreen(nextScreen: nextAfterSplash);
  }
}
