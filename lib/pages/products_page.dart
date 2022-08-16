// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../untils/constransts.dart';
import '../widgets/main_dawer.dart';
import 'product_details_page.dart';

class ProductsPage extends StatelessWidget {
  static const routeName = '/products';

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      drawer: MainDrawer(),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) => provider.productList.isNotEmpty
            ? GridView.builder(
                itemCount: provider.productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 2 / 2.4),
                itemBuilder: (context, index) {
                  final product = provider.productList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          ProductDetailsPage.routeName,
                          arguments: product.id);
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
                              product.imageUrl!,
                              height: 140,
                              width: 140,
                              fit: BoxFit.contain,
                            )),
                            Spacer(),
                            Text(
                              product.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            Text(
                                '$currencySymbol${product.salePrice.toString()}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text('No Products Found'),
              ),
      ),
    );
  }
}
