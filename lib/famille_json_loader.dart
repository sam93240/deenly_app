// famille_json_loader.dart — Chargement des histoires depuis les assets JSON

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'famille_data.dart';

class FamilleJsonLoader {
  FamilleJsonLoader._();

  // ── Cache en mémoire ──────────────────────────────────────────────────────
  static List<Prophet>?       _prophets;
  static List<CoranicStory>?  _coranicStories;
  static List<BedtimeStory>?  _bedtimeStories;
  static List<HadithStory>?   _hadithStories;

  // ── Prophètes ─────────────────────────────────────────────────────────────
  static Future<List<Prophet>> loadProphets() async {
    if (_prophets != null) return _prophets!;
    final raw = await rootBundle.loadString('assets/data/histoires_prophetes.json');
    final list = json.decode(raw) as List;
    _prophets = list.map((e) => Prophet.fromJson(e as Map<String, dynamic>)).toList();
    return _prophets!;
  }

  // ── Histoires coraniques ──────────────────────────────────────────────────
  static Future<List<CoranicStory>> loadCoranicStories() async {
    if (_coranicStories != null) return _coranicStories!;
    final raw = await rootBundle.loadString('assets/data/histoires_coraniques.json');
    final list = json.decode(raw) as List;
    _coranicStories = list.map((e) => CoranicStory.fromJson(e as Map<String, dynamic>)).toList();
    return _coranicStories!;
  }

  // ── Histoires du soir ─────────────────────────────────────────────────────
  static Future<List<BedtimeStory>> loadBedtimeStories() async {
    if (_bedtimeStories != null) return _bedtimeStories!;
    final raw = await rootBundle.loadString('assets/data/histoires_bonsoir.json');
    final list = json.decode(raw) as List;
    _bedtimeStories = list.map((e) => BedtimeStory.fromJson(e as Map<String, dynamic>)).toList();
    return _bedtimeStories!;
  }

  // ── Histoires du Prophète ﷺ (hadiths) ────────────────────────────────────
  static Future<List<HadithStory>> loadHadithStories() async {
    if (_hadithStories != null) return _hadithStories!;
    final raw = await rootBundle.loadString('assets/data/histoires_hadith.json');
    final list = json.decode(raw) as List;
    _hadithStories = list.map((e) => HadithStory.fromJson(e as Map<String, dynamic>)).toList();
    return _hadithStories!;
  }

  // ── Préchargement au démarrage ────────────────────────────────────────────
  static Future<void> preloadAll() async {
    await Future.wait([
      loadProphets(),
      loadCoranicStories(),
      loadBedtimeStories(),
      loadHadithStories(),
    ]);
  }

  // ── Getters synchrones (disponibles après preloadAll) ────────────────────
  // Utilisés dans l'UI — retournent la liste vide si pas encore chargée
  static List<Prophet>      get prophets       => _prophets       ?? const [];
  static List<CoranicStory> get coranicStories => _coranicStories ?? const [];
  static List<BedtimeStory> get bedtimeStories => _bedtimeStories ?? const [];
  static List<HadithStory>  get hadithStories  => _hadithStories  ?? const [];

  // ── Invalider le cache (utile pour les tests) ─────────────────────────────
  static void clearCache() {
    _prophets       = null;
    _coranicStories = null;
    _bedtimeStories = null;
    _hadithStories  = null;
  }
}
