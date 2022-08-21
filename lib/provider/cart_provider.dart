import 'package:e_commerce__user/auth/auth_service.dart';
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];



  getAllCartItems() {
    DBHelper.getAllCartItems(AuthService.user!.uid).listen((snapsort) {
      cartList = List.generate(snapsort.docs.length,
          (index) => CartModel.fromMap(snapsort.docs[index].data()));
      notifyListeners();
    });
  }

  int get totalItemsInCart => cartList.length;

  bool isInCart(String productId) {
    bool flag = false;
    for (var cart in cartList) {
      if (cart.productId == productId) {
        flag = true;
        break;
      }
    }
    return flag;
  }
}
