import 'package:e_commerce__user/auth/auth_service.dart';
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];

  Future<void> addToCart(CartModel cartModel) {
    return DBHelper.addToCart(AuthService.user!.uid, cartModel);
  }

  Future<void> removeFromCart(String productId) {
    return DBHelper.removeFromcart(AuthService.user!.uid, productId);
  }

  getAllCartItems() {
    DBHelper.getAllCartItems(AuthService.user!.uid).listen((snapsort) {
      cartList = List.generate(snapsort.docs.length,
          (index) => CartModel.fromMap(snapsort.docs[index].data()));
      notifyListeners();
    });
  }

  increaseQuantity(CartModel cartModel) async {
    if (cartModel.quantity < cartModel.stock) {
      await DBHelper.updateCartItemQuantity(
          AuthService.user!.uid, cartModel.productId!, cartModel.quantity + 1);
    }
  }

  decreaseQuantity(CartModel cartModel) async {
    if (cartModel.quantity > 1) {
      await DBHelper.updateCartItemQuantity(
          AuthService.user!.uid, cartModel.productId!, cartModel.quantity - 1);
    }
  }

  int get totalItemsInCart => cartList.length;

  num itemPriceWithQuantity(CartModel cartModel) =>
      cartModel.salePrice * cartModel.quantity;

  num getCartSubTotal() {
    num total = 0;
    for (var cartM in cartList) {
      total += cartM.salePrice * cartM.quantity;
    }
    return total;
  }

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
