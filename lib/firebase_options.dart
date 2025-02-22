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
    apiKey: 'AIzaSyBmvtydFeuYjJ1dWXPHR_Sz6bJ1ANU7G_A',
    appId: '1:938219814194:web:933e2a97ef42ac9e836b2b',
    messagingSenderId: '938219814194',
    projectId: 'esasa-app',
    authDomain: 'esasa-app.firebaseapp.com',
    storageBucket: 'esasa-app.firebasestorage.app',
    measurementId: 'G-NS66LZ1RM2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVwJ4swOZYlv12o3sL1-2WoqXKiPDA-rw',
    appId: '1:938219814194:android:06162eec23d0581b836b2b',
    messagingSenderId: '938219814194',
    projectId: 'esasa-app',
    storageBucket: 'esasa-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqWLd_KkE5yt8_kkhD_uQ4C5YdW5vWADI',
    appId: '1:938219814194:ios:85aaa16207b38091836b2b',
    messagingSenderId: '938219814194',
    projectId: 'esasa-app',
    storageBucket: 'esasa-app.firebasestorage.app',
    iosBundleId: 'com.sas.esasFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1FsQNASYDQKuDD-1Pbog-2qKDz9w8Ltk',
    appId: '1:834167435213:ios:f10b3e5dcf994d2c975e84',
    messagingSenderId: '834167435213',
    projectId: 'esas-7d76f',
    storageBucket: 'esas-7d76f.firebasestorage.app',
    iosBundleId: 'com.example.esasFlutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAwaoLeHambBSYcBCw7iMbkH8I_yjL2-XE',
    appId: '1:834167435213:web:fd769b7a61a994ad975e84',
    messagingSenderId: '834167435213',
    projectId: 'esas-7d76f',
    authDomain: 'esas-7d76f.firebaseapp.com',
    storageBucket: 'esas-7d76f.firebasestorage.app',
    measurementId: 'G-2HTWLTD68P',
  );
}