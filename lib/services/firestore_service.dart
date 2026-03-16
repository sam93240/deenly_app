// services/firestore_service.dart
// Lecture / écriture des données utilisateur dans Cloud Firestore
//
// Structure Firestore :
//   users/{userId}/
//     name, age, level, goals, avatar
//     xpTotal, streak, versetsLus, badges
//     lessonsXp, lessonsStreak, surahMastery
//     lastUpdated (serverTimestamp)

import 'package:cloud_firestore/cloud_firestore.dart';
import '../user_profile.dart';
import '../learning/learning_models.dart';

// ══════════════════════════════════════════════════════════════════════════
class FirestoreService {
  static final FirestoreService instance = FirestoreService._();
  FirestoreService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  // ── Upload profil complet (merge pour ne pas écraser) ─────────────────
  Future<void> uploadProfile({
    required String   userId,
    required UserProfile profile,
    required UserStats stats,
  }) async {
    await _users.doc(userId).set(
      {
        'name':          profile.prenom,
        'age':           profile.age,
        'level':         profile.niveau.index,
        'goals':         profile.objectifs.map((g) => g.index).toList(),
        'avatar':        profile.avatar,
        'xpTotal':       profile.xpTotal,
        'streak':        profile.streak,
        'versetsLus':    profile.versetsLus,
        'badges':        profile.badges,
        'lessonsXp':     stats.xp,
        'lessonsStreak': stats.streak,
        'surahMastery':  stats.surahMastery.map(
                           (k, v) => MapEntry(k.toString(), v.index)),
        'lastUpdated':   FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  // ── Télécharger les données Firebase ─────────────────────────────────
  Future<Map<String, dynamic>?> downloadData(String userId) async {
    final doc = await _users.doc(userId).get();
    return doc.exists ? doc.data() : null;
  }

  // ── Mise à jour XP (incrémental — évite les conflits de concurrence) ─
  Future<void> incrementXP(String userId, int amount) async {
    await _users.doc(userId).update({
      'xpTotal':     FieldValue.increment(amount),
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }

  // ── Mise à jour d'un champ quelconque ────────────────────────────────
  Future<void> updateField(String userId, String field, dynamic value) async {
    await _users.doc(userId).set(
      {field: value, 'lastUpdated': FieldValue.serverTimestamp()},
      SetOptions(merge: true),
    );
  }
}
