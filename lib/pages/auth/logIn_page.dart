// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/model/user_model.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../auth/auth_service.dart';
import '../launcher_page.dart';
import 'phone_verify.dart';

class LogInPage extends StatefulWidget {
  static const routeName = 'log-in';

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool passObsecure = true;
  String error = '';
  bool isLoading = false;
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
                  Text(
                    'Welcome User',
                    style: TextStyle(
                      color: appColor.cardColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  SizedBox(height: 35),
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
                          child: isLoading ? CircularProgressIndicator(color: Colors.white,) : Text(
                            'Log In',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 30),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          side: BorderSide(
                            color: appColor.cardBtnColor,
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
                          Navigator.of(context)
                              .pushNamed(PhoneVerifyPage.routeName);
                        },
                      ),
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      signInWithGoogle().then((value) {
                        if (value.user != null) {
                          final userModel = UserModel(
                            uId: value.user!.uid,
                            name: value.user!.displayName ?? 'Not Available',
                            mobile: value.user!.phoneNumber ?? 'Not Available',
                            email: value.user!.email!,
                            image: value.user!.photoURL,
                            userCreationTime: Timestamp.fromDate(
                                value.user!.metadata.creationTime!),
                          );
                          AuthService.addUser(userModel).then((value) {
                            Navigator.of(context).pushReplacementNamed(LauncherPage.routeName);
                          });
                        }
                      }).catchError((e) {
                        setState(() {
                          error = e.toString();
                        });
                      });
                    },
                    child: Image.asset(
                      'images/google.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 15),
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
        final status = await AuthService.logIn(
            email_Controller.text, password_Controller.text);
        if (status) {
          isLoading = true;
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
