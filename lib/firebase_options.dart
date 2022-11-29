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
    apiKey: 'AIzaSyDk_yMyf1hgkyZTgC7wiglMVUufD5Q9Qow',
    appId: '1:935204362232:web:ef183a5b69884d4b0aa80d',
    messagingSenderId: '935204362232',
    projectId: 'ditonton-ad338',
    authDomain: 'ditonton-ad338.firebaseapp.com',
    storageBucket: 'ditonton-ad338.appspot.com',
    measurementId: 'G-KFR8NBXY0H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATLHk4LwdaLZHN2Cjc3c0U1v8tX_WU0aY',
    appId: '1:935204362232:android:189ef08de0dd02030aa80d',
    messagingSenderId: '935204362232',
    projectId: 'ditonton-ad338',
    storageBucket: 'ditonton-ad338.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDWmdBlDSKEgieR9jwkYNAWyuq-R6Ln3U',
    appId: '1:935204362232:ios:5d4bd2876f00543a0aa80d',
    messagingSenderId: '935204362232',
    projectId: 'ditonton-ad338',
    storageBucket: 'ditonton-ad338.appspot.com',
    iosClientId: '935204362232-g15i7dlakv3sk00i1fbuq4e76pcn6bvp.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}