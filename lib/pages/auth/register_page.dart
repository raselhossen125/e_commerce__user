// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, sized_box_for_whitespace

import 'package:e_commerce__user/untils/colors.dart';
import 'package:e_commerce__user/widgets/new_product_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../auth/auth_service.dart';
import '../launcher_page.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String phoneNumber;
  bool passObsecure = true;
  String error = '';
  final formkey = GlobalKey<FormState>();

  final email_Controller = TextEditingController();
  final password_Controller = TextEditingController();
  final name_Controller = TextEditingController();
  final phone_Controller = TextEditingController();

  @override
  void didChangeDependencies() {
    final phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
    phone_Controller.text = phoneNumber;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    email_Controller.dispose();
    password_Controller.dispose();
    name_Controller.dispose();
    phone_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome User',
                    style: TextStyle(
                      color: appColor.cardColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset('images/register.jpg'),
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        NewProductTextField(
                          controller: name_Controller,
                          hintText: 'Enter name',
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(height: 15),
                        NewProductTextField(
                          controller: phone_Controller,
                          hintText: 'Enter phone',
                          prefixIcon: Icons.phone,
                          enable: false,
                        ),
                        SizedBox(height: 15),
                        NewProductTextField(
                          controller: email_Controller,
                          hintText: 'Enter email',
                          prefixIcon: Icons.email,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: password_Controller,
                          obscureText: passObsecure,
                          cursorColor: appColor.cardColor,
                          style: TextStyle(
                              color: appColor.cardColor,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            errorText: error,
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            contentPadding: EdgeInsets.only(left: 10),
                            focusColor: Colors.grey.withOpacity(0.1),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: appColor.cardColor,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                passObsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: appColor.cardColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  passObsecure = !passObsecure;
                                });
                              },
                            ),
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      authenticate();
                    },
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
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 5),
                  //   child: Container(
                  //     height: 45,
                  //     width: double.infinity,
                  //     margin: EdgeInsets.only(bottom: 30),
                  //     child: OutlinedButton(
                  //       style: OutlinedButton.styleFrom(
                  //         primary: Colors.black,
                  //         backgroundColor: Colors.white,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(7),
                  //         ),
                  //         side: BorderSide(
                  //           color: Colors.grey.withOpacity(0.5),
                  //           width: 1,
                  //         ),
                  //       ),
                  //       child: Text(
                  //         'Not Yet Registered? Sign Up',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 18,
                  //             color: Colors.black),
                  //       ),
                  //       onPressed: () {
                  //         Navigator.of(context)
                  //             .pushNamed(PhoneVerifyPage.routeName);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // Text(
                  //   'OR',
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 18),
                  // ),
                  // const SizedBox(height: 15),
                  // Image.asset(
                  //   'images/google.png',
                  //   height: 40,
                  //   width: 40,
                  //   fit: BoxFit.cover,
                  // ),
                  // const SizedBox(height: 15),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  authenticate() async {
    if (formkey.currentState!.validate()) {
      try {
        AuthService.register(
          name_Controller.text,
          email_Controller.text,
          phone_Controller.text,
          password_Controller.text,
        ).then((value) {
          Navigator.pushNamedAndRemoveUntil(context, LauncherPage.routeName, (route) => false);
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          error = e.message!;
        });
      }
    }
  }
}
