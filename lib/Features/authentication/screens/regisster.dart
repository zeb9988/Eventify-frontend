import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/authentication/services/authservices.dart';
import 'package:eventify/common/widgets/customtextfeild.dart';
import 'package:eventify/features/authentication/widget/check_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../UserHome/widgets/button.dart';
import 'Login.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Replace HomeScreen with your actual home screen widget
class Register extends StatefulWidget {
  static const String id = '/Register';

  @override
  State<Register> createState() => _RegisterState();
}

final AuthService auth = AuthService();
bool isCheckboxChecked = false;

class _RegisterState extends State<Register> {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();

  final TextEditingController confirmpass = TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();

  // final TextEditingController pass = TextEditingController();
  // String? passwordMatchValidator(String? value) {
  //   if (value != pass.text) {
  //     return "Passwords do not match";
  //   }
  //   return null;
  // }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    fullname.dispose();
  }

  void usersignup() {
    auth.signUpUser(
        context: context,
        email: email.text,
        // password: pass.text,
        name: fullname.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF2F2F2),
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo2.png',
                  height: 100,
                ),
              ),
              Text(
                'Create Account',
                style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Your full name will appear only on the profile',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 1.4),
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: signUpFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      is_pass: false,
                      hintText: 'Full name',
                      icon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      controller: fullname,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextField(
                      hintText: 'Enter Your Valid Email',
                      controller: email,
                      icon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      is_pass: false,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TCheckbox(
                              value: isCheckboxChecked,
                              onChanged: (value) {
                                isCheckboxChecked = !isCheckboxChecked;
                                print('Checkbox State: $isCheckboxChecked');
                              }),
                          const SizedBox(
                            width: 16,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'I agree with the',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF999999),
                                    height: 1.43,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms of service',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF4C2000),
                                      height: 1.43,
                                      decoration: TextDecoration.underline),
                                ),
                                TextSpan(
                                  text: ' &\n',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF999999),
                                    height: 1.43,
                                  ),
                                ),
                                TextSpan(
                                  text: 'privacy policy',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF4C2000),
                                      height: 1.43,
                                      decoration: TextDecoration.underline),
                                ),
                                TextSpan(
                                  text: '  of Eventify',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF999999),
                                    height: 1.43,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Button(
                      onPressed: () {
                        if (signUpFormKey.currentState!.validate()) {
                          if (isCheckboxChecked) {
                            usersignup();
                          } else {
                            // Show a dialog if the checkbox is not checked
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Agreement Required'),
                                  content: Text(
                                      'Please agree to the Terms of Service and Privacy Policy before continuing.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: COLOR_ACCENT),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      minimumSize: const Size(double.maxFinite, 64),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF999999)),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero)),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Login.id);
                      email.clear();
                    },
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color: Color(0xFF4C2000)),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
