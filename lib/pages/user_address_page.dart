// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable

import 'package:e_commerce__user/model/address_model.dart';
import 'package:e_commerce__user/provider/user_provider.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:e_commerce__user/untils/helper_function.dart';
import 'package:e_commerce__user/widgets/new_product_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../model/user_model.dart';

class UserAddressPage extends StatefulWidget {
  static const routeName = '/userAddress';

  @override
  State<UserAddressPage> createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  final addressController = TextEditingController();
  final zipController = TextEditingController();
  late UserProvider userProvider;
  final formkey = GlobalKey<FormState>();
  bool isInit = true;
  String? city, area;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      userProvider = Provider.of<UserProvider>(context);
      userProvider.getAllCities();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    addressController.dispose();
    zipController.dispose();
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
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            NewProductTextField(
              controller: addressController,
              hintText: 'Streat Address',
              prefixIcon: Icons.place,
            ),
            SizedBox(height: 15),
            NewProductTextField(
              controller: zipController,
              hintText: 'zip code',
              prefixIcon: Icons.circle,
              keyBordType: TextInputType.number,
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: DropdownButtonFormField<String>(
                value: city,
                hint: Text('Select city'),
                items: userProvider.cityList
                    .map((cityM) => DropdownMenuItem<String>(
                          value: cityM.name,
                          child: Text(cityM.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    city = value;
                  });
                },
                validator: (value) {},
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: DropdownButtonFormField<String>(
                value: area,
                hint: Text('Select area'),
                items: userProvider
                    .getAreaByCityName(city)
                    .map((area) => DropdownMenuItem<String>(
                          value: area,
                          child: Text(area),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    area = value;
                  });
                },
                validator: (value) {},
              ),
            ),
            SizedBox(height: 25),
            InkWell(
              onTap: _save,
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: appColor.cardColor,
                  ),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Save',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    if (formkey.currentState!.validate()) {
      isLoading = true;
      if (city == null) {
        showMsg(context, 'Please select city');
        isLoading = false;
        return;
      }
      if (area == null) {
        showMsg(context, 'Please select area');
        isLoading = false;
        return;
      }
      final addresM = AddressModel(
        streetAddress: addressController.text,
        area: area!,
        city: city!,
        zipCode: int.parse(zipController.text),
      );
      userProvider.updateProfile(
        AuthService.user!.uid,
        {userAddressModel: addresM.toMap()},
      ).then((value) {
        Navigator.of(context).pop();
      }).catchError((error) {
        isLoading = false;
        throw error;
      });
    }
  }
}
