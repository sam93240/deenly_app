// translation_helpers.dart
// Utility functions for translating data-driven UI strings
// Uses AppLocale().tr() for inline translations in const data

import 'app_locale.dart';

/// Helper to translate title strings in const data structures
/// Usage: translateTitle('Prières obligatoires', 'Obligatory Prayers')
String translateTitle(String fr, String en) => AppLocale().tr(fr, en);

/// Translate a string key based on current locale
/// Usage for titles in data structures that can't use context
String tStr(String fr, String en) => AppLocale().tr(fr, en);

/// Bilingual formatter for display labels with both languages
/// Returns "FR / EN" format or just the appropriate language
String bilingualLabel(String fr, String en) {
  if (AppLocale().isFrench) {
    return fr;
  } else {
    return en;
  }
}

/// Extract French part from bilingual string (format: "Fr / En")
String extractFrench(String bilingual) {
  return bilingual.split(' / ').first;
}

/// Extract English part from bilingual string (format: "Fr / En")
String extractEnglish(String bilingual) {
  final parts = bilingual.split(' / ');
  return parts.length > 1 ? parts.last : '';
}

/// Get display label based on current locale from bilingual string
String getLocalizedLabel(String bilingualStr) {
  if (AppLocale().isFrench) {
    return extractFrench(bilingualStr);
  } else {
    return extractEnglish(bilingualStr);
  }
}
