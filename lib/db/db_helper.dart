import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  static const categoriesCollection = 'Categories';
  static const productsCollection = 'Products';
  static const usersCollection = 'Users';
  static const ordersCollection = 'Orders';
  static const ordersDetailsCollection = 'OrderDetails';
  static const settingsCollection = 'Settings';
  static const documentOrderConstant = 'OrderConstant';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(categoriesCollection).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(productsCollection).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants() =>
      _db.collection(settingsCollection).doc(documentOrderConstant).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(
          String id) =>
      _db.collection(productsCollection).doc(id).snapshots();
}
