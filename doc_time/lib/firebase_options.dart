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
    apiKey: 'AIzaSyCGhasaJctvJKVEGNFl6a7b4fre3Hi4pAc',
    appId: '1:694315825768:web:64c0d433d81e4964b6d9dd',
    messagingSenderId: '694315825768',
    projectId: 'doctime-4c848',
    authDomain: 'doctime-4c848.firebaseapp.com',
    storageBucket: 'doctime-4c848.appspot.com',
    measurementId: 'G-KVSGBT1Z9V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNAspvdFutq1s-ye6sgGVYyOh_PMJq0cM',
    appId: '1:694315825768:android:a5146a1f01d89852b6d9dd',
    messagingSenderId: '694315825768',
    projectId: 'doctime-4c848',
    storageBucket: 'doctime-4c848.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQu4hdhXjt-_pRUASO2qOUyhx3Me5FXfc',
    appId: '1:694315825768:ios:4169d08d0d463911b6d9dd',
    messagingSenderId: '694315825768',
    projectId: 'doctime-4c848',
    storageBucket: 'doctime-4c848.appspot.com',
    iosClientId: '694315825768-iklvun6k4c0v4qi6brkd6mic2niqbjlr.apps.googleusercontent.com',
    iosBundleId: 'com.example.docTime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQu4hdhXjt-_pRUASO2qOUyhx3Me5FXfc',
    appId: '1:694315825768:ios:4169d08d0d463911b6d9dd',
    messagingSenderId: '694315825768',
    projectId: 'doctime-4c848',
    storageBucket: 'doctime-4c848.appspot.com',
    iosClientId: '694315825768-iklvun6k4c0v4qi6brkd6mic2niqbjlr.apps.googleusercontent.com',
    iosBundleId: 'com.example.docTime',
  );
}
