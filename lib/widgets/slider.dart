// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce__user/provider/product_provider.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MySlider extends StatefulWidget {
  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: provider.featuredProductList.length,
            itemBuilder: (context, index, realIndex) {
              final product = provider.featuredProductList[index];
              return Container(
                margin: EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.2)),
                    color: Colors.white),
                child: Stack(
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: 'images/product.jpg',
                      image: product.imageUrl!,
                      fadeInCurve: Curves.bounceInOut,
                      fadeInDuration: Duration(seconds: 2),
                      width: double.infinity,
                      height: 170,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      right: 10,
                      child: Chip(
                        backgroundColor: Colors.transparent,
                        elevation: 1,
                        label: Text(product.name!),
                      ),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: 170,
              aspectRatio: 16 / 9,
              viewportFraction: 0.95,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
          ),
          SizedBox(height: 8),
          buildIndicator(provider.featuredProductList.length),
        ],
      ),
    );
  }

  Widget buildIndicator(int length) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: length,
        effect: ScrollingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          dotColor: Colors.grey.withOpacity(0.6),
          activeDotColor: appColor.cardColor,
        ),
      );
}
