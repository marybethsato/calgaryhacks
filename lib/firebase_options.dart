// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBT-rca-pyANsUu6aICHeCX-t22nv9aY9U',
    appId: '1:465821997848:web:22ab644f9eff93b49d5c6d',
    messagingSenderId: '465821997848',
    projectId: 'calgaryhacks2025',
    authDomain: 'calgaryhacks2025.firebaseapp.com',
    storageBucket: 'calgaryhacks2025.firebasestorage.app',
    measurementId: 'G-JHZ61VPWY8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWiw3R-U4HZml7AKLaOO4HJ0H43unFVSI',
    appId: '1:465821997848:android:8d0c06ca1e75f29d9d5c6d',
    messagingSenderId: '465821997848',
    projectId: 'calgaryhacks2025',
    storageBucket: 'calgaryhacks2025.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHUg-hggvKZSKsCGDaeaQnp-32ZjMMW9o',
    appId: '1:465821997848:ios:808f7b9399f4c4029d5c6d',
    messagingSenderId: '465821997848',
    projectId: 'calgaryhacks2025',
    storageBucket: 'calgaryhacks2025.firebasestorage.app',
    iosBundleId: 'com.example.calgaryhacks',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAHUg-hggvKZSKsCGDaeaQnp-32ZjMMW9o',
    appId: '1:465821997848:ios:808f7b9399f4c4029d5c6d',
    messagingSenderId: '465821997848',
    projectId: 'calgaryhacks2025',
    storageBucket: 'calgaryhacks2025.firebasestorage.app',
    iosBundleId: 'com.example.calgaryhacks',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBT-rca-pyANsUu6aICHeCX-t22nv9aY9U',
    appId: '1:465821997848:web:85c67b4928eb22b39d5c6d',
    messagingSenderId: '465821997848',
    projectId: 'calgaryhacks2025',
    authDomain: 'calgaryhacks2025.firebaseapp.com',
    storageBucket: 'calgaryhacks2025.firebasestorage.app',
    measurementId: 'G-CMN7MZ42CE',
  );
}
