import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/Vendor/bookingHistoryTest.dart';
import 'package:eventify/features/Vendor/declineBookingTest.dart';
import 'package:eventify/features/Vendor/newbookingtest.dart';
import 'package:eventify/features/admin/Widgets/dashCard.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'approvalscreen.dart';
import 'pendingapproval.dart';
import 'vendor_register.dart';

class VendorPage extends StatefulWidget {
  static const String id = '/Vendorpage';
  const VendorPage({Key? key}) : super(key: key);

  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: COLOR_PRIMARY,
        centerTitle: true,
        title: const Text(
          'Vendor Dashboard',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: COLOR_PRIMARY,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // RichText(
            //   text: TextSpan(
            //     children: <TextSpan>[
            //       const TextSpan(
            //         text: 'Vendor:',
            //         style: TextStyle(
            //           fontSize: 20,
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       TextSpan(
            //         text: Provider.of<UserProvider>(context).user.name,
            //         style: const TextStyle(
            //           fontSize: 20,
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AddVendors.id);
                    },
                    child: const dashCard(
                        text: 'Add Product',
                        image: 'assets/images/addproduct.png'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ApprovedRequest.id);
                    },
                    child: const dashCard(
                        text: 'Approved Products ',
                        image: 'assets/images/approve.png'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PendingRequest.id);
                    },
                    child: const dashCard(
                        text: 'Pending Products',
                        image: 'assets/images/pending.png'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, BokinghistoryTest.id);
                    },
                    child: const dashCard(
                        text: 'Completed bookings',
                        image: 'assets/images/completeorder.png'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NewBookingTest.id);
                    },
                    child: const dashCard(
                        text: 'New bookings ',
                        image: 'assets/images/pendingorder.png'),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, DeclineBookingTest.id);
                      },
                      child: const dashCard(
                          text: 'Decline bookings',
                          image: 'assets/images/cancelorder.png')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
