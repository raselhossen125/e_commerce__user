import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/model/product_model.dart';
import 'package:e_commerce__user/model/user_model.dart';

import '../model/cart_model.dart';

class DBHelper {
  static const categoriesCollection = 'Categories';
  static const productsCollection = 'Products';
  static const usersCollection = 'Users';
  static const cartCollection = 'cart';
  static const ordersCollection = 'Orders';
  static const ordersDetailsCollection = 'OrderDetails';
  static const settingsCollection = 'Settings';
  static const documentOrderConstant = 'OrderConstant';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addToCart(String uid, CartModel cartModel) {
    return _db
        .collection(usersCollection)
        .doc(uid)
        .collection(cartCollection)
        .doc(cartModel.productId)
        .set(cartModel.toMap());
  }

  static Future<void> updateCartItemQuantity(
      String uid, String pid, num quantity) {
    return _db
        .collection(usersCollection)
        .doc(uid)
        .collection(cartCollection)
        .doc(pid)
        .update({CartQuantity: quantity});
  }

  static Future<void> removeFromcart(String uid, String pid) {
    return _db
        .collection(usersCollection)
        .doc(uid)
        .collection(cartCollection)
        .doc(pid)
        .delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(categoriesCollection).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(productsCollection).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCartItems(
          String uid) =>
      _db
          .collection(usersCollection)
          .doc(uid)
          .collection(cartCollection)
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductsByCategory(
          String category) =>
      _db
          .collection(productsCollection)
          .where(ProductCategory, isEqualTo: category)
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllFeaturedProducts() =>
      _db
          .collection(productsCollection)
          .where(ProductFeatured, isEqualTo: true)
          .snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants() =>
      _db.collection(settingsCollection).doc(documentOrderConstant).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(
          String id) =>
      _db.collection(productsCollection).doc(id).snapshots();

  static Future<void> addUser(UserModel userModel) {
    return _db
        .collection(usersCollection)
        .doc(userModel.uId)
        .set(userModel.toMap());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(
      String uid) {
    return _db.collection(usersCollection).doc(uid).snapshots();
  }

  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return _db.collection(usersCollection).doc(uid).update(map);
  }
}
