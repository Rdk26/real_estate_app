import 'local_user.dart';

class LocalAuthService {
  Future<LocalUser?> signUpWithEmailAndPassword(String email, String password) async {
    // Implemente sua lógica de signup local aqui
    return LocalUser(
      id: 'local_id',
      email: email,
      displayName: 'Local User',
      phoneNumber: '123456789',
    );
  }

  Future<LocalUser?> signInWithEmailAndPassword(String email, String password) async {
    // Implemente sua lógica de login local aqui
    return LocalUser(
      id: 'local_id',
      email: email,
      displayName: 'Local User',
      phoneNumber: '123456789',
    );
  }
}
