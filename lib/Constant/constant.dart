// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../common/widgets/custombutton.dart';
import '../features/cart/cart_screen.dart';
import 'Theme_constant.dart';

List<String> productCategories = [
  'Photographer',
  'Videographer',
  'Catering',
  'Florists',
  'Entertainer',
  'Transportation Service',
  'Sound & Lighting',
  'Security Service',
  'Event Invitations and Printing',
  'Ticketing and Promotion',
  'Branding & Marketing',
  'Party Planner',
  'Event Planner',
  'Venues',
  'Wedding Planner',
  'Makeup Artist & Salon',
  'Mehndi Artist',
  'Decorator',
  'Jewelry Store',
  'Wedding Car Decorators',
  'Wedding Dress Boutique'
  // Add more categories as needed
];

String getWeatherAnimation(String? mainCondition) {
  if (mainCondition == null) {
    return 'assets/animation/sunny.json'; //default to sunny
  }
  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return 'assets/animation/cloud.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/animation/rain.json';
    case 'thunderstorm':
      return 'assets/animation/thunder.json';
    case 'clear':
      return 'assets/animation/sunny.json';
    default:
      return 'assets/animation/sunny.json';
  }
}

Future<List<File>> pickImages() async {
  List<File> images = [];

  try {
    var file = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (file != null && file.files.isNotEmpty) {
      for (int i = 0; i < file.files.length; i++) {
        images.add(File(file.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
//Top Event name list

List<Map<String, dynamic>> TopEventList = [
  {
    'image': 'assets/images/wedding1.png',
    'text': 'Wedding',
    'color': const Color.fromARGB(117, 187, 222, 251),
  },
  {
    'image': 'assets/images/birthday.png',
    'text': 'Birthday Party',
    'color':
        const Color.fromARGB(82, 255, 224, 178), // Add a color for the item
  },
  {
    'image': 'assets/images/event.png',
    'text': 'Corporate Event',
    'color': const Color.fromARGB(125, 200, 230, 201),
  },
  {
    'image': 'assets/images/concert.png',
    'text': 'Concert',
    'color': const Color.fromARGB(88, 255, 205, 210),
  },
  {
    'image': 'assets/images/party.png',
    'text': 'Private Party',
    'color': const Color.fromARGB(148, 255, 224, 178),
  },
  {
    'image': 'assets/images/eid.png',
    'text': 'Eid Celebration',
    'color': Colors.yellow, // Add a color for the item
  },
  {
    'image': 'assets/images/culture.png',
    'text': 'Cultural Festival',
    'color': Colors.teal, // Add a color for the item
  },
];

final List<String> States = [
  'Punjab',
  'Sindh',
  'Khyber Pakhtunkhwa',
  'Balochistan',
  'Gilgit-Baltistan'
  // Add more cities if needed
];

final List<String> cities = [
  'Karachi',
  'Lahore',
  'Faisalabad',
  'Rawalpindi',
  'Multan',
  'Gujranwala',
  'Sialkot',
  'Islamabad',
  'Quetta',
  'Peshawar',
  'Sargodha',
  'Bahawalpur',
  'Sukkur',
  'Jhang',
  'Sheikhupura',
  'Larkana',
  'Gujrat',
  'Mardan',
  'Kasur',
  'Rahim Yar Khan',
  'Sahiwal',
  'Okara',
  'Wah Cantt',
  'Dera Ghazi Khan',
  'Mingora',
  'Mirpur Khas',
  'Chiniot',
  'Nawabshah',
  'Kamoke',
  'Burewala',
  'Jhelum',
  'Sadiqabad',
  'Jacobabad',
  'Nowshera',
  'Hafizabad',
  'Kohat',
  'Muzaffarabad',
  'Khanewal',
  'Khairpur',
  'Dadu',
  'Gojra',
  'Mandi Bahauddin',
  'Tando Adam',
  'Khuzdar',
  'Gujar Khan',
  'Jaranwala',
  'Attock',
  'Loralai',
  'Kotli',
  'Bhakkar',
  'Kharian',
  'Leiah',
  'Kamalia',
  'Kharan',
  'Vihari',
  'Daska',
  'Narowal',
  'Umarkot',
  'Hassan Abdal',
  'Tank',
  'Rawala Kot',
  'Bagh',
  'Haveli Lakha',
  // Add more cities if needed
];
final List<String> countries = [
  'Afghanistan',
  'Albania',
  'Algeria',
  'Argentina',
  'Australia',
  'Bangladesh',
  'Brazil',
  'Canada',
  'China',
  'Egypt',
  'France',
  'Germany',
  'India',
  'Indonesia',
  'Iran',
  'Iraq',
  'Italy',
  'Japan',
  'Mexico',
  'Nigeria',
  'Pakistan',
  'Philippines',
  'Russia',
  'Saudi Arabia',
  'South Africa',
  'Spain',
  'Turkey',
  'United Kingdom',
  'United States',
  'Vietnam',
];

List<Map<String, dynamic>> Wedding = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Capture timeless moments with our skilled photographers, delivering exceptional visual storytelling for your special day.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Bring your wedding to life with our professional videography services, ensuring every moment is captured with cinematic precision.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Delight your guests with a culinary experience like no other, as our catering services redefine the art of gastronomy for your wedding.',
  },
  {
    'image': 'assets/images/flower.jpg',
    'text': 'Florists',
    'description':
        'Elevate your wedding with the beauty of nature, curated by our expert florists who design stunning floral arrangements for every aspect of your celebration.',
  },
  {
    'image': 'assets/images/car.jpeg',
    'text': 'Transportation Service',
    'description':
        'Experience seamless and stylish transportation services tailored to your wedding, ensuring a grand entrance for you and your guests.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Set the perfect ambiance with our state-of-the-art sound and lighting services, transforming your wedding into a sensory masterpiece.',
  },
  {
    'image': 'assets/images/security.jpg',
    'text': 'Security Service',
    'description':
        'Ensure the safety and well-being of your guests with our top-notch security services, providing peace of mind for your wedding.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Make a lasting impression with our custom event invitations and printing services, adding a touch of elegance to your wedding announcements.',
  },
  {
    'image': 'assets/images/wedding.jpg',
    'text': 'Wedding Planner',
    'description':
        'Experience stress-free wedding planning with our dedicated team, orchestrating seamless and unforgettable moments for your special day.',
  },
  {
    'image': 'assets/images/makeup.jpg',
    'text': 'Makeup Artist & Salon',
    'description':
        'Enhance your natural beauty with the expertise of our makeup artists and salon services, adding glamour to your wedding look.',
  },
  {
    'image': 'assets/images/mehndi.jpg',
    'text': 'Mehndi Artist',
    'description':
        'Adorn your hands with intricate henna designs by our skilled Mehndi artists, adding a touch of tradition and artistry to your wedding celebrations.',
  },
  {
    'image': 'assets/images/decore.jpg',
    'text': 'Decorator',
    'description':
        'Transform your wedding venue into a breathtaking space with our skilled decorators, bringing your vision to life with creativity and precision.',
  },
  {
    'image': 'assets/images/jewelry.jpg',
    'text': 'Jewelry Store',
    'description':
        'Explore our exquisite collection of jewelry, curated to add a touch of elegance and sophistication to your wedding moments.',
  },
  {
    'image': 'assets/images/design_car.jpg',
    'text': 'Wedding Car Decorators',
    'description':
        'Elevate your wedding transport with our expert car decorators, ensuring a stylish and thematic journey for the newlyweds.',
  },
  {
    'image': 'assets/images/dress.jpg',
    'text': 'Wedding Dress Boutique',
    'description':
        'Discover the perfect wedding attire at our boutique, where every dress is designed to make you feel extraordinary on your wedding day.',
  },
];

List<Map<String, dynamic>> Birthdayparty = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Capture joyous moments with our skilled photographers, offering a delightful collection of images to commemorate your birthday celebration.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Document the excitement of your birthday party with our professional videography services, ensuring every moment is recorded for lasting memories.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Indulge your guests with a culinary experience like no other, as our catering services redefine the art of gastronomy for your birthday celebration.',
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'text': 'Entertainer',
    'description':
        'Create a lively atmosphere with our entertainers, offering a diverse range of performances to keep your birthday party guests thoroughly entertained.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Set the perfect ambiance for your birthday celebration with our state-of-the-art sound and lighting services, creating a festive and vibrant atmosphere.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Make a stylish impression with our custom event invitations and printing services, adding a touch of flair to your birthday party announcements.',
  },
  {
    'image': 'assets/images/party.jpg',
    'text': 'Party Planner',
    'description':
        'Let our party planners turn your birthday vision into reality, curating every detail to ensure a lively and memorable celebration for you and your guests.',
  },
  {
    'image': 'assets/images/decore.jpg',
    'text': 'Decorator',
    'description':
        'Transform your birthday party venue into a breathtaking space with our skilled decorators, bringing your vision to life with creativity and precision.',
  },
];

List<Map<String, dynamic>> CorporateEvent = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Capture the essence of your corporate event with our skilled photographers, providing an exquisite collection of images that redefine professionalism and luxury.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Document every moment of your corporate event with our professional videography services, ensuring a refined and visually stunning representation of your business gathering.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Elevate your corporate event with a culinary experience like no other, as our catering services redefine the art of gastronomy, leaving a lasting impression on your guests.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Set the perfect ambiance for your corporate event with our state-of-the-art sound and lighting services, creating a sophisticated and immersive experience for your attendees.',
  },
  {
    'image': 'assets/images/security.jpg',
    'text': 'Security Service',
    'description':
        'Ensure the safety and success of your corporate event with our top-notch security services, providing a secure environment for all participants.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Make a professional statement with our custom event invitations and printing services, adding a touch of elegance and branding to your corporate event communications.',
  },
  {
    'image': 'assets/images/ticketing.jpg',
    'text': 'Ticketing and Promotion',
    'description':
        'Maximize attendance and promote your corporate event effectively with our comprehensive ticketing and promotion services, ensuring a successful and well-attended gathering.',
  },
  {
    'image': 'assets/images/branding.jpg',
    'text': 'Branding & Marketing',
    'description':
        'Build a strong brand presence and make an impact with our strategic branding and marketing services, ensuring your corporate event stands out and leaves a lasting impression.',
  },
];

