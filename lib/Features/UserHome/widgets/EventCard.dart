import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/product_details/Vendor_Screen.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Map<String, dynamic> vendorData;

  EventCard(this.vendorData);

  @override
  Widget build(BuildContext context) {
    double cardWidth = 300.0;
    double cardHeight = 180.0;

    return GestureDetector(
      // onTap: () {
      //   Navigator.pushNamed(context, SelectiveVendor.id,
      //       arguments: vendorData['name']);
      // },
      child: Container(
        margin: EdgeInsets.all(8),
        width: cardWidth,
        height: cardHeight,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15), // Rounded corners on all sides
          ),
          child: ClipPath(
            clipper: CategoryCardClipper(25.0),
            // Apply the custom clipper with the desired circular radius
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        vendorData['image'],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.5), // Adjusted opacity
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        vendorData['name'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        vendorData['description'].toString(),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Vendor_Screen.id,
                                arguments: vendorData['name']);
                          },
                          child: Text(
                            'View Details',
                            style: TextStyle(
                              color: COLOR_PRIMARY,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCardClipper extends CustomClipper<Path> {
  final double borderRadius;

  CategoryCardClipper(this.borderRadius);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height - borderRadius);
    path.lineTo(0, borderRadius);
    path.arcToPoint(
      Offset(borderRadius, 0),
      radius: Radius.circular(borderRadius),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(borderRadius, size.height);
    path.arcToPoint(
      Offset(0, size.height - borderRadius),
      radius: Radius.circular(borderRadius),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
