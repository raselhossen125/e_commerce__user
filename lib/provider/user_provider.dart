import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../db/db_helper.dart';
import '../model/user_model.dart';

class UserProvider extends ChangeNotifier{
  Future<void> addUser(UserModel userModel) => DBHelper.addUser(userModel);

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(String uid) =>
      DBHelper.getUserByUid(uid);

  Future<void> updateProfile(String uid, Map<String, dynamic> map) =>
      DBHelper.updateProfile(uid, map);

  Future<String> updateImage(XFile xFile) async {
    final imagename = DateTime.now().millisecondsSinceEpoch.toString();
    final photoRefarance =
    FirebaseStorage.instance.ref().child('pictures/$imagename');
    final uploadtask = photoRefarance.putFile(File(xFile.path));
    final snapshort = await uploadtask.whenComplete(() => null);
    return snapshort.ref.getDownloadURL();
  }
}