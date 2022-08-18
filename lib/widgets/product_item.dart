// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce__user/model/product_model.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:flutter/material.dart';

import '../pages/product_details_page.dart';
import '../untils/constransts.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;

  ProductItem({
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailsPage.routeName,
            arguments: productModel.id);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  productModel.imageUrl!,
                  height: 130,
                  width: 150,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productModel.name!,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '$currencySymbol${productModel.salePrice.toString()}',
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shopping_cart,
                        color: appColor.cardBtnColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
