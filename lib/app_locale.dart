// app_locale.dart
// Service de gestion de la langue (FR / EN)
// Utilise SharedPreferences pour persister le choix

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Langues supportées
enum AppLanguage { fr, en, ar }

/// Service singleton pour la gestion de la langue
class AppLocale extends ChangeNotifier {
  static final AppLocale _instance = AppLocale._internal();
  factory AppLocale() => _instance;
  AppLocale._internal();

  AppLanguage _language = AppLanguage.fr;
  bool _loaded = false;
  bool _languageSelected = false;

  AppLanguage get language => _language;
  bool get loaded => _loaded;
  bool get languageSelected => _languageSelected;
  bool get isFrench => _language == AppLanguage.fr;
  bool get isEnglish => _language == AppLanguage.en;
  bool get isArabic => _language == AppLanguage.ar;

  /// Charge la langue sauvegardée
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('app_language') ?? 'fr';
    _language = code == 'en'
        ? AppLanguage.en
        : code == 'ar'
            ? AppLanguage.ar
            : AppLanguage.fr;
    _languageSelected = prefs.getBool('deenly_language_selected') ?? false;
    _loaded = true;
    notifyListeners();
  }

  /// Change la langue et persiste le choix
  Future<void> setLanguage(AppLanguage lang) async {
    _language = lang;
    _languageSelected = true;
    final prefs = await SharedPreferences.getInstance();
    final code = switch (lang) {
      AppLanguage.en => 'en',
      AppLanguage.ar => 'ar',
      AppLanguage.fr => 'fr',
    };
    await prefs.setString('app_language', code);
    await prefs.setBool('deenly_language_selected', true);
    notifyListeners();
  }

  /// Raccourci : retourne le texte FR, EN ou AR selon la langue active
  /// Le paramètre [ar] est optionnel — si absent, on retourne [fr] en arabe.
  String tr(String fr, String en, [String? ar]) {
    return switch (_language) {
      AppLanguage.fr => fr,
      AppLanguage.en => en,
      AppLanguage.ar => ar ?? fr,
    };
  }
}

/// InheritedWidget pour accéder à AppLocale dans l'arbre
class AppLocaleScope extends InheritedNotifier<AppLocale> {
  const AppLocaleScope({
    super.key,
    required AppLocale locale,
    required super.child,
  }) : super(notifier: locale);

  static AppLocale of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppLocaleScope>();
    return scope!.notifier!;
  }
}

/// Extension pratique sur BuildContext
extension AppLocaleExtension on BuildContext {
  AppLocale get locale => AppLocaleScope.of(this);
  String tr(String fr, String en) => AppLocaleScope.of(this).tr(fr, en);
}
