// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:e_commerce__user/model/product_model.dart';
import 'package:flutter/material.dart';
import '../pages/product_details_page.dart';
import '../untils/constransts.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;
  bool isFavorite = false;
  bool added = false;

  ProductItem({
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(ProductDetailsPage.routeName,
              arguments: productModel.id);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
              color: Colors.white),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    isFavorite
                        ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                        : Icon(Icons.favorite_border, color: Color(0xFFEF7532))
                  ])),
              Hero(
                  tag: productModel.imageUrl!,
                  child: Container(
                      height: 75.0,
                      width: 75.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(productModel.imageUrl!),
                              fit: BoxFit.contain)))),
              SizedBox(height: 7.0),
              Text('$currencySymbol ${productModel.salePrice.toString()}',
                  style: TextStyle(color: Color(0xFFCC8053), fontSize: 14.0)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(productModel.name!,
                    style: TextStyle(
                        color: Color(0xFF575E67),
                        fontSize: 14.0,
                        overflow: TextOverflow.ellipsis)),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.shopping_basket,
                        color: Color(0xFFD17E50), size: 13.0),
                    Text('Add to cart',
                        style:
                            TextStyle(color: Color(0xFFD17E50), fontSize: 12.0))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
