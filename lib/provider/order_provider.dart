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
}
