import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/model/product_model.dart';
import 'package:e_commerce__user/model/rating_model.dart';
import 'package:e_commerce__user/model/user_model.dart';
import 'package:e_commerce__user/untils/constransts.dart';
import '../model/cart_model.dart';
import '../model/category_model.dart';
import '../model/order_model.dart';

class DBHelper {
  static const categoriesCollection = 'Categories';
  static const productsCollection = 'Products';
  static const usersCollection = 'Users';
  static const cartCollection = 'cart';
  static const ordersCollection = 'Orders';
  static const ratingCollection = 'Ratings';
  static const citiesCollection = 'Cities';
  static const ordersDetailsCollection = 'OrderDetails';
  static const settingsCollection = 'Settings';
  static const documentOrderConstant = 'OrderConstant';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addNewOrder(
      OrderModel orderModel, List<CartModel> cartList) {
    final wb = _db.batch();
    final orderDoc = _db.collection(ordersCollection).doc();
    orderModel.orderId = orderDoc.id;
    wb.set(orderDoc, orderModel.toMap());
    for (var cartM in cartList) {
      final cartDoc =
          orderDoc.collection(ordersDetailsCollection).doc(cartM.productId);
      wb.set(cartDoc, cartM.toMap());
    }
    return wb.commit();
  }

  static Future<void> updateProductStock(List<CartModel> cartList) {
    final wb = _db.batch();
    for (var cartM in cartList) {
      final productDoc =
          _db.collection(productsCollection).doc(cartM.productId);
      wb.update(productDoc, {ProductStock: (cartM.stock - cartM.quantity)});
    }
    return wb.commit();
  }

  static Future<void> updateCategoryProductCount(
      List<CartModel> cartList, List<CategoryModel> categoryList) {
    final wb = _db.batch();
    for (var cartM in cartList) {
      final catM = categoryList
          .firstWhere((element) => element.catName == cartM.category);
      final catDoc = _db.collection(categoriesCollection).doc(catM.catId);
      wb.update(catDoc, {CategoryProductCount: catM.count - cartM.quantity});
    }
    return wb.commit();
  }

  static Future<void> clearUserCartItems(String uid, List<CartModel> cartList) {
    final wb = _db.batch();
    final userDoc = _db.collection(usersCollection).doc(uid);
    for (var cartM in cartList) {
      final cartDoc = userDoc.collection(cartCollection).doc(cartM.productId);
      wb.delete(cartDoc);
    }
    return wb.commit();
  }

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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() => _db
      .collection(productsCollection)
      .where(ProductAvailable, isEqualTo: true)
      .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getOrdersByUsers(
          String uid) =>
      _db
          .collection(ordersCollection)
          .where(OrdUserId, isEqualTo: uid)
          .orderBy('$OrdDateModel.timestamp', descending: true)
          .snapshots();

  static Future<bool> canUserRateProduct(String uid, String pid) async {
    final qSnapshot = await _db.collection(ordersCollection)
        .where(OrdUserId, isEqualTo: uid)
        .where(OrdOrderStatus, isEqualTo: OrderStatus.delivered)
        .get();
    if(qSnapshot.docs.isEmpty) return false;
    bool tag = false;
    for(var snapshot in qSnapshot.docs) {
      final docSnap = await snapshot.reference.collection(ordersDetailsCollection).doc(pid).get();
      if(docSnap.exists) {
        tag = true;
        break;
      }
    }
    return tag;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCitiess() =>
      _db.collection(citiesCollection).snapshots();

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

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllRatingsByProduct(String pid) {
    return _db.collection(productsCollection).doc(pid).collection(ratingCollection).get();
  }

  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return _db.collection(usersCollection).doc(uid).update(map);
  }

  static Future<void> addNewRating(RatingModel ratingM) {
    final proDoc = _db.collection(productsCollection).doc(ratingM.productId);
    final ratingDoc = proDoc.collection(ratingCollection).doc(ratingM.userId);
    return ratingDoc.set(ratingM.toMap());
  }

  static Future<void> updateProduct(String pid, Map<String, dynamic> map) {
    return _db.collection(productsCollection)
        .doc(pid)
        .update(map);
  }

}
