// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/provider/order_provider.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:e_commerce__user/untils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';
import '../provider/product_provider.dart';
import '../untils/constransts.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = '/product-details';
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _appbar = AppBar(
      title: Text("Details"),
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back)),
    );

    final height = MediaQuery.of(context).size.height -
        (_appbar.preferredSize.height +
            MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);

    final pid = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: appColor.bgColor,
      appBar: _appbar,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.getProductById(pid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = ProductModel.fromMap(snapshot.data!.data()!);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'images/product.jpg',
                    image: product.imageUrl!,
                    fadeInCurve: Curves.bounceInOut,
                    fadeInDuration: Duration(seconds: 2),
                    width: double.infinity,
                    height: height * 0.38,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: height * 0.05,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Chip(label: Text('Add a comment')),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            final canRate = await Provider.of<OrderProvider>(
                                    context,
                                    listen: false)
                                .canUserRateProduct(pid);
                            if (canRate) {
                              _showRatingBarDialog(
                                context,
                                product,
                                (value) async {
                                  await provider.addNewRating(value, pid);
                                },
                              );
                            } else {
                              showMsg(context, 'You can not rate');
                            }
                          },
                          child: Chip(label: Text('Rate this product')),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    height: height * 0.46,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$currencySymbol ${product.salePrice}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Rating : ${product.rating}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.0250),
                          Expanded(
                            child: Text(
                              product.descripton ?? 'Not Available',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                              softWrap: false,
                              maxLines: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer(
                    builder: (context, cartProvider, child) {
                      // final isInCart = provider.isInCart(productModel.id!);
                      return Container(
                        height: height * 0.075,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Card(
                                    elevation: 7,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: appColor.cardColor,
                                      ),
                                      child: Center(
                                        child:
                                            // Text(
                                            //     isInCart
                                            //         ? 'Remove to cart'
                                            //         : 'Add to cart',
                                            //     style: TextStyle(
                                            //         color: appColor.cardColor,
                                            //         fontSize: 14.0))
                                            Text(
                                          'Add to cart',
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
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_outline,
                                  size: 25,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Failed'),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  void _showRatingBarDialog(BuildContext context, ProductModel productModel,
      Function(double) onRate) {
    double userRating = 0.0;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      )),
      context: context,
      builder: (context) => Container(
        height: 280,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Container(
                height: 5,
                width: 70,
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Text(
              'Rate ${productModel.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              itemSize: 40,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                userRating = rating;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 70, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      onRate(userRating);
                      Navigator.of(context).pop();
                    },
                    child: Text('Rate'),
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
