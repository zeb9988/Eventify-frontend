import 'package:eventify/constant/Theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({Key? key}) : super(key: key);

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  final List<String> slidersList = [
    'assets/images/baner1.png',
    'assets/images/baner2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return VxSwiper.builder(
        aspectRatio: 16 / 9,
        autoPlay: true,
        height: 150,
        enlargeCenterPage: true,
        itemCount: slidersList.length,
        itemBuilder: (context, index) {
          return Image.asset(
            slidersList[index],
            fit: BoxFit.cover, // Adjust the BoxFit as per your requirement
          )
              .box
              .rounded
              .clip(Clip.antiAlias)
              .margin(const EdgeInsets.symmetric(horizontal: 8))
              .size(300, 150) // Set a constant size for the picture
              .make();
        });
  }
}