List<Map<String, dynamic>> Concert = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Capture the energy and excitement of the concert with our skilled photographers, providing an exquisite collection of images that redefine the live music experience.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Document the magic of the concert with our professional videography services, ensuring a dynamic and visually stunning representation of the live performances.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Enhance the concert experience with a culinary journey like no other, as our catering services redefine the art of gastronomy, adding a flavorful dimension to the musical event.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Create a visually and acoustically stunning concert with our state-of-the-art sound and lighting services, ensuring an immersive and unforgettable experience for the audience.',
  },
  {
    'image': 'assets/images/security.jpg',
    'text': 'Security Service',
    'description':
        'Ensure the safety and enjoyment of concert-goers with our top-notch security services, providing a secure environment for everyone to enjoy the music without worries.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Set the tone for the concert with our custom event invitations and printing services, adding a touch of style and anticipation to the pre-concert communications.',
  },
  {
    'image': 'assets/images/ticketing.jpg',
    'text': 'Ticketing and Promotion',
    'description':
        'Maximize attendance and promote the concert effectively with our comprehensive ticketing and promotion services, ensuring a sold-out and buzz-worthy musical event.',
  },
  {
    'image': 'assets/images/branding.jpg',
    'text': 'Branding & Marketing',
    'description':
        'Build a strong brand presence and elevate the concert experience with our strategic branding and marketing services, ensuring the event stands out in the competitive music scene.',
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'text': 'Entertainer',
    'description':
        'Curate an unforgettable concert lineup with our entertainer services, bringing a diverse range of performances to captivate the audience and make the event truly exceptional.',
  },
];

