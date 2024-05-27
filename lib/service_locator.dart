import 'package:real_estate_app/features/user_auth/user_auth_implementation/auth_service.dart';

AuthService getAuthService(bool isFirebaseAvailable) {
  return AuthService(isFirebaseAvailable);
}
