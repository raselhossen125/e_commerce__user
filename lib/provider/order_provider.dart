import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../model/order_constants_model.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();

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
