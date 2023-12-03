import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constant/Theme_constant.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        // leftDotColor: COLOR_ACCENT,
        //  rightDotColor: Colors.black,
        color:COLOR_ACCENT ,
        size: 40,
      ),);
  }
}
