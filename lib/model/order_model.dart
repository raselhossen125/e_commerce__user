// ignore_for_file: constant_identifier_names

import 'package:e_commerce__user/model/address_model.dart';
import 'package:e_commerce__user/model/date_model.dart';

const String OrdOrderId = 'orderId';
const String OrdUserId = 'userId';
const String OrdDateModel = 'dateModel';
const String OrdOrderStatus = 'orderStatus';
const String OrdPaymentInMethod = 'paymentMethod';
const String OrdGrandTotal = 'grandTotal';
const String OrdDiscount = 'discount';
const String OrdVat = 'vat';
const String OrdDeliveryCharge = 'deliveryCharge';
const String OrdDeliveryAddress = 'deliveryAddress';

class OrderModel {
  String? orderId;
  String? userId;
  DateModel dateModel;
  String orderStatus;
  String paymentMethod;
  num grandTotal;
  num discount;
  num vat;
  num deliveryCharge;
  AddressModel deliveryAddress;

  OrderModel({
    this.orderId,
    this.userId,
    required this.dateModel,
    required this.orderStatus,
    required this.paymentMethod,
    required this.grandTotal,
    required this.discount,
    required this.vat,
    required this.deliveryCharge,
    required this.deliveryAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      OrdOrderId: orderId,
      OrdUserId: userId,
      OrdDateModel: dateModel.toMap(dateModel),
      OrdOrderStatus: orderStatus,
      OrdPaymentInMethod: paymentMethod,
      OrdGrandTotal: grandTotal,
      OrdDiscount: discount,
      OrdVat: vat,
      OrdDeliveryCharge: deliveryCharge,
      OrdDeliveryAddress: deliveryAddress.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
    orderId: map[OrdOrderId],
    userId: map[OrdUserId],
    dateModel: DateModel.fromMap(map[OrdDateModel]),
    orderStatus: map[OrdOrderStatus],
    paymentMethod: map[OrdPaymentInMethod],
    grandTotal: map[OrdGrandTotal],
    discount: map[OrdDiscount],
    vat: map[OrdVat],
    deliveryCharge: map[OrdDeliveryCharge],
    deliveryAddress: AddressModel.fromMap(map[OrdDeliveryAddress]),
  );
}
