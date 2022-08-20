// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, sort_child_properties_last, unused_field, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers

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

class _ProductsPageState extends State<ProductsPage>
    with SingleTickerProviderStateMixin {
  late ProductProvider provider;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: 3, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    provider = Provider.of<ProductProvider>(context, listen: false);
    provider.getAllProducts();
    provider.getAllcategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TabController _tabController =
    //     TabController(length: provider.categoryNameList.length, vsync: this);
    return Scaffold(
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
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.transparent,
                      labelColor: appColor.cardBtnColor,
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(right: 15.0, left: 10),
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          child: Text('All',
                              style: TextStyle(
                                fontSize: 18.0,
                              )),
                        ),
                        // ListView.builder(
                        //     itemCount: provider.categoryNameList.length,
                        //     itemBuilder: (context, index) {
                        //       print(provider.categoryNameList.length);
                        //       return Tab(
                        //         child: Text(provider.categoryNameList[index],
                        //             style: TextStyle(
                        //               fontSize: 18.0,
                        //             )),
                        //       );
                        //     }),
                        // Tab(
                        //   child: Text('All',
                        //       style: TextStyle(
                        //         fontSize: 18.0,
                        //       )),
                        // ),
                        Tab(
                          child: Text('Laptop',
                              style: TextStyle(
                                fontSize: 18.0,
                              )),
                        ),
                        Tab(
                          child: Text('Smart Phone',
                              style: TextStyle(
                                fontSize: 18.0,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height - 193,
                      child: TabBarView(controller: _tabController, children: [
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            itemCount: provider.productList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 15.0,
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.88),
                            itemBuilder: (context, index) {
                              final product = provider.productList[index];
                              return ProductItem(productModel: product);
                            },
                          ),
                        ),
                        Center(child: Text('Laptop')),
                        Center(child: Text('Smart Phone')),
                      ]))
                ],
              )
            : Center(
                child: Text('No Products Found'),
              ),
      ),
    );
  }
}
