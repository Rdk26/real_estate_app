import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:real_estate_app/models/user.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _auth = auth.FirebaseAuth.instance;

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
      logger.e("An error occurred during login", error);
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
      Get.snackbar('Error', "Something went wrong. Try again",
        colorText: Colors.red,
      );
      logger.e("An error occurred during registration", error);
      rethrow;
    }
  }

  final _db = FirebaseFirestore.instance;

  createUser(User user) async {
    await _db.collection('users').add(user.toJson());
  }
}
