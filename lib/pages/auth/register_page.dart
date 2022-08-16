// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:e_commerce__user/untils/colors.dart';
import 'package:e_commerce__user/widgets/new_product_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'otp_page.dart';

String vId = '';

class RegisterPage extends StatelessWidget {
  static const routeName = 'register';
  final phoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 220,
                            constraints: const BoxConstraints(maxWidth: 500),
                            margin: const EdgeInsets.only(top: 100),
                            decoration: const BoxDecoration(
                                color: Color(0xFFE1E0F5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                        ),
                        Center(
                          child: Container(
                              constraints: const BoxConstraints(maxHeight: 320),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Image.asset('images/register.png')),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('TheGorgeousOtp',
                          style: TextStyle(
                              color: appColor.cardColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w800))),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'We will send you an ',
                            style: TextStyle(
                              color: appColor.cardColor,
                            )),
                        TextSpan(
                            text: 'One Time otp code ',
                            style: TextStyle(
                                color: appColor.cardColor,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'on this mobile number',
                            style: TextStyle(
                              color: appColor.cardColor,
                            )),
                      ]),
                    ),
                  ),
                  SizedBox(height: 15),
                  NewProductTextField(
                    controller: phoneController,
                    hintText: 'Enter your mobile number',
                    prefixIcon: Icons.phone,
                    keyBordType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),
                  Card(
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: InkWell(
                                  onTap: () {
                                    _veryficationPhoneNumber();
                                    Navigator.of(context)
                                        .pushNamed(OtpPage.routeName)
                                        .then((_) {
                                      phoneController.clear();
                                    });
                                  },
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 11, 148, 98),
                                      ),
                                      child: Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _veryficationPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationid, int? resendToken) {
        vId = verificationid;
      },
      codeAutoRetrievalTimeout: (String verificationid) {},
    );
  }
}
