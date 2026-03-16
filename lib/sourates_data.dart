// sourates_data.dart
// Modèles de données du Coran – Application UpYourDeen
// Les données sont désormais chargées depuis assets/quran.json via SourateRepository.

import 'app_locale.dart';

// ──────────────────────────────────────────────────────────────────────────────
// MODÈLES
// ──────────────────────────────────────────────────────────────────────────────

class Verset {
  final int    numero;
  final String arabe;
  final String phonetique;
  final String francais;
  final String anglais;

  const Verset({
    required this.numero,
    required this.arabe,
    required this.phonetique,
    required this.francais,
    this.anglais = '',
  });

  String get traductionLocale =>
      AppLocale().isFrench ? francais : (anglais.isNotEmpty ? anglais : francais);

  factory Verset.fromJson(Map<String, dynamic> json) => Verset(
    numero:     (json['numero']     as num).toInt(),
    arabe:      json['arabe']       as String? ?? '',
    phonetique: json['phonetique']  as String? ?? '',
    francais:   json['francais']    as String? ?? '',
    anglais:    json['anglais']     as String? ?? '',
  );
}

class Sourate {
  final int          numero;
  final String       nomArabe;
  final String       nomFrancais;
  final String       signification;
  final int          nombreVersets;
  final String       type; // 'mecquoise' ou 'médinoise'
  final List<Verset> versets;

  const Sourate({
    required this.numero,
    required this.nomArabe,
    required this.nomFrancais,
    required this.signification,
    required this.nombreVersets,
    required this.type,
    this.versets = const [],
  });

  factory Sourate.fromJson(Map<String, dynamic> json) => Sourate(
    numero:        (json['numero']        as num).toInt(),
    nomArabe:      json['nomArabe']       as String? ?? '',
    nomFrancais:   json['nomFrancais']    as String? ?? '',
    signification: json['signification']  as String? ?? '',
    nombreVersets: (json['nombreVersets'] as num).toInt(),
    type:          json['type']           as String? ?? '',
    versets: (json['versets'] as List<dynamic>? ?? [])
        .map((v) => Verset.fromJson(v as Map<String, dynamic>))
        .toList(),
  );
}
