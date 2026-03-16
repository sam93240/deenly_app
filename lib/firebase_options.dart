// firebase_options.dart
// ─────────────────────────────────────────────────────────────────────────
// ⚠️  PLACEHOLDER — Ce fichier doit être régénéré avec FlutterFire CLI
//
// Étapes :
//   1. Crée ton projet sur https://console.firebase.google.com
//   2. Dans le terminal, à la racine du projet Flutter :
//        dart pub global activate flutterfire_cli
//        flutterfire configure --project=TON_PROJECT_ID
//   3. Ce fichier sera écrasé automatiquement avec tes vraies clés.
//
// En attendant, remplace chaque valeur TODO_ ci-dessous par les valeurs
// trouvées dans les paramètres de ton projet Firebase.
// ─────────────────────────────────────────────────────────────────────────

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions non configuré pour: $defaultTargetPlatform\n'
          'Exécute : flutterfire configure',
        );
    }
  }

  // ── Android ───────────────────────────────────────────────────────────
  static const FirebaseOptions android = FirebaseOptions(
    apiKey:            'AIzaSyBECFTda6P9EYxrMVTWpi2j5r3bw0A_2Es',
    appId:             '1:117900108941:android:bdd3d37915ef17f80b6ec4',
    messagingSenderId: '117900108941',
    projectId:         'upyourdeen',
    storageBucket:     'upyourdeen.firebasestorage.app',
  );

  // ── iOS ───────────────────────────────────────────────────────────────
  // TODO : ajouter l'app iOS dans la console Firebase, puis remplacer ces valeurs
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey:            'TODO_IOS_API_KEY',
    appId:             'TODO_IOS_APP_ID',
    messagingSenderId: '117900108941',
    projectId:         'upyourdeen',
    storageBucket:     'upyourdeen.firebasestorage.app',
    iosBundleId:       'TODO_IOS_BUNDLE_ID',
  );
}
