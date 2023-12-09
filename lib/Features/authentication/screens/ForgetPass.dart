import 'package:eventify/features/authentication/services/authservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/widgets/customtextfeild.dart';
import '../../../Common/widgets/button.dart';

class ForgetPass extends StatefulWidget {
  static const String id = '/ForgetPass';
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final Forfotpasskey = GlobalKey<FormState>();
  final TextEditingController forgetpass = TextEditingController();
  AuthService auth = AuthService();
  @override
  void dispose() {
    forgetpass.dispose();
    super.dispose();
  }

  void forgetPaasword() {
    auth.Forgetpassword(context: context, email: forgetpass.text);
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo2.png',
                height: 100,
                width: double.infinity,
              ),
              const SizedBox(
                height: 36,
              ),
              Text(
                "Forgot password ?",
                style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'No worries, we will send a reset intructions.',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                  key: Forfotpasskey,
                  child: Column(
                    children: [
                      CustomTextField(
                        is_pass: false,
                        hintText: 'Email / username',
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        controller: forgetpass,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Button(
                        onPressed: forgetPaasword,
                        minimumSize: const Size(double.maxFinite, 64),
                        child: Text(
                          'Reset password',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Go to',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF999999)),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(EdgeInsets.zero)),
                            onPressed: () {
                              Navigator.pop(context);
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
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
