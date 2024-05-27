import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String id;
  String username;
  String email;
  String phone;

  UserModel({
    this.id = '',
    this.username = '',
    this.email = '',
    this.phone = '',
  });

  void setUserData({
    required String id,
    required String username,
    required String email,
    required String phone,
  }) {
    this.id = id;
    this.username = username;
    this.email = email;
    this.phone = phone;
    notifyListeners();
  }
}
