// hadith_repository.dart
// Singleton qui charge les hadiths depuis assets/hadiths.json une seule fois.
// Appeler await HadithRepository.instance.initialize() dans main()
// avant runApp() pour garantir un accès synchrone partout.

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'app_locale.dart';

// ──────────────────────────────────────────────────────────────────────────────
// MODÈLE
// ──────────────────────────────────────────────────────────────────────────────

class HadithModel {
  final String arabe;
  final String traduction;
  final String traductionEn;
  final String narrateur;
  final String source;
  final String phonetique;
  final String categorie;
  final String explication;
  final String explicationEn;
  final String applicationQuotidienne;
  final String applicationQuotidienneEn;

  const HadithModel({
    required this.arabe,
    required this.traduction,
    required this.traductionEn,
    required this.narrateur,
    required this.source,
    required this.phonetique,
    required this.categorie,
    required this.explication,
    required this.explicationEn,
    required this.applicationQuotidienne,
    required this.applicationQuotidienneEn,
  });

  String get traductionLocale   => AppLocale().isFrench ? traduction          : traductionEn;
  String get explicationLocale  => AppLocale().isFrench ? explication         : explicationEn;
  String get applicationLocale  => AppLocale().isFrench ? applicationQuotidienne : applicationQuotidienneEn;

  factory HadithModel.fromJson(Map<String, dynamic> json) => HadithModel(
    arabe:                    json['arabe']                    as String? ?? '',
    traduction:               json['traduction']               as String? ?? '',
    traductionEn:             json['traductionEn']             as String? ?? '',
    narrateur:                json['narrateur']                as String? ?? '',
    source:                   json['source']                   as String? ?? '',
    phonetique:               json['phonetique']               as String? ?? '',
    categorie:                json['categorie']                as String? ?? '',
    explication:              json['explication']              as String? ?? '',
    explicationEn:            json['explicationEn']            as String? ?? '',
    applicationQuotidienne:   json['applicationQuotidienne']   as String? ?? '',
    applicationQuotidienneEn: json['applicationQuotidienneEn'] as String? ?? '',
  );
}

// ──────────────────────────────────────────────────────────────────────────────
// REPOSITORY
// ──────────────────────────────────────────────────────────────────────────────

class HadithRepository {
  HadithRepository._();
  static final HadithRepository instance = HadithRepository._();

  List<HadithModel>? _data;
  List<String>?      _categories;

  bool get isLoaded => _data != null;

  /// Accès synchrone à la liste des hadiths (vide si pas encore chargé).
  List<HadithModel> get data => _data ?? const [];

  /// Accès synchrone aux catégories (vide si pas encore chargé).
  List<String> get categories => _categories ?? const [];

  /// Accès asynchrone — charge le JSON si nécessaire.
  Future<List<HadithModel>> get hadiths async {
    if (_data != null) return _data!;
    await initialize();
    return _data!;
  }

  /// Charge [assets/hadiths.json] et cache le résultat. Idempotent.
  Future<void> initialize() async {
    if (_data != null) return;
    final jsonStr = await rootBundle.loadString('assets/hadiths.json');
    final decoded = json.decode(jsonStr) as Map<String, dynamic>;
    _data = (decoded['hadiths'] as List<dynamic>)
        .map((h) => HadithModel.fromJson(h as Map<String, dynamic>))
        .toList();
    _categories = (decoded['categories'] as List<dynamic>? ?? [])
        .map((c) => c as String)
        .toList();
  }

  /// Catégories localisées (traduit 'Tous' en EN, le reste reste identique).
  List<String> localizedCategories(BuildContext context) {
    return categories.map((c) {
      if (c == 'Tous') return AppLocale().isFrench ? 'Tous' : 'All';
      return c;
    }).toList();
  }
}
