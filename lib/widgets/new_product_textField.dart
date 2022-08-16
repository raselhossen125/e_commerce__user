// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:e_commerce__user/untils/colors.dart';
import 'package:flutter/material.dart';

class NewProductTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  IconData prefixIcon;
  TextInputType? keyBordType;

  NewProductTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyBordType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBordType,
      controller: controller,
      cursorColor: appColor.cardColor,
      style: TextStyle(color: appColor.cardColor, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        contentPadding: EdgeInsets.only(left: 10),
        focusColor: Colors.grey.withOpacity(0.1),
        prefixIcon: Icon(
          prefixIcon,
          color: appColor.cardColor,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field must not be empty';
        }
        return null;
      },
    );
  }
}
