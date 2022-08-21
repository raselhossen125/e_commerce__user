// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, sort_child_properties_last, unused_field, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, unused_element, avoid_unnecessary_containers

import 'package:e_commerce__user/pages/cart_page.dart';
import 'package:e_commerce__user/provider/cart_provider.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:e_commerce__user/widgets/product_item.dart';
import 'package:e_commerce__user/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../widgets/badge.dart';
import '../widgets/main_dawer.dart';

class ProductsPage extends StatefulWidget {
  static const routeName = '/products';

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductProvider proProvider;
  late CartProvider cartProvider;
  int chipValue = 0;

  @override
  void didChangeDependencies() {
    proProvider = Provider.of<ProductProvider>(context, listen: false);
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    proProvider.getAllProducts();
    proProvider.getAllcategories();
    proProvider.getAllFeaturedProducts();
    cartProvider.getAllCartItems();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, provider, child) => Badge(
              color: Colors.red,
              value: provider.totalItemsInCart.toString(),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartPage.routeName);
                },
                icon: Icon(Icons.shopping_cart),
              ),
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (provider.featuredProductList.isNotEmpty) MySlider(),
            Padding(
              padding: EdgeInsets.only(
                top: 8,
                left: 10,
                bottom: 5,
              ),
              child: Text(
                'Categories',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.categoryNameList.length,
                itemBuilder: (context, index) {
                  final data = provider.categoryNameList[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 5, left: 10),
                    child: ChoiceChip(
                      elevation: 5,
                      labelStyle: TextStyle(
                        color: appColor.cardColor,
                      ),
                      selectedColor: appColor.cardBtnColor,
                      label: Text(data),
                      selected: chipValue == index,
                      onSelected: (value) {
                        setState(() {
                          chipValue = value ? index : 0;
                        });
                        if (chipValue == 0) {
                          provider.getAllProducts();
                        } else {
                          provider.getAllProductsByCategory(
                              provider.categoryNameList[chipValue]);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            proProvider.productList.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: provider.productList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 15.0,
                          crossAxisCount: 2,
                          childAspectRatio: 0.86),
                      itemBuilder: (context, index) {
                        final product = provider.productList[index];
                        return ProductItem(productModel: product);
                      },
                    ),
                  )
                : Center(
                    child: Text('No Products Found'),
                  ),
          ],
        ),
      ),
    );
  }
}
