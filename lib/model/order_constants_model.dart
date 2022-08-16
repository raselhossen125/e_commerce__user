// ignore_for_file: constant_identifier_names, camel_case_types

const String DeleveryChargeKey = 'deliveryCharge';
const String DiscountKey = 'discount';
const String VatKey = 'vat';

class OrderConstantsModel {
  num deliveryCharge;
  num discount;
  num vat;

  OrderConstantsModel({
    this.deliveryCharge = 0,
    this.discount = 0,
    this.vat = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DeleveryChargeKey: deliveryCharge,
      DiscountKey: discount,
      VatKey: vat,
    };
  }

  factory OrderConstantsModel.fromMap(Map<String, dynamic> map) =>
      OrderConstantsModel(
        deliveryCharge: map[DeleveryChargeKey],
        discount: map[DiscountKey],
        vat: map[VatKey],
      );
}
