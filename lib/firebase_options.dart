// firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAMEmoUDn4OVxnNZeqTTmPFgutoMKqL6hc',
    appId: '1:519258861421:web:43ceeee3ba97eed9fa3464',
    messagingSenderId: '519258861421',
    projectId: 'real-estate-app-firebase',
    authDomain: 'real-estate-app-firebase.firebaseapp.com',
    storageBucket: 'real-estate-app-firebase.appspot.com',
    measurementId: 'G-Q7ZP82V7R9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBK7d4gg2E5EQSvGi5bIuC4w3elQKm2hfo',
    appId: '1:519258861421:android:0a2a488c07ebc420fa3464',
    messagingSenderId: '519258861421',
    projectId: 'real-estate-app-firebase',
    storageBucket: 'real-estate-app-firebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyb0nK9CjrMT0j2Sdm3R_B0h7FkqAfuSk',
    appId: '1:519258861421:ios:726394d3761fbf52fa3464',
    messagingSenderId: '519258861421',
    projectId: 'real-estate-app-firebase',
    storageBucket: 'real-estate-app-firebase.appspot.com',
    iosBundleId: 'com.example.realEstateApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCyb0nK9CjrMT0j2Sdm3R_B0h7FkqAfuSk',
    appId: '1:519258861421:ios:726394d3761fbf52fa3464',
    messagingSenderId: '519258861421',
    projectId: 'real-estate-app-firebase',
    storageBucket: 'real-estate-app-firebase.appspot.com',
    iosBundleId: 'com.example.realEstateApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAMEmoUDn4OVxnNZeqTTmPFgutoMKqL6hc',
    appId: '1:519258861421:web:0a54984fc5fde544fa3464',
    messagingSenderId: '519258861421',
    projectId: 'real-estate-app-firebase',
    authDomain: 'real-estate-app-firebase.firebaseapp.com',
    storageBucket: 'real-estate-app-firebase.appspot.com',
    measurementId: 'G-BLF8EWTLBY',
  );
}
