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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBKiH-4Ha_1g_nJxmvPGLYs_iZoi46_x-w',
    appId: '1:964937077573:web:37b930c45a1c21fe03242c',
    messagingSenderId: '964937077573',
    projectId: 'fir-emailauthflutter-dfdf7',
    authDomain: 'fir-emailauthflutter-dfdf7.firebaseapp.com',
    databaseURL: 'https://fir-emailauthflutter-dfdf7-default-rtdb.firebaseio.com',
    storageBucket: 'fir-emailauthflutter-dfdf7.firebasestorage.app',
    measurementId: 'G-S4P8W2JMKY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFQOC6Xvi4pQxCV9ctREM-0OSzRegdT78',
    appId: '1:964937077573:android:0cd555a934416f2303242c',
    messagingSenderId: '964937077573',
    projectId: 'fir-emailauthflutter-dfdf7',
    databaseURL: 'https://fir-emailauthflutter-dfdf7-default-rtdb.firebaseio.com',
    storageBucket: 'fir-emailauthflutter-dfdf7.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA4Bf5UCIg-lVx7aQb-KJORGjArIkwvVyw',
    appId: '1:964937077573:web:890cdb79828e6c1403242c',
    messagingSenderId: '964937077573',
    projectId: 'fir-emailauthflutter-dfdf7',
    authDomain: 'fir-emailauthflutter-dfdf7.firebaseapp.com',
    databaseURL: 'https://fir-emailauthflutter-dfdf7-default-rtdb.firebaseio.com',
    storageBucket: 'fir-emailauthflutter-dfdf7.firebasestorage.app',
    measurementId: 'G-0M91KZESER',
  );
}
