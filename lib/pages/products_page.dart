// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, sort_child_properties_last, unused_field, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, unused_element

import 'package:e_commerce__user/untils/colors.dart';
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
  int chipValue = 0;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Products'),
      ),
      drawer: MainDrawer(),
      body: Consumer<ProductProvider>(
        builder: (context, proProvider, child) => proProvider
                .productList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 10, bottom: 5),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.categoryList.length,
                      itemBuilder: (context, index) {
                        final data = provider.categoryNameList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 5, left: 10),
                          child: ChoiceChip(
                            labelStyle: TextStyle(
                              color: appColor.cardColor,
                            ),
                            selectedColor: Colors.grey.withAlpha(400),
                            label: Text(data),
                            selected: chipValue == index,
                            onSelected: (value) {
                              setState(() {
                                chipValue = value ? index : 0;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
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
                ],
              )
            : Center(
                child: Text('No Products Found'),
              ),
      ),
    );
  }
}