List<Map<String, dynamic>> PrivateParty = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Capture the essence of your private party with our skilled photographers, providing an exquisite collection of images that redefine luxury and personal moments.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Document the special moments of your private party with our professional videography services, ensuring a refined and visually stunning representation of your intimate gathering.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Elevate your private party with a culinary experience like no other, as our catering services redefine the art of gastronomy, adding a touch of sophistication to your intimate event.',
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'text': 'Entertainer',
    'description':
        'Create a personalized and entertaining atmosphere with our entertainer services, offering a range of performances to make your private party truly exceptional and memorable.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Set the perfect ambiance for your private party with our state-of-the-art sound and lighting services, creating an intimate and immersive experience for you and your guests.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Make a stylish statement with our custom event invitations and printing services, adding a personal touch to your private party announcements and communications.',
  },
  {
    'image': 'assets/images/party.jpg',
    'text': 'Party Planner',
    'description':
        'Let our party planners curate an unforgettable experience for your private party, handling every detail to ensure a luxurious and stress-free celebration for you and your guests.',
  },
  {
    'image': 'assets/images/decore.jpg',
    'text': 'Decorator',
    'description':
        'Transform your private party venue into a captivating space with our skilled decorators, bringing your vision to life with creativity and attention to detail.',
  },
  {
    'image': 'assets/images/flower.jpg',
    'text': 'Florists',
    'description':
        'Enhance the beauty of your private party with the expertise of our florists, who design stunning floral arrangements to add a touch of elegance and natural charm to your event.',
  },
];

