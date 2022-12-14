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
    apiKey: 'AIzaSyDFISNkTnus4fDmxt9Ix4YG1v2TsofMZ9Q',
    appId: '1:204385863639:web:601f6bb07e9e20fda1ad92',
    messagingSenderId: '204385863639',
    projectId: 'newtest12321',
    authDomain: 'newtest12321.firebaseapp.com',
    storageBucket: 'newtest12321.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpucXhNXAulzW50IQE80UaKEBfXJNcSdk',
    appId: '1:204385863639:android:08af5e554100ffb6a1ad92',
    messagingSenderId: '204385863639',
    projectId: 'newtest12321',
    storageBucket: 'newtest12321.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEIf-8DHx5OGM4DtH2FbZsabWyL8EoCnw',
    appId: '1:204385863639:ios:b241687ad5ee35a1a1ad92',
    messagingSenderId: '204385863639',
    projectId: 'newtest12321',
    storageBucket: 'newtest12321.appspot.com',
    iosClientId: '204385863639-meqkajs6sdsssnpup6u7k9g2d9oorakv.apps.googleusercontent.com',
    iosBundleId: 'com.example.newTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCEIf-8DHx5OGM4DtH2FbZsabWyL8EoCnw',
    appId: '1:204385863639:ios:b241687ad5ee35a1a1ad92',
    messagingSenderId: '204385863639',
    projectId: 'newtest12321',
    storageBucket: 'newtest12321.appspot.com',
    iosClientId: '204385863639-meqkajs6sdsssnpup6u7k9g2d9oorakv.apps.googleusercontent.com',
    iosBundleId: 'com.example.newTest',
  );
}
