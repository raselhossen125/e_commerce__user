// ignore_for_file: unused_local_variable, unrelated_type_equality_checks

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/model/city_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../db/db_helper.dart';
import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  List<CityModel> cityList = [];

  getAllCities() {
    DBHelper.getAllCitiess().listen((snapsort) {
      cityList = List.generate(snapsort.docs.length,
          (index) => CityModel.fromMap(snapsort.docs[index].data()));
      notifyListeners();
    });
  }

  List<String> getAreaByCityName(String? city) {
    if (city == null) return <String>[];
    final cityM = cityList.firstWhere((element) => element.name == city);
    return cityM.area;
  }

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
