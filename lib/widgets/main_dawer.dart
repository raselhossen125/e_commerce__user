// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:e_commerce__user/pages/products_page.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../pages/launcher_page.dart';
import '../pages/profile_page.dart';

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
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthService.user!.photoURL == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'images/person.png',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            AuthService.user!.photoURL!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                  SizedBox(height: 10),
                  Text(
                    AuthService.user!.displayName ?? 'Not Available',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    AuthService.user!.email ?? 'Not Available',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ProfilePage.routeName)
                          .then((value) {
                        Navigator.pushReplacementNamed(
                            context, ProductsPage.routeName);
                      });
                    },
                    leading: Icon(
                      Icons.person,
                      color: appColor.cardColor,
                    ),
                    title: Text('My Profile'),
                  ),
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
