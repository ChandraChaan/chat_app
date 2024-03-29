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
    apiKey: 'AIzaSyCoaEo4-jRKUXhLTIWmxd1AFTqCeanAo5g',
    appId: '1:791143287925:web:be60309d8e90de35ce7c3c',
    messagingSenderId: '791143287925',
    projectId: 'chatapp-b39d8',
    authDomain: 'chatapp-b39d8.firebaseapp.com',
    storageBucket: 'chatapp-b39d8.appspot.com',
    measurementId: 'G-WC9LGZ98H0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPZXjgIzBS9T3JQRlq1WwIoIVg28E-wTQ',
    appId: '1:791143287925:android:2a60c00b1be07019ce7c3c',
    messagingSenderId: '791143287925',
    projectId: 'chatapp-b39d8',
    storageBucket: 'chatapp-b39d8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfJugDsp4nA-taSiajH7Ms-AAk5v_e9S0',
    appId: '1:791143287925:ios:8b9e2abd72255f5ace7c3c',
    messagingSenderId: '791143287925',
    projectId: 'chatapp-b39d8',
    storageBucket: 'chatapp-b39d8.appspot.com',
    iosBundleId: 'com.chaat.chatapp',
  );
}
