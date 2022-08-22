// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce__user/model/cart_model.dart';
import 'package:flutter/material.dart';

import '../untils/constransts.dart';

class CartItem extends StatelessWidget {
  final CartModel cartModel;
  final num priceWithQuantity;
  final VoidCallback onIncrease, onDecrease, onDelate;

  CartItem({
    required this.cartModel,
    required this.priceWithQuantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 120,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.network(
                        cartModel.imageUrl!,
                        height: 70,
                        width: 70,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.grey.withOpacity(0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              cartModel.productName!,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(height: 7),
                          Text('$currencySymbol ${priceWithQuantity}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: onDecrease,
                                child: Chip(
                                  elevation: 5,
                                  label: Text('-'),
                                ),
                              ),
                              Text(cartModel.quantity.toString()),
                              InkWell(
                                onTap: onIncrease,
                                child: Chip(
                                  elevation: 5,
                                  label: Text('+'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      '$currencySymbol${cartModel.salePrice}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onDelate,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
