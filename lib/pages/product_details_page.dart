// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
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
    final pid = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.getProductById(pid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = ProductModel.fromMap(snapshot.data!.data()!);
              return ListView(
                children: [
                  SizedBox(height: 10),
                  FadeInImage.assetNetwork(
                    placeholder: 'images/product.jpg',
                    image: product.imageUrl!,
                    fadeInCurve: Curves.bounceInOut,
                    fadeInDuration: Duration(seconds: 3),
                    width: double.infinity,
                    height: 260,
                    fit: BoxFit.contain,
                  ),
                  ListTile(
                    title: Text(product.name!),
                  ),
                  ListTile(
                    title: Text('$currencySymbol${product.salePrice}'),
                  ),
                  ListTile(
                    title: Text(product.descripton ?? 'Not Available'),
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
