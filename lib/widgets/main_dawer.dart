// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables


import 'package:e_commerce__user/untils/colors.dart';
import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../pages/launcher_page.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: appColor.cardColor,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      AuthService.logOut();
                      Navigator.of(context)
                          .pushReplacementNamed(LauncherPage.routeName);
                    },
                    leading: Icon(
                      Icons.logout,
                      color: appColor.cardColor,
                    ),
                    title: Text('Log Out'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
