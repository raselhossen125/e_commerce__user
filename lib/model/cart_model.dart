// ignore_for_file: constant_identifier_names, camel_case_types

const String CartProductId = 'productId';
const String CartProductName = 'productName';
const String CartImageUrl = 'imageUrl';
const String CartSalePrice = 'salePrice';
const String CartQuantity = 'quantity';

class CartModel {
  String? productId;
  String? productName;
  String? imageUrl;
  num salePrice;
  num quantity;

  CartModel({
    this.productId,
    this.productName,
    this.imageUrl,
    this.quantity = 1,
    required this.salePrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CartProductId: productId,
      CartProductName: productName,
      CartImageUrl: imageUrl,
      CartQuantity: quantity,
      CartSalePrice: salePrice,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) => CartModel(
    productId: map[CartProductId],
    productName: map[CartProductName],
    imageUrl: map[CartImageUrl],
    quantity: map[CartQuantity],
    salePrice: map[CartSalePrice],
  );
}
