// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';
import '../provider/product_provider.dart';
import '../untils/constransts.dart';
import '../untils/helper_function.dart';

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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {

                          },
                          child: Chip(
                            backgroundColor: appColor.cardColor,
                            labelStyle: TextStyle(color: Colors.white),
                            label: Text('Re-Purchase'),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {

                          },
                          child: Chip(
                            backgroundColor: appColor.cardColor,
                            labelStyle: TextStyle(color: Colors.white),
                            label: Text('Purchase History'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(product.name!),
                    trailing: IconButton(
                      onPressed: () {

                      },
                      icon: Icon(
                        Icons.edit,
                        color: appColor.cardColor,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('$currencySymbol${product.salePrice}'),
                    trailing: IconButton(
                      onPressed: () {

                      },
                      icon: Icon(
                        Icons.edit,
                        color: appColor.cardColor,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(product.descripton ?? 'Not Available'),
                    trailing: IconButton(
                      onPressed: () {

                      },
                      icon: Icon(
                        Icons.edit,
                        color: appColor.cardColor,
                      ),
                    ),
                  ),
                  SwitchListTile(
                    activeColor: appColor.cardColor,
                    inactiveTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.grey.withOpacity(0.3),
                    title: Text('Available'),
                    value: product.available,
                    onChanged: (value) {
                      provider.updateproduct(
                          product.id!, ProductAvailable, value);
                    },
                  ),
                  SwitchListTile(
                    activeColor: appColor.cardColor,
                    inactiveTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.grey.withOpacity(0.3),
                    title: Text('Featured'),
                    value: product.featured,
                    onChanged: (value) {
                      provider.updateproduct(
                          product.id!, ProductFeatured, value);
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

  void _showPurchaseHistoryBootomSheer(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) =>
          Consumer<ProductProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            SizedBox(height: 15),
            Text(
              'Purchase History',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: appColor.cardColor),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.purchaseListOfSpecefixProduct.length,
                itemBuilder: (context, index) {
                  final purModel =
                      provider.purchaseListOfSpecefixProduct[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: ListTile(
                        title: Text(getFormatedDateTime(
                            purModel.dateModel.timestamp.toDate(),
                            'dd/MM/yyyy')),
                        subtitle: Text('Qunatity: ${purModel.productQuantity}'),
                        trailing:
                            Text('$currencySymbol${purModel.purchasePrice}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
