// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/db/db_helper.dart';
import 'package:e_commerce__user/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../db/db_helper.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get user => _auth.currentUser;

  static Future<bool> logIn(String email, String password) async {
    final credensial = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credensial != null;
  }

  static Future<void> register(
      String name, String email, String mobile, String password) async {
    final credensial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final userModel = UserModel(
      uId: credensial.user!.uid,
      name: name,
      mobile: mobile,
      email: email,
      userCreationTime: Timestamp.fromDate(credensial.user!.metadata.creationTime!),
    );
    return DBHelper.addUser(userModel);
  }

  static Future<void> addUser(UserModel userModel) =>
      DBHelper.addUser(userModel);

  static Future<void> logOut() => _auth.signOut();
}
