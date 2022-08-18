// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, sort_child_properties_last

import 'package:e_commerce__user/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../widgets/main_dawer.dart';

class ProductsPage extends StatefulWidget {
  static const routeName = '/products';

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductProvider provider;
  @override
  void didChangeDependencies() {
    provider = Provider.of<ProductProvider>(context, listen: false);
    provider.getAllProducts();
    provider.getAllcategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      drawer: MainDrawer(),
      body: Consumer<ProductProvider>(
        builder: (context, proProvider, child) =>
            proProvider.productList.isNotEmpty
                ? GridView.builder(
                    padding: EdgeInsets.all(2),
                    itemCount: provider.productList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3),
                    itemBuilder: (context, index) {
                      final product = provider.productList[index];
                      return ProductItem(productModel: product);
                    },
                  )
                : Center(
                    child: Text('No Products Found'),
                  ),
      ),
    );
  }
}
