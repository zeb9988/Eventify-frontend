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
  if (mainCondition == null)
    return 'assets/animation/sunny.json'; //default to sunny
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
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/flower.jpg',
    'text': 'Florists',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/car.jpg',
    'text': 'Transportation Service',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/security.jpg',
    'text': 'Security Service',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/wedding.jpg',
    'text': 'Wedding Planner',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/makeup.jpg',
    'text': 'Makeup Artist & Salon',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/mehndi.jpg',
    'text': 'Mehndi Artist',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/decore.jpg',
    'text': 'Decorator',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/jewelry.jpg',
    'text': 'Jewelry Store',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/design_car.jpg',
    'text': 'Wedding Car Decorators',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/dress.jpg',
    'text': 'Wedding Dress Boutique',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
];

List<Map<String, dynamic>> Birthdayparty = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'text': 'Entertainer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/party.jpg',
    'text': 'Party Planner',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/decore.jpg',
    'text': 'Decorator',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
];

List<Map<String, dynamic>> CorporateEvent = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/security.jpg',
    'text': 'Security Service',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/ticketing.jpg',
    'text': 'Ticketing and Promotion',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/branding.jpg',
    'text': 'Branding & Marketing',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
];

List<Map<String, dynamic>> Concert = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/security.jpg',
    'text': 'Security Service',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/ticketing.jpg',
    'text': 'Ticketing and Promotion',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/branding.jpg',
    'text': 'Branding & Marketing',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'text': 'Entertainer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
];

List<Map<String, dynamic>> PrivateParty = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'text': 'Entertainer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/party.jpg',
    'text': 'Party Planner',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/decore.jpg',
    'text': 'Decorator',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/flower.jpg',
    'text': 'Florists',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
];

List<Map<String, dynamic>> EidCelebration = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'text': 'Entertainer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/decore.jpg',
    'text': 'Decorator',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/flower.jpg',
    'text': 'Florists',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
];

List<Map<String, dynamic>> CulturalFestival = [
  {
    'image': 'assets/images/photo.jpg',
    'text': 'Photographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/Video.jpg',
    'text': 'Videographer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/cat.jpg',
    'text': 'Catering',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/light.jpg',
    'text': 'Sound & Lighting',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/security.jpg',
    'text': 'Security Service',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/printing.jpg',
    'text': 'Event Invitations and Printing',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/ticketing.jpg',
    'text': 'Ticketing and Promotion',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/branding.jpg',
    'text': 'Branding & Marketing',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'text': 'Entertainer',
    'description':
        'Experience luxury redefined with our exquisite collection of products.',
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
                    onTap: ()=>    Navigator.of(context).pop(),
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
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/Video.jpg',
    'name': 'Videographer',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/cat.jpg',
    'name': 'Catering',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/light.jpg',
    'name': 'Florists',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/entertainment.jpg',
    'name': 'Entertainer',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/car.jpg',
    'name': 'Transportation Service',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/light.jpg',
    'name': 'Sound & Lighting',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/light.jpg',
    'name': 'Security Service',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/photo.jpg',
    'name': 'Event Invitations and Printing',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/Video.jpg',
    'name': 'Ticketing and Promotion',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/Video.jpg',
    'name': 'Branding & Marketing',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/img1.jpg',
    'name': 'Party Planner',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/eve.jpg',
    'name': 'Event Planner',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/Video.jpg',
    'name': 'Venues',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/Video.jpg',
    'name': 'Wedding Planner',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/Video.jpg',
    'name': 'Makeup Artist & Salon',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/Video.jpg',
    'name': 'Mehndi Artist',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/photo.jpg',
    'name': 'Decorator',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/photo.jpg',
    'name': 'Jewelry Store',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/Video.jpg',
    'name': 'Wedding Car Decorators',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/photo.jpg',
    'name': 'Wedding Dress Boutique',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },
  {
    'image': 'assets/images/Video.jpg',
    'name': 'Concert',
    'description':
    'Experience luxury redefined with our exquisite collection of products.'
  },


];
