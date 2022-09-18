// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:e_commerce__user/untils/colors.dart';
import 'package:flutter/material.dart';

class OrderSuccessfulPage extends StatelessWidget {
  static const String routeName = '/order_successful';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appColor.cardColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Order Succesfully Done',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
              SizedBox(height: 50),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Color(0xffBFEED1),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Color(0xff01BA47),
                      child: Icon(
                        Icons.check_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
