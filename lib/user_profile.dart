// user_profile.dart
// Système de profil utilisateur — Application Deenly

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Enums ────────────────────────────────────────────────────────────

enum DeenlyLevel { debutant, intermediaire, avance }

enum DeenlyAgeGroup { enfant, ado, adulte, senior }

enum DeenlyGoal {
  memoriserCoran,
  apprendrePriere,
  comprendreIslam,
  eduquerEnfants,
  spiritualite,
  communaute,
}

// ── Modèle Profil ────────────────────────────────────────────────────

class UserProfile {
  final String prenom;
  final int age;
  final DeenlyLevel niveau;
  final List<DeenlyGoal> objectifs;
  final int streak;
  final int xpTotal;
  final int versetsLus;
  final int joursActif;
  final List<String> badges;
  final DateTime dateInscription;
  final String avatar;

  const UserProfile({
    required this.prenom,
    required this.age,
    this.niveau = DeenlyLevel.debutant,
    this.objectifs = const [],
    this.streak = 0,
    this.xpTotal = 0,
    this.versetsLus = 0,
    this.joursActif = 0,
    this.badges = const [],
    required this.dateInscription,
    this.avatar = '🌙',
  });

  DeenlyAgeGroup get ageGroup {
    if (age < 13) return DeenlyAgeGroup.enfant;
    if (age < 18) return DeenlyAgeGroup.ado;
    if (age < 60) return DeenlyAgeGroup.adulte;
    return DeenlyAgeGroup.senior;
  }

  String get niveauLabel {
    switch (niveau) {
      case DeenlyLevel.debutant:
        return 'Débutant';
      case DeenlyLevel.intermediaire:
        return 'Intermédiaire';
      case DeenlyLevel.avance:
        return 'Avancé';
    }
  }

  String get salutation {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'As-salamu alaykum';
    if (hour < 12) return 'Sabah al-khayr';
    if (hour < 18) return 'As-salamu alaykum';
    return 'Masa\' al-khayr';
  }

  String get titreNiveau {
    if (xpTotal < 500) return 'Chercheur de lumière';
    if (xpTotal < 1500) return 'Étoile montante';
    if (xpTotal < 3000) return 'Compagnon de savoir';
    if (xpTotal < 6000) return 'Flambeau de la foi';
    return 'Phare de guidance';
  }

  UserProfile copyWith({
    String? prenom,
    int? age,
    DeenlyLevel? niveau,
    List<DeenlyGoal>? objectifs,
    int? streak,
    int? xpTotal,
    int? versetsLus,
    int? joursActif,
    List<String>? badges,
    DateTime? dateInscription,
    String? avatar,
  }) {
    return UserProfile(
      prenom: prenom ?? this.prenom,
      age: age ?? this.age,
      niveau: niveau ?? this.niveau,
      objectifs: objectifs ?? this.objectifs,
      streak: streak ?? this.streak,
      xpTotal: xpTotal ?? this.xpTotal,
      versetsLus: versetsLus ?? this.versetsLus,
      joursActif: joursActif ?? this.joursActif,
      badges: badges ?? this.badges,
      dateInscription: dateInscription ?? this.dateInscription,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toJson() => {
        'prenom': prenom,
        'age': age,
        'niveau': niveau.index,
        'objectifs': objectifs.map((o) => o.index).toList(),
        'streak': streak,
        'xpTotal': xpTotal,
        'versetsLus': versetsLus,
        'joursActif': joursActif,
        'badges': badges,
        'dateInscription': dateInscription.toIso8601String(),
        'avatar': avatar,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      prenom: json['prenom'] as String,
      age: json['age'] as int,
      niveau: DeenlyLevel.values[json['niveau'] as int],
      objectifs: (json['objectifs'] as List)
          .map((i) => DeenlyGoal.values[i as int])
          .toList(),
      streak: json['streak'] as int? ?? 0,
      xpTotal: json['xpTotal'] as int? ?? 0,
      versetsLus: json['versetsLus'] as int? ?? 0,
      joursActif: json['joursActif'] as int? ?? 0,
      badges:
          (json['badges'] as List?)?.map((b) => b as String).toList() ?? [],
      dateInscription: DateTime.parse(json['dateInscription'] as String),
      avatar: json['avatar'] as String? ?? '🌙',
    );
  }
}

// ── Provider (InheritedWidget + ChangeNotifier) ──────────────────────

class UserProfileProvider extends ChangeNotifier {
  UserProfile? _profile;
  bool _loaded = false;

