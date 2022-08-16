// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'package:e_commerce__user/untils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import 'launcher_page.dart';

class LogInPage extends StatefulWidget {
  static const routeName = 'log-in';

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool passObsecure = true;
  String error = '';
  final formkey = GlobalKey<FormState>();

  final email_Controller = TextEditingController();
  final password_Controller = TextEditingController();

  @override
  void dispose() {
    email_Controller.dispose();
    password_Controller.dispose();
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
                  const SizedBox(height: 20),
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
                    child: Image.asset('images/login1.jpg'),
                  ),
                  const SizedBox(height: 25),
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email_Controller,
                          cursorColor: appColor.cardColor,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: appColor.cardColor,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            contentPadding: EdgeInsets.only(left: 10),
                            focusColor: Colors.grey.withOpacity(0.1),
                            prefixIcon: Icon(
                              Icons.email,
                              color: appColor.cardColor,
                            ),
                            hintText: "Enter Email",
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
                        const SizedBox(height: 15),
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
                  SizedBox(height: 5),
                  InkWell(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      authenticate();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: appColor.cardColor,
                      ),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 45,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 20),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Not Yet Registered? Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      onPressed: () {

                      },
                    ),
                  ),
                  const SizedBox(height: 20),
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
        final status = await AuthService.logIn(email_Controller.text, password_Controller.text);
        if(status) {
          Navigator.of(context).pushReplacementNamed(LauncherPage.routeName);
        }
        return;
      } on FirebaseAuthException catch (e) {
        setState(() {
          error = e.message!;
        });
      }
    }
  }
}
