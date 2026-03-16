// services/auth_service.dart
// Authentification Firebase : Google Sign-In + Email/Password
// Fonctionne en mode dégradé si Firebase n'est pas initialisé (web, iOS non configuré…)

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

// ══════════════════════════════════════════════════════════════════════════
class AuthService {
  static final AuthService instance = AuthService._();
  AuthService._();

  // Getters paresseux — ne crashent pas si Firebase n'est pas initialisé
  FirebaseAuth get _auth        => FirebaseAuth.instance;
  GoogleSignIn get _googleSignIn => GoogleSignIn();

  /// True si Firebase est disponible sur cette plateforme/session.
  /// Sur web, le SDK Firebase n'est pas configuré → toujours false.
  static bool get available {
    if (kIsWeb) return false; // Firebase web SDK non configuré
    try {
      return Firebase.apps.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // ── Getters ───────────────────────────────────────────────────────────
  User? get currentUser {
    if (!available) return null;
    return _auth.currentUser;
  }

  bool get isLoggedIn {
    if (!available) return false;
    return _auth.currentUser != null;
  }

  Stream<User?> get authStateChanges {
    if (!available) return Stream.value(null);
    return _auth.authStateChanges();
  }

  // ── Google Sign-In ────────────────────────────────────────────────────
  Future<User?> signInWithGoogle() async {
    if (!available) throw const AuthException('Firebase non disponible sur cette plateforme.');
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // annulé par l'utilisateur

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken:     googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    } catch (e) {
      throw AuthException('Connexion Google échouée. Réessayez.');
    }
  }

  // ── Créer un compte Email/Password ───────────────────────────────────
  Future<User?> createAccountWithEmail(String email, String password) async {
    if (!available) throw const AuthException('Firebase non disponible sur cette plateforme.');
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email:    email.trim(),
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  // ── Connexion Email/Password ──────────────────────────────────────────
  Future<User?> signInWithEmail(String email, String password) async {
    if (!available) throw const AuthException('Firebase non disponible sur cette plateforme.');
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email:    email.trim(),
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  // ── Déconnexion ───────────────────────────────────────────────────────
  Future<void> signOut() async {
    if (!available) return;
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  // ── Messages d'erreur lisibles ────────────────────────────────────────
  String _mapError(String code) {
    return switch (code) {
      'email-already-in-use'   => 'Cette adresse email est déjà utilisée.',
      'invalid-email'          => 'Adresse email invalide.',
      'weak-password'          => 'Mot de passe trop faible (6 caractères minimum).',
      'user-not-found'         => 'Aucun compte trouvé avec cet email.',
      'wrong-password'         => 'Mot de passe incorrect.',
      'invalid-credential'     => 'Email ou mot de passe incorrect.',
      'network-request-failed' => 'Pas de connexion internet.',
      'too-many-requests'      => 'Trop de tentatives. Réessayez dans quelques minutes.',
      _                        => 'Une erreur est survenue. Réessayez.',
    };
  }
}

// ══════════════════════════════════════════════════════════════════════════
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}
