// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:e_commerce__user/widgets/new_product_textField.dart';
import 'package:flutter/material.dart';

class UserAddressPage extends StatefulWidget {
  static const routeName = '/userAddress';

  @override
  State<UserAddressPage> createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  final addressController = TextEditingController();
  final zipController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set address'),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            NewProductTextField(
              controller: addressController,
              hintText: 'Address',
              prefixIcon: Icons.person,
            ),
            NewProductTextField(
              controller: zipController,
              hintText: 'zipp',
              prefixIcon: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
