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
    apiKey: 'AIzaSyC4D3LdVWeN1T9iZYwHdjOZxF4sjR1WxWE',
    appId: '1:293900070921:web:652b0ccce756a0fb8f48d8',
    messagingSenderId: '293900070921',
    projectId: 'happy-recycle',
    authDomain: 'happy-recycle.firebaseapp.com',
    storageBucket: 'happy-recycle.appspot.com',
    measurementId: 'G-N3XDY6365C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuexWXHIFDt_mH1hbtG0hs19damgh2J8Y',
    appId: '1:293900070921:android:8c48404c28c3f1fb8f48d8',
    messagingSenderId: '293900070921',
    projectId: 'happy-recycle',
    storageBucket: 'happy-recycle.appspot.com',
  );
}