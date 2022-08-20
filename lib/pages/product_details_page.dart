// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:flutter/material.dart';
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
                    height: height * 0.40,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    height: height * 0.51,
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
                          Text(
                            '$currencySymbol ${product.salePrice}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
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
                  Container(
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
                                    child: Text(
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
}
