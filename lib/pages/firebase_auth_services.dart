import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:real_estate_app/models/user.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _auth = auth.FirebaseAuth.instance;
  final _logger = Logger();

  Future<auth.UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password).whenComplete(
        () => Get.snackbar('Success', 'Registado com sucesso',
          colorText: Colors.green,
        ),
      );
    } catch (error) {
      Get.snackbar('Error', "Something went wrong. Try again",
        colorText: Colors.red,
      );
     _logger.e("Registration error", error);
      rethrow;
    }
  }

  Future<auth.UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password).whenComplete(
        () => Get.snackbar('Success', 'Registado com sucesso',
          colorText: Colors.green,
        ),
      );
    } catch (error) {
      Get.snackbar('Erro', "Algo deu errado. Tente denovo",
        colorText: Colors.red,
      );
      _logger.e("erro no login", error);
      rethrow;
    }
  }

  final _db = FirebaseFirestore.instance;

  createUser(User user) async {
    await _db.collection('users').add(user.toJson());
  }
}
