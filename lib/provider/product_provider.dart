// ignore_for_file: avoid_print, unused_local_variable

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/auth/auth_service.dart';
import 'package:e_commerce__user/model/rating_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../db/db_helper.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';
import '../model/purchase_model.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  List<ProductModel> featuredProductList = [];
  List<PurchaseModel> purchaseListOfSpecefixProduct = [];
  List<String> categoryNameList = [];

  getAllcategories() {
    DBHelper.getAllCategories().listen((snapsort) {
      categoryList = List.generate(snapsort.docs.length,
          (index) => CategoryModel.fromMap(snapsort.docs[index].data()));
      categoryNameList = List.generate(
          categoryList.length, (index) => categoryList[index].catName!);
      categoryNameList.insert(0, 'All');
      notifyListeners();
    });
  }

  getAllProducts() {
    DBHelper.getAllProducts().listen((snapsort) {
      productList = List.generate(snapsort.docs.length,
          (index) => ProductModel.fromMap(snapsort.docs[index].data()));
    });
  }

  getAllFeaturedProducts() {
    DBHelper.getAllFeaturedProducts().listen((snapsort) {
      featuredProductList = List.generate(snapsort.docs.length,
              (index) => ProductModel.fromMap(snapsort.docs[index].data()));
    });
  }

  getAllProductsByCategory(String category) {
    DBHelper.getAllProductsByCategory(category).listen((snapsort) {
      productList = List.generate(snapsort.docs.length,
              (index) => ProductModel.fromMap(snapsort.docs[index].data()));
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(String id) =>
      DBHelper.getProductById(id);

  Future<String> updateImage(XFile xFile) async {
    final imagename = DateTime.now().millisecondsSinceEpoch.toString();
    final photoRefarance =
        FirebaseStorage.instance.ref().child('IserImages/$imagename');
    final uploadtask = photoRefarance.putFile(File(xFile.path));
    final snapshort = await uploadtask.whenComplete(() => null);
    return snapshort.ref.getDownloadURL();
  }

  Future<void> addNewRating(double value, String pid) async{
    final ratingM = RatingModel(
      userId: AuthService.user!.uid,
      productId: pid,
      rating: value
    );
    await DBHelper.addNewRating(ratingM);
    final qSnapshot = await DBHelper.getAllRatingsByProduct(pid);
    final List<RatingModel> ratingList =
      List.generate(qSnapshot.docs.length, (index) =>
      RatingModel.fromMap(qSnapshot.docs[index].data()));
    double ratingValue = 0.0;
    for(var ratingM in ratingList) {
      ratingValue += ratingM.rating;
    }
    final avgRating = ratingValue / ratingList.length;
    return DBHelper.updateProduct(pid, {ProductRating : avgRating});
  }
}
