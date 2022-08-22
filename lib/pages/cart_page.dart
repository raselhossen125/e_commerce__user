// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:e_commerce__user/pages/cheakout_page.dart';
import 'package:e_commerce__user/provider/cart_provider.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:e_commerce__user/untils/constransts.dart';
import 'package:e_commerce__user/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.bgColor,
      appBar: AppBar(
        title: Text('My Cart'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                itemCount: provider.totalItemsInCart,
                itemBuilder: (context, index) {
                  final cartM = provider.cartList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: CartItem(
                        onIncrease: () {
                          provider.increaseQuantity(cartM);
                        },
                        onDecrease: () {
                          provider.decreaseQuantity(cartM);
                        },
                        onDelate: () {
                          provider.removeFromCart(cartM.productId!);
                        },
                        cartModel: cartM,
                        priceWithQuantity:
                            provider.itemPriceWithQuantity(cartM)),
                  );
                },
              ),
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 12, left: 20, right: 15),
                    child: Text(
                      'Subtotal :  $currencySymbol${provider.getCartSubTotal()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(CheakoutPage.routeName),
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
                              'CheakOut',
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
            )
          ],
        ),
      ),
    );
  }
}
