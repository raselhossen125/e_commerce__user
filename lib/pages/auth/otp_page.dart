// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, deprecated_member_use, prefer_is_empty, non_constant_identifier_names, unused_local_variable

import 'package:e_commerce__user/auth/auth_service.dart';
import 'package:e_commerce__user/pages/auth/phone_verify.dart';
import 'package:e_commerce__user/pages/auth/register_page.dart';
import 'package:e_commerce__user/untils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class OtpPage extends StatefulWidget {
  static const routeName = 'otp';

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String text = '';
  bool isLoading = false;
  late String phoneNumber;

  @override
  void didChangeDependencies() {
    phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }

  void _onKeyboardTap(String value) {
    setState(() {
      if (text.length < 6) {
        text = text + value;
      }
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: TextStyle(color: Colors.black),
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 11, 148, 98).withAlpha(200),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_left_outlined,
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Enter 6 digits verification code sent to your number',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  otpNumberWidget(0),
                  otpNumberWidget(1),
                  otpNumberWidget(2),
                  otpNumberWidget(3),
                  otpNumberWidget(4),
                  otpNumberWidget(5),
                ],
              ),
              Spacer(),
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
                          'Confirm',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: InkWell(
                            onTap: () {
                              verifyPhone();
                            },
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(
                                          255, 11, 148, 98),
                                    ),
                                    child: Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      color: Colors.white,
                                    )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              NumericKeyboard(
                onKeyboardTap: _onKeyboardTap,
                textColor: appColor.cardColor,
                rightIcon: Icon(
                  Icons.backspace,
                  color: appColor.cardColor,
                ),
                rightButtonFn: () {
                  setState(() {
                    if (text.length != 0) {
                      text = text.substring(0, text.length - 1);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyPhone() {
    setState(() {
      isLoading = true;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: vId,
      smsCode: text,
    );
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      AuthService.user!.delete();
      AuthService.logOut();
      Navigator.pushReplacementNamed(context, RegisterPage.routeName,
          arguments: phoneNumber,);
      setState(() {
        isLoading = false;
      });
    });
  }
}
