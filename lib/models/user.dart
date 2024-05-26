import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  String _id = '';
  String _username = '';
  String _email = '';
  String _phone = '';

  String get id => _id;
  String get username => _username;
  String get email => _email;
  String get phone => _phone;

  void setUserData({
    required String id,
    required String username,
    required String email,
    required String phone,
  }) {
    _id = id;
    _username = username;
    _email = email;
    _phone = phone;
    notifyListeners();
  }
}
