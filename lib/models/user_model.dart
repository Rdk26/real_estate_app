import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends ChangeNotifier {
  String _username = '';
  String _email = '';
  String _phone = '';
  String _profileImageUrl = '';

  String get username => _username;
  String get email => _email;
  String get phone => _phone;
  String get profileImageUrl => _profileImageUrl;

  UserModel() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _username = user.displayName ?? '';
      _email = user.email ?? '';
      _phone = user.phoneNumber ?? '';
      _profileImageUrl = user.photoURL ?? 'https://via.placeholder.com/150';
      notifyListeners();
    }
  }

  void setUserData({required String id, required String username, required String email, required String phone}) {
    _username = username;
    _email = email;
    _phone = phone;
    notifyListeners();
  }

  Future<void> updateUserData() async {
    await _loadUserData();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _username = '';
    _email = '';
    _phone = '';
    _profileImageUrl = '';
    notifyListeners();
  }
}
