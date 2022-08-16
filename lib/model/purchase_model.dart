// ignore_for_file: constant_identifier_names


import 'date_model.dart';

const String PurchaseId = 'id';
const String PurchaseProductId = 'productId';
const String PurchaseDateModel = 'dateModel';
const String PurchaseProductPrice = 'productPrice';
const String PurchaseProductQunatity = 'productQuantity';

class PurchaseModel {
  String? id;
  String? productId;
  DateModel dateModel;
  num purchasePrice;
  num productQuantity;

  PurchaseModel({
    this.id,
    this.productId,
    required this.dateModel,
    required this.purchasePrice,
    required this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PurchaseId: id,
      PurchaseProductId: productId,
      PurchaseDateModel: dateModel.toMap(dateModel),
      PurchaseProductPrice: purchasePrice,
      PurchaseProductQunatity: productQuantity
    };
  }

  factory PurchaseModel.fromMap(Map<String, dynamic> map) => PurchaseModel(
    id: map[PurchaseId],
    productId: map[PurchaseProductId],
    dateModel: DateModel.fromMap(map[PurchaseDateModel]),
    purchasePrice: map[PurchaseProductPrice],
    productQuantity: map[PurchaseProductQunatity],
  );
}
