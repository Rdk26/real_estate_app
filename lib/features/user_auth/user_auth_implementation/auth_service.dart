import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:real_estate_app/features/user_auth/user_auth_implementation/local_user.dart';
import 'package:real_estate_app/features/user_auth/user_auth_implementation/firebase_auth_services.dart';
import 'package:real_estate_app/features/user_auth/user_auth_implementation/local_auth_service.dart';

class AuthService {
  final bool isFirebaseAvailable;

  AuthService(this.isFirebaseAvailable);

  Future<LocalUser?> signUpWithEmailAndPassword(String email, String password) async {
    if (isFirebaseAvailable) {
      firebase_auth.User? user = await FirebaseAuthService().signUpWithEmailAndPassword(email, password);
      if (user != null) {
        return LocalUser(
          id: user.uid,
          email: user.email!,
          displayName: user.displayName,
          phoneNumber: user.phoneNumber,
        );
      }
      return null;
    } else {
      return await LocalAuthService().signUpWithEmailAndPassword(email, password);
    }
  }

  Future<LocalUser?> signInWithEmailAndPassword(String email, String password) async {
    if (isFirebaseAvailable) {
      firebase_auth.User? user = await FirebaseAuthService().signInWithEmailAndPassword(email, password);
      if (user != null) {
        return LocalUser(
          id: user.uid,
          email: user.email!,
          displayName: user.displayName,
          phoneNumber: user.phoneNumber,
        );
      }
      return null;
    } else {
      return await LocalAuthService().signInWithEmailAndPassword(email, password);
    }
  }
}
