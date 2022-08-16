// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import 'auth/logIn_page.dart';
import 'products_page.dart';

class LauncherPage extends StatefulWidget {
  static const routeName = '/launcher';

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (AuthService.user == null) {
        Navigator.pushReplacementNamed(context, LogInPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, ProductsPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
