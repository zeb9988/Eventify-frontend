import 'package:eventify/Language/language_constants.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/authentication/screens/Login.dart';
import 'package:eventify/features/home/widgets/language_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../authentication/screens/regisster.dart';
import '../widgets/globle_widgets.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 40, bottom: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Register.id);
                      },
                      child: Text(
                        translation(context).signup,
                        // context.l10n.signup,
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD6A95C)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    LanguageMenu(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/logos.png',
                  // width: double.maxFinite,
                  width: 300,
                ),
                // socialButton(
                //     text: 'Continue with Google',
                //     color: Color(0xFFFFFFFF),
                //     png: true,
                //     icon: 'assets/images/Google.png'),
                const SizedBox(
                  height: 8,
                ),
                socialButton(
                    text: AppLocalizations.of(context)!.continuewithemail,
                    color: Color(0xFFD6A95C),
                    icon: 'assets/images/email.svg',
                    onPressed: () {
                      Navigator.pushNamed(context, Login.id);
                    }),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  AppLocalizations.of(context)!.bycontinue,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      color: Colors.black.withOpacity(0.5)),
                  textAlign: TextAlign.center,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.topCenter,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.terms,
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.and,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                          color: Colors.black.withOpacity(0.5)),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.topCenter),
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.policy,
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
