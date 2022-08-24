// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/auth/auth_service.dart';
import 'package:e_commerce__user/model/user_model.dart';
import 'package:e_commerce__user/pages/user_address_page.dart';
import 'package:e_commerce__user/provider/user_provider.dart';
import 'package:e_commerce__user/untils/constransts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/order_provider.dart';

class CheckoutPage extends StatefulWidget {
  static const routeName = "check-out";
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late CartProvider cartProvider;
  late OrderProvider orderProvider;
  late UserProvider userProvider;
  String groupValue = "COD";
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      cartProvider = Provider.of<CartProvider>(context);
      orderProvider = Provider.of<OrderProvider>(context);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      orderProvider.getOrderConstants();
      super.didChangeDependencies();
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                Text(
                  "Product Info",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Column(
                    children: cartProvider.cartList
                        .map((cartModel) => ListTile(
                              dense: true,
                              title: Text(cartModel.productName!),
                              trailing: Text(
                                  "${cartModel.quantity}* ৳${cartModel.salePrice}"),
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Payment Info",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        dense: true,
                        leading: Text("Subtotal"),
                        trailing: Text(
                            '$currencySymbol${cartProvider.getCartSubTotal()}'),
                      ),
                      ListTile(
                        dense: true,
                        leading: Text(
                            "Discount (${orderProvider.orderConstantsModel.discount.round()}${'%'})"),
                        trailing: Text(
                            '$currencySymbol${orderProvider.getDiscountAmount(cartProvider.getCartSubTotal())}'),
                      ),
                      ListTile(
                        dense: true,
                        leading: Text(
                            "Vat (${orderProvider.orderConstantsModel.vat.round()}${'%'})"),
                        trailing: Text(
                            '$currencySymbol${orderProvider.getVatAmount(cartProvider.getCartSubTotal())}'),
                      ),
                      ListTile(
                        dense: true,
                        leading: Text("Delivery Charge"),
                        trailing: Text(
                            '$currencySymbol${orderProvider.orderConstantsModel.deliveryCharge}'),
                      ),
                      Divider(),
                      ListTile(
                        dense: true,
                        leading: Text("Grand total:"),
                        trailing: Text(
                            '$currencySymbol${orderProvider.getGrandTotal(cartProvider.getCartSubTotal())}'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Delivery Address",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                Card(
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: userProvider.getUserByUid(AuthService.user!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userM = UserModel.fromMap(snapshot.data!.data()!);
                      final addressM = userM.addressModel;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(addressM == null
                                ? 'No address found'
                                : '${addressM.streetAddress} \n ${addressM.area} \n ${addressM.city} \n ${addressM.zipCode}'),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15))),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(UserAddressPage.routeName);
                                },
                                child: Text("Set"))
                          ],
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('Failed to face data');
                    }
                    return Center(child: Text('Feaching address...'));
                  },
                )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Payment Method",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text("COD"),
                        leading: Radio<String>(
                            value: "COD",
                            groupValue: groupValue,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => groupValue == "COD"
                                    ? Colors.red
                                    : Colors.grey),
                            onChanged: (value) {
                              setState(() {
                                groupValue = value as String;
                              });
                            }),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text("Online"),
                        leading: Radio<String>(
                          value: "Online",
                          groupValue: groupValue,
                          fillColor: MaterialStateColor.resolveWith((states) =>
                              groupValue == "Online"
                                  ? Colors.red
                                  : Colors.grey),
                          onChanged: (value) {
                            setState(() {
                              groupValue = value as String;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {},
                child: const Text("Place order")),
          )
        ],
      ),
    );
  }
}
