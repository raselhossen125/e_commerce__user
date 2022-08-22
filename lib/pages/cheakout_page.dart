// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce__user/untils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class CheakoutPage extends StatefulWidget {
  static const routeName = 'cheakout';

  @override
  State<CheakoutPage> createState() => _CheakoutPageState();
}

class _CheakoutPageState extends State<CheakoutPage> {
  late CartProvider cartProvider;
  @override
  void didChangeDependencies() {
    cartProvider = Provider.of<CartProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cheakout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 2),
                  child: Text('Product Info',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                ),
                SizedBox(height: 8),
                Card(
                  elevation: 5,
                  child: Column(
                    children: cartProvider.cartList
                        .map((cartM) => ListTile(
                              title: Text(cartM.productName!),
                              trailing: Text(
                                  '${cartM.salePrice}  X  ${cartM.quantity}'),
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 15),
                  child: Text('Payment Info',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                ),
                Column(
                  children: [],
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: appColor.cardColor,
                  ),
                  child: Center(
                    child: Text(
                      'Proceed to Order',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
