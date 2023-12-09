import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Common/widgets/button.dart';

Widget socialButton(
    {required String text,
    required String icon,
    required Color color,
    bool png = false,
    Size? minimumSize,
    void Function()? onPressed,
    bool isWhiteColor = false}) {
  return Button(
      onPressed: onPressed,
      // backgroundColor: color,
      // radius: 64,
      minimumSize: minimumSize ?? const Size(double.maxFinite, 64),
      child: Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          if (png) ...[Image.asset(icon)] else ...[SvgPicture.asset(icon)],
          SizedBox(
            width: minimumSize != null ? 12 : 32,
          ),
          Text(
            text,
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isWhiteColor ? Colors.white : Colors.black),
          ),
        ],
      ));
}