  UserProfile? get profile => _profile;
  bool get loaded => _loaded;
  bool get hasProfile => _profile != null;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('deenly_user_profile');
    if (raw != null) {
      try {
        _profile = UserProfile.fromJson(
            json.decode(raw) as Map<String, dynamic>);
      } catch (_) {
        _profile = null;
      }
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> save(UserProfile p) async {
    _profile = p;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('deenly_user_profile', json.encode(p.toJson()));
    notifyListeners();
  }

  Future<void> addXP(int xp) async {
    if (_profile == null) return;
    await save(_profile!.copyWith(xpTotal: _profile!.xpTotal + xp));
  }

  Future<void> incrementStreak() async {
    if (_profile == null) return;
    await save(_profile!.copyWith(streak: _profile!.streak + 1));
  }

  Future<void> addBadge(String badge) async {
    if (_profile == null) return;
    if (_profile!.badges.contains(badge)) return;
    await save(
        _profile!.copyWith(badges: [..._profile!.badges, badge]));
  }

  Future<void> updateProfile({
    String? prenom,
    int? age,
    DeenlyLevel? niveau,
    List<DeenlyGoal>? objectifs,
    String? avatar,
  }) async {
    if (_profile == null) return;
    await save(_profile!.copyWith(
      prenom: prenom,
      age: age,
      niveau: niveau,
      objectifs: objectifs,
      avatar: avatar,
    ));
  }

  Future<void> deleteProfile() async {
    _profile = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('deenly_user_profile');
    notifyListeners();
  }
}

// ── Widget wrapper pour accéder au profil ────────────────────────────

class DeenlyProfileScope extends InheritedNotifier<UserProfileProvider> {
  const DeenlyProfileScope({
    super.key,
    required UserProfileProvider provider,
    required super.child,
  }) : super(notifier: provider);

  static UserProfileProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DeenlyProfileScope>()!
        .notifier!;
  }

  static UserProfileProvider? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DeenlyProfileScope>()
        ?.notifier;
  }
}

// ── Données statiques ────────────────────────────────────────────────

const kAvatarOptions = <String>[
  '🌙', '⭐', '🕌', '📖', '🤲', '🌿', '💎', '🦁',
  '🌺', '🏔️', '🌊', '☀️', '🕋', '🌴', '🦅', '🌸',
];

const kGoalLabels = <DeenlyGoal, String>{
  DeenlyGoal.memoriserCoran: 'Mémoriser le Coran',
  DeenlyGoal.apprendrePriere: 'Apprendre la prière',
  DeenlyGoal.comprendreIslam: 'Comprendre l\'Islam',
  DeenlyGoal.eduquerEnfants: 'Éduquer mes enfants',
  DeenlyGoal.spiritualite: 'Renforcer ma spiritualité',
  DeenlyGoal.communaute: 'Rejoindre la communauté',
};

const kGoalEmojis = <DeenlyGoal, String>{
  DeenlyGoal.memoriserCoran: '📖',
  DeenlyGoal.apprendrePriere: '🤲',
  DeenlyGoal.comprendreIslam: '🎓',
  DeenlyGoal.eduquerEnfants: '👨‍👩‍👧‍👦',
  DeenlyGoal.spiritualite: '✨',
  DeenlyGoal.communaute: '🕌',
};

const kBadgeDefinitions = <String, Map<String, String>>{
  'premier_pas': {'emoji': '👣', 'titre': 'Premier pas', 'desc': 'A créé son profil'},
  'assidu_7': {'emoji': '🔥', 'titre': '7 jours de suite', 'desc': 'Série de 7 jours'},
  'assidu_30': {'emoji': '⚡', 'titre': '30 jours de suite', 'desc': 'Série de 30 jours'},
  'lecteur_10': {'emoji': '📖', 'titre': 'Lecteur assidu', 'desc': '10 versets lus'},
  'lecteur_100': {'emoji': '📚', 'titre': 'Amoureux du Coran', 'desc': '100 versets lus'},
  'xp_500': {'emoji': '⭐', 'titre': 'Étoile montante', 'desc': '500 XP atteints'},
  'xp_1500': {'emoji': '🌟', 'titre': 'Lumière du savoir', 'desc': '1500 XP atteints'},
  'xp_3000': {'emoji': '💫', 'titre': 'Flambeau', 'desc': '3000 XP atteints'},
  'explorer': {'emoji': '🔭', 'titre': 'Explorateur', 'desc': 'A visité tous les modules'},
  'famille': {'emoji': '👨‍👩‍👧', 'titre': 'Guide familial', 'desc': 'A utilisé Espace Familles'},
};