List<Map<String, dynamic>> EidCelebration = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Capture the joyous moments of your Eid Celebration with our skilled photographers, offering an exquisite collection of images that redefine luxury and festive memories.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Document the special moments of your Eid Celebration with our professional videography services, ensuring a refined and visually stunning representation of your festive gathering.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Elevate your Eid Celebration with a culinary experience like no other, as our catering services redefine the art of gastronomy, adding a touch of sophistication to your festive event.',
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'text': 'Entertainer',
    'description':
        'Create a lively and entertaining atmosphere with our entertainer services, offering a range of performances to make your Eid Celebration truly special and memorable.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Set the perfect ambiance for your Eid Celebration with our state-of-the-art sound and lighting services, creating a festive and immersive experience for you and your guests.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Make a stylish statement with our custom event invitations and printing services, adding a personal touch to your Eid Celebration announcements and communications.',
  },
  {
    'image': 'assets/images/decore.jpg',
    'text': 'Decorator',
    'description':
        'Transform your Eid Celebration venue into a captivating space with our skilled decorators, bringing your festive vision to life with creativity and attention to detail.',
  },
  {
    'image': 'assets/images/flower.jpg',
    'text': 'Florists',
    'description':
        'Enhance the beauty of your Eid Celebration with the expertise of our florists, who design stunning floral arrangements to add a touch of elegance and natural charm to your event.',
  },
];

List<Map<String, dynamic>> CulturalFestival = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Capture the vibrant moments of your Cultural Festival with our skilled photographers, offering an exquisite collection of images that redefine luxury and cultural richness.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Document the diverse cultural experiences of your festival with our professional videography services, ensuring a refined and visually stunning representation of your cultural celebration.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Elevate your Cultural Festival with a culinary experience like no other, as our catering services redefine the art of gastronomy, adding a touch of cultural flair to your festive event.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Create a visually and acoustically stunning Cultural Festival with our state-of-the-art sound and lighting services, ensuring an immersive and culturally rich experience for attendees.',
  },
  {
    'image': 'assets/images/security.jpg',
    'text': 'Security Service',
    'description':
        'Ensure the safety and enjoyment of Cultural Festival attendees with our top-notch security services, providing a secure environment for everyone to celebrate diverse cultures without worries.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Make a cultural statement with our custom event invitations and printing services, adding a personal touch to your Cultural Festival announcements and communications.',
  },
  {
    'image': 'assets/images/ticketing.jpg',
    'text': 'Ticketing and Promotion',
    'description':
        'Maximize attendance and promote your Cultural Festival effectively with our comprehensive ticketing and promotion services, ensuring a diverse and well-attended celebration.',
  },
  {
    'image': 'assets/images/branding.jpg',
    'text': 'Branding & Marketing',
    'description':
        'Build a strong brand presence and showcase the cultural richness of your festival with our strategic branding and marketing services, ensuring the event stands out and attracts diverse audiences.',
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'text': 'Entertainer',
    'description':
        'Curate a captivating Cultural Festival lineup with our entertainer services, bringing a diverse range of performances to showcase the richness and diversity of cultures, making the event truly exceptional.',
  },
];

