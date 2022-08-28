import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../db/db_helper.dart';
import '../model/cart_model.dart';
import '../model/category_model.dart';
import '../model/order_constants_model.dart';
import '../model/order_model.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();

  Future<void> addOrder(OrderModel orderModel, List<CartModel> cartList) =>
    DBHelper.addNewOrder(orderModel, cartList);

  Future<void> updateProductStock(List<CartModel> cartList) =>
    DBHelper.updateProductStock(cartList);

  Future<void> updateCategoryProductCount(
      List<CartModel> cartList,
      List<CategoryModel> categoryList) =>
    DBHelper.updateCategoryProductCount(cartList, categoryList);

  Future<void> clearUserCartItems(List<CartModel> cartList) =>
    DBHelper.clearUserCartItems(AuthService.user!.uid, cartList);

  getOrderConstants() {
    DBHelper.getOrderConstants().listen((event) {
      if (event.exists) {
        orderConstantsModel = OrderConstantsModel.fromMap(event.data()!);
        notifyListeners();
      }
    });
  }

  num getDiscountAmount(num subtotal) {
    return (subtotal * orderConstantsModel.discount) / 100;
  }

  num getVatAmount(num subtotal) {
    final priceAfterDiscount = subtotal - getDiscountAmount(subtotal);
    return (priceAfterDiscount * orderConstantsModel.vat) / 100;
  }

  num getGrandTotal(num subtotal) {
    return (subtotal - getDiscountAmount(subtotal)) +
        getVatAmount(subtotal) +
        orderConstantsModel.deliveryCharge;
  }
}
