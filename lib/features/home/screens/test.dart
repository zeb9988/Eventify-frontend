import 'package:eventify/features/home/widgets/finalcategorycard.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<Map<String, dynamic>> finalcard = [
    {
      'image': 'assets/images/cat.jpg',
      'text': 'Photographer',
    },
    {
      'image': 'assets/images/cat.jpg',
      'text': 'Videographer',
    },
    {
      'image': 'assets/images/cat.jpg',
      'text': 'Ren a Car',
    },
    {
      'image': 'assets/images/cat.jpg',
      'text': 'makeup',
    },
    {
      'image': 'assets/images/cat.jpg',
      'text': 'Lighting',
      'color': Color.fromARGB(148, 255, 224, 178),
    },
    {
      'image': 'assets/images/cat.jpg',
      'text': 'Catering',
      'color': Colors.yellow, // Add a color for the item
    },
    {
      'image': 'assets/images/cat.jpg',
      'text': 'Eid Celebration',
      'color': Colors.yellow, // Add a color for the item
    },
    {
      'image': 'assets/images/cat.jpg',
      'text': 'Wedding',
      'color': Color.fromARGB(117, 187, 222, 251),
    },
    {
      'image': 'assets/images/cat.jpg',
      'text': 'Eid Celebration',
      'color': Colors.yellow, // Add a color for the item
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount:
          (finalcard.length / 2).ceil(), // Calculate the number of rows needed
      itemBuilder: (context, rowIndex) {
        final startIndex = rowIndex * 2;
        final endIndex = startIndex + 2 <= finalcard.length
            ? startIndex + 2
            : finalcard.length;

        return Row(
          children: List.generate(endIndex - startIndex, (index) {
            final item = finalcard[startIndex + index];

            return Flexible(
              child: Container(
                margin: EdgeInsets.only(
                    right: index == 0 && index == endIndex - startIndex - 1
                        ? 5
                        : 0, // Add right margin to the rightmost card in a single-card row
                    bottom: 15,
                    left: 10),
                child: Finalcat(
                  description: item['description'],
                  image: item['image'],
                  name: item['text'],
                  press: () {
                    // Handle the onTap event
                  },
                ),
              ),
            );
          }),
        );
      },
    ));
  }
}
