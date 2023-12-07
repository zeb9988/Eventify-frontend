import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/Feedback/Feedback.dart';
import 'package:eventify/features/admin/Widgets/dashCard.dart';
import 'package:eventify/features/admin/screens/Add-Vendor-Form.dart';
import 'package:eventify/features/admin/screens/Approved-Products.dart';
import 'package:eventify/features/admin/screens/Manage-Products.dart';
import 'package:eventify/features/admin/screens/Users.dart';
import 'package:eventify/features/admin/screens/Vendor-Requests.dart';
import 'package:eventify/features/admin/screens/allFeedback.dart';
import 'package:eventify/features/admin/screens/analyticsScreen.dart';
import 'package:eventify/features/admin/screens/sendNotfication.dart';
import 'package:eventify/features/admin/screens/soldOrderscreen.dart';
import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:eventify/models/Product.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/order.dart';
import '../../../models/user.dart';

class Admin_Dashboard extends StatefulWidget {
  static const String id = '/AllServices';

  const Admin_Dashboard({Key? key}) : super(key: key);

  @override
  State<Admin_Dashboard> createState() => _Admin_DashboardState();
}

class _Admin_DashboardState extends State<Admin_Dashboard> {
  List<Product> plist = [];
  AdminServices adminservices = AdminServices();
  List<User> users = [];
  List<Order> soldOrders = [];
  List<Product> approvedVendors = [];
  List<Product> pendingVendors = [];
  void fetchUsers() async {
    users = await adminservices.fetchUsers(context: context);
    setState(() {});
  }

  void fetchsoldOrders() async {
    soldOrders = await adminservices.fetchSoldOrders(context: context);
    setState(() {});
  }

  void approvedVendor() async {
    approvedVendors =
        await adminservices.fetchApprovedVendors(context: context);
    // print(approvedVendors);
    setState(() {});
  }

  void pendingVendor() async {
    pendingVendors = await adminservices.fetchPendingVendors(context: context);
    // print(approvedVendors);
    setState(() {});
  }

  @override
  void initState() {
    fetchUsers();
    fetchsoldOrders();
    approvedVendor();
    pendingVendor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Admin ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: Provider.of<UserProvider>(context).user.name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Manage_Product.id);
                      },
                      child: const dashCard(
                          text: 'Products',
                          image: 'assets/images/product.png')),
                  GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Users.id),
                      child: dashCard(
                          text: 'Users: ${users.length}',
                          image: 'assets/images/customer.png')),
                  GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AnalyticsScreen.id),
                      child: const dashCard(
                          text: 'Analytics',
                          image: 'assets/images/analytics.png')),
                  GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Addproduct.id),
                      child: const dashCard(
                          text: 'Add Product',
                          image: 'assets/images/addproduct.png')),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AdminOrderHistory.id,
                            arguments: soldOrders);
                      },
                      child: dashCard(
                          text: 'Orders: ${soldOrders.length}',
                          image: 'assets/images/order.png')),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ApprovedProducts.id,
                            arguments: approvedVendors);
                      },
                      child: dashCard(
                          text: 'Approved Products: ${approvedVendors.length}',
                          image: 'assets/images/approve.png')),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PendingProducts.id,
                            arguments: pendingVendors);
                      },
                      child: dashCard(
                          text: 'Pending products: ${pendingVendors.length}',
                          image: 'assets/images/pending.png')),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SendNotifications.id);
                      },
                      child: const dashCard(
                          text: 'Sent Notification',
                          image: 'assets/images/notification.png')),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, GetFeedbackScreen.id);
                      },
                      child: const dashCard(
                          text: 'Users Feedback',
                          image: 'assets/images/feedbacklogo.png')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