IconButton buildCustomBackButton(BuildContext context) {
  return IconButton(
    icon: const Icon(
      Icons.arrow_back_ios,
      color: Colors.white,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}

IconButton CartButton(BuildContext context, int cartItemCount, Color color) {
  return IconButton(
    iconSize: 40,
    padding: const EdgeInsets.only(right: 20.0, top: 15),
    onPressed: () {
      Navigator.pushNamed(context, CartScreen.id);
    },
    icon: Stack(
      alignment: Alignment.center,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          child: Image.asset(
            'assets/images/cart.png',
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red, // Customize the cart dot color
            ),
            child: Center(
              child: Text(
                cartItemCount.toString(), // Set the cart count here
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10, // Customize the font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void showCustomDialog(BuildContext context, String text, IconData icon) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.4,
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: COLOR_ACCENT,
                radius: 25,
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    text: "Ok",
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// ignore: non_constant_identifier_names
List AllCategoryList = [
  {
    'image': 'assets/images/photo.jpg',
    'name': 'Photographer',
    'description':
        'Capture timeless moments with our skilled photographers, delivering exceptional visual storytelling for your events.'
  },
  {
    'image': 'assets/images/Video.jpg',
    'name': 'Videographer',
    'description':
        'Bring your events to life through our professional videography services, ensuring every moment is captured with cinematic precision.'
  },
  {
    'image': 'assets/images/cat.jpg',
    'name': 'Catering',
    'description':
        'Delight your guests with a culinary experience like no other, as our catering services redefine the art of gastronomy.'
  },
  {
    'image': 'assets/images/flower.jpg',
    'name': 'Florists',
    'description':
        'Elevate your events with the beauty of nature, curated by our expert florists who design stunning floral arrangements for every occasion.'
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'name': 'Entertainer',
    'description':
        'Create unforgettable memories with our entertainment services, providing a spectrum of performances that cater to diverse tastes.'
  },
  {
    'image': 'assets/images/car.jpeg',
    'name': 'Transportation Service',
    'description':
        'Experience seamless and stylish transportation services tailored to your event, ensuring a grand entrance for you and your guests.'
  },
  {
    'image': 'assets/images/light.jpg',
    'name': 'Sound & Lighting',
    'description':
        'Set the perfect ambiance with our state-of-the-art sound and lighting services, transforming your event into a sensory masterpiece.'
  },
  {
    'image': 'assets/images/security.jpg',
    'name': 'Security Service',
    'description':
        'Ensure the safety and well-being of your guests with our top-notch security services, providing peace of mind for your event.'
  },
  {
    'image': 'assets/images/printing.jpg',
    'name': 'Event Invitations and Printing',
    'description':
        'Make a lasting impression with our custom event invitations and printing services, adding a touch of elegance to your announcements.'
  },
  {
    'image': 'assets/images/ticketing.jpg',
    'name': 'Ticketing and Promotion',
    'description':
        'Maximize attendance and reach with our comprehensive ticketing and promotion services, tailored to make your event a resounding success.'
  },
  {
    'image': 'assets/images/branding.jpg',
    'name': 'Branding & Marketing',
    'description':
        'Build a strong brand presence and attract your target audience with our strategic branding and marketing services, ensuring your event stands out.'
  },
  {
    'image': 'assets/images/party.jpg',
    'name': 'Party Planner',
    'description':
        'Let our party planners turn your vision into reality, curating every detail to ensure a lively and memorable celebration.'
  },
  {
    'image': 'assets/images/eve.jpg',
    'name': 'Event Planner',
    'description':
        'Experience stress-free event planning with our dedicated team, orchestrating seamless and unforgettable occasions.'
  },
  {
    'image': 'assets/images/venuepic.jpg',
    'name': 'Venues',
    'description':
        'Discover the perfect venue for your event, where luxury meets convenience, setting the stage for a remarkable experience.'
  },
  {
    'image': 'assets/images/wedding.jpg',
    'name': 'Wedding Planner',
    'description':
        'Craft your dream wedding with our expert wedding planners, ensuring every detail is thoughtfully executed for a magical celebration.'
  },
  {
    'image': 'assets/images/makeup.jpg',
    'name': 'Makeup Artist & Salon',
    'description':
        'Enhance your natural beauty with the expertise of our makeup artists and salon services, adding glamour to your special day.'
  },
  {
    'image': 'assets/images/mehndi.jpg',
    'name': 'Mehndi Artist',
    'description':
        'Adorn your hands with intricate henna designs by our skilled Mehndi artists, adding a touch of tradition and artistry to your celebrations.'
  },
  {
    'image': 'assets/images/decore.jpg',
    'name': 'Decorator',
    'description':
        'Transform your venue into a breathtaking space with our skilled decorators, bringing your vision to life with creativity and precision.'
  },
  {
    'image': 'assets/images/jewelry.jpg',
    'name': 'Jewelry Store',
    'description':
        'Explore our exquisite collection of jewelry, curated to add a touch of elegance and sophistication to your special moments.'
  },
  {
    'image': 'assets/images/design_car.jpg',
    'name': 'Wedding Car Decorators',
    'description':
        'Elevate your wedding transport with our expert car decorators, ensuring a stylish and thematic journey for the newlyweds.'
  },
  {
    'image': 'assets/images/dress.jpg',
    'name': 'Wedding Dress Boutique',
    'description':
        'Discover the perfect wedding attire at our boutique, where every dress is designed to make you feel extraordinary on your special day.'
  },
  {
    'image': 'assets/images/concert1.jpg',
    'name': 'Concert',
    'description':
        'Immerse yourself in a musical experience like no other, as our concert services bring together the best talents for a night of unforgettable entertainment.'
  },
];
