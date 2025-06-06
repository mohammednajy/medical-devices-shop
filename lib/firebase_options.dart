// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCVtxIuLxYJgUsBQfAyHxs1ZIgc5AMBpAc',
    appId: '1:711489031706:web:b6963cd1e009a9838ecba3',
    messagingSenderId: '711489031706',
    projectId: 'medical-devices-app',
    authDomain: 'medical-devices-app.firebaseapp.com',
    storageBucket: 'medical-devices-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdPQs33_VHVAi5QwsDRX6v7cIOLCfGNOY',
    appId: '1:711489031706:android:581c0a41b0bfb4568ecba3',
    messagingSenderId: '711489031706',
    projectId: 'medical-devices-app',
    storageBucket: 'medical-devices-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAod_L_btWnzJ4TY9taVwIXs6QAcnBATLg',
    appId: '1:711489031706:ios:942e68c8674a513c8ecba3',
    messagingSenderId: '711489031706',
    projectId: 'medical-devices-app',
    storageBucket: 'medical-devices-app.appspot.com',
    iosBundleId: 'com.example.medicalDevicesApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAod_L_btWnzJ4TY9taVwIXs6QAcnBATLg',
    appId: '1:711489031706:ios:78b3fa5a7c1ed4948ecba3',
    messagingSenderId: '711489031706',
    projectId: 'medical-devices-app',
    storageBucket: 'medical-devices-app.appspot.com',
    iosBundleId: 'com.example.medicalDevicesApp.RunnerTests',
  );
}
