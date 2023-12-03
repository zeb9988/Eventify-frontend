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

              'assets/images/deal1.jpg',
              'assets/images/deal2.jpg',
    'assets/images/deal3.jpg'
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
        }
    );

    // return Column(
    //   children: [
    //     Container(
    //       child: CarouselSlider(
    //         options: CarouselOptions(
    //           height: 180,
    //           autoPlay: true,
    //           autoPlayInterval: Duration(seconds: 2),
    //           autoPlayCurve: Curves.easeInOut,
    //           enlargeCenterPage: true,
    //           onPageChanged: (index, reason) {
    //             setState(() {
    //               _currentIndex = index;
    //             });
    //           },
    //         ),
    //         items: [
    //           'assets/images/eve.jpg',
    //           'assets/images/eve_back2.jpg',
    //           'assets/images/eve_background.jpg'
    //         ].map((i) {
    //           return Container(
    //             decoration: BoxDecoration(
    //               image: DecorationImage(
    //                 image: AssetImage(i),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //             width: MediaQuery.of(context).size.width,
    //             margin: EdgeInsets.symmetric(horizontal: 5),
    //             child: Container(
    //               padding: EdgeInsets.all(12),
    //               color: Colors.black.withOpacity(0.5),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: <Widget>[
    //                   Text(
    //                     'Package Title',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   Text(
    //                     'Description',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                   ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                       backgroundColor: COLOR_ACCENT,
    //                     ),
    //                     onPressed: () {
    //                       // Add your action here
    //                     },
    //                     child: Text('Learn More'),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //     SizedBox(height: 10), // Spacer
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: List.generate(
    //         3,
    //         (index) => AnimatedContainer(
    //           duration: Duration(milliseconds: 300),
    //           width: 10.0,
    //           height: 10.0,
    //           margin: EdgeInsets.symmetric(horizontal: 5),
    //           decoration: BoxDecoration(
    //             shape: BoxShape.circle,
    //             color: _currentIndex == index
    //                 ? COLOR_ACCENT // Change the color when the index matches
    //                 : Colors.grey.withOpacity(0.5),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
