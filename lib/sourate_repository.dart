// sourate_repository.dart
// Singleton qui charge le Coran depuis assets/quran.json une seule fois.
// Appeler await SourateRepository.instance.initialize() dans main()
// avant runApp() pour garantir un accès synchrone partout.

import 'dart:convert';
import 'package:flutter/services.dart';
import 'sourates_data.dart';

class SourateRepository {
  SourateRepository._();
  static final SourateRepository instance = SourateRepository._();

  List<Sourate>? _data;

  /// Vérifie si le chargement est terminé.
  bool get isLoaded => _data != null;

  /// Accès synchrone — toujours vide si [initialize()] n'a pas encore terminé.
  List<Sourate> get data => _data ?? const [];

  /// Accès asynchrone — charge le JSON si pas encore fait, puis retourne la liste.
  Future<List<Sourate>> get sourates async {
    if (_data != null) return _data!;
    await initialize();
    return _data!;
  }

  /// Charge [assets/quran.json] et cache le résultat.
  /// Idempotent : plusieurs appels simultanés sont sûrs.
  Future<void> initialize() async {
    if (_data != null) return;
    final jsonStr = await rootBundle.loadString('assets/quran.json');
    final decoded = json.decode(jsonStr) as Map<String, dynamic>;
    _data = (decoded['sourates'] as List<dynamic>)
        .map((s) => Sourate.fromJson(s as Map<String, dynamic>))
        .toList();
  }

  /// Trouve une sourate par son numéro (retourne null si absente).
  Sourate? findByNumber(int numero) {
    try {
      return data.firstWhere((s) => s.numero == numero);
    } catch (_) {
      return null;
    }
  }
}
