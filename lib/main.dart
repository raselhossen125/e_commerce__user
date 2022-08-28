// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:e_commerce__user/pages/auth/otp_page.dart';
import 'package:e_commerce__user/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'pages/auth/phone_verify.dart';
import 'pages/auth/register_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'pages/launcher_page.dart';
import 'pages/auth/logIn_page.dart';
import 'pages/order_successful_page.dart';
import 'pages/product_details_page.dart';
import 'pages/products_page.dart';
import 'pages/profile_page.dart';
import 'pages/user_address_page.dart';
import 'provider/cart_provider.dart';
import 'provider/order_provider.dart';
import 'provider/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 39, 131, 97),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, Color> pokeballRedSwatch = {
      50: Color.fromARGB(255, 24, 1, 105),
      100: Color.fromARGB(255, 255, 88, 88),
      200: Color.fromARGB(255, 255, 88, 88),
      300: Color.fromARGB(255, 255, 88, 88),
      400: Color.fromARGB(255, 255, 88, 88),
      500: Color.fromARGB(255, 255, 88, 88),
      600: Color.fromARGB(255, 255, 88, 88),
      700: Color.fromARGB(255, 255, 88, 88),
      800: Color.fromARGB(255, 255, 88, 88),
      900: Color.fromARGB(255, 252, 70, 70),
    };
    MaterialColor pokeballRed = MaterialColor(0xff278361, pokeballRedSwatch);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: pokeballRed,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => LauncherPage(),
        LogInPage.routeName: (_) => LogInPage(),
        PhoneVerifyPage.routeName: (_) => PhoneVerifyPage(),
        RegisterPage.routeName: (_) => RegisterPage(),
        OtpPage.routeName: (_) => OtpPage(),
        ProductsPage.routeName: (_) => ProductsPage(),
        ProductDetailsPage.routeName: (_) => ProductDetailsPage(),
        ProfilePage.routeName: (_) => ProfilePage(),
        CartPage.routeName: (_) => CartPage(),
        CheckoutPage.routeName: (_) => CheckoutPage(),
        UserAddressPage.routeName: (_) => UserAddressPage(),
        OrderSuccessfulPage.routeName: (_) => OrderSuccessfulPage(),
      },
    );
  }
}
