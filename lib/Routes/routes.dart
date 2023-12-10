import 'package:eventify/Features/Vendor/vendor_register.dart';
import 'package:eventify/features/Feedback/Feedback.dart';
import 'package:eventify/features/Vendor/Vendor_Page.dart';
import 'package:eventify/features/Vendor/bookingHistoryTest.dart';
import 'package:eventify/features/Vendor/declineBookingTest.dart';
import 'package:eventify/features/Vendor/newbookingtest.dart';
import 'package:eventify/features/Vendor/trackmybooking.dart';
import 'package:eventify/features/admin/screens/Add-Vendor-Form.dart';
import 'package:eventify/features/admin/screens/Approved-Products.dart';
import 'package:eventify/features/admin/screens/Detail_Screen.dart';
import 'package:eventify/features/admin/screens/Users.dart';
import 'package:eventify/features/admin/screens/PendingProduct.dart';
import 'package:eventify/features/admin/screens/AppFeedBack.dart';
import 'package:eventify/features/admin/screens/analyticsScreen.dart';
import 'package:eventify/features/admin/screens/SendNotfication.dart';
import 'package:eventify/features/admin/screens/CompleteBooking.dart';
import 'package:eventify/features/authentication/screens/ForgetPass.dart';
import 'package:eventify/features/checklist/Checklist.dart';
import 'package:eventify/features/admin/screens/BookingScreen.dart';
import 'package:eventify/features/cart/cart_screen.dart';
import 'package:eventify/features/authentication/screens/Login.dart';
import 'package:eventify/features/authentication/screens/regisster.dart';
import 'package:eventify/features/product_details/Product_detail_screen.dart';
import 'package:eventify/features/product_details/Vendor_Screen.dart';
import 'package:eventify/models/approvedVendor.dart';
import 'package:eventify/models/order.dart';
import 'package:eventify/common/widgets/splash.dart';
import 'package:flutter/material.dart';
import '../Features/UserHome/screens/About.dart';
import '../Features/UserHome/screens/Allcatagory.dart';
import '../Features/UserHome/screens/DashPage.dart';
import '../Features/Favroute/Favourite.dart';
import '../Features/UserHome/screens/MenuScreen.dart';
import '../Features/Vendor/approvalscreen.dart';
import '../Features/Vendor/edit.dart';
import '../Features/UserHome/screens/home_screen.dart';
import '../Features/UserHome/screens/mainEventscreen.dart';
import '../Features/Vendor/pendingapproval.dart';
import '../features/Booking/BookingHistory.dart';
import '../features/Booking/BookingScreen.dart';
import '../features/Booking/TrackBooking.dart';
import '../features/admin/screens/Home-Screen.dart';
import '../features/admin/screens/Manage-Products.dart';

import '../features/search/Search.dart';
import '../models/Product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case SplashScreen.id:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => SplashScreen(),
    //   );
    case Login.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Login(),
      );

    case ApprovedRequest.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ApprovedRequest(),
      );
    case MenuScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MenuScreen(),
      );
    case VendorPage.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VendorPage(),
      );
    case Favourite.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Favourite(),
      );

    case AppFeedbackScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AppFeedbackScreen(),
      );
    case NewBookingTest.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NewBookingTest(),
      );
    case SendNotifications.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SendNotifications(),
      );
    case SplashScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SplashScreen(),
      );
    case OrderHistory.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderHistory(),
      );

    case PendingRequest.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PendingRequest(),
      );
    case Homepage.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Homepage(),
      );
    case DashPage.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DashPage(),
      );
    case CartScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );

    case PolicyScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PolicyScreen(),
      );

    case EditProduct.id:
      var approvedProducts = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EditProduct(
          approvedVendors: approvedProducts,
        ),
      );
    case MainEvent.id:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => MainEvent(category: category),
      );

    case DetailScreen.id:
      var productss = routeSettings.arguments as ApprovedVendors;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DetailScreen(product: productss),
      );

    case FeedbackScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FeedbackScreen(),
      );

    case ForgetPass.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgetPass(),
      );
    case AnalyticsScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AnalyticsScreen(),
      );
    case Users.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Users(),
      );

    case DeclineBookingTest.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DeclineBookingTest(),
      );

    case BokinghistoryTest.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BokinghistoryTest(),
      );
    case ApprovedProducts.id:
      var products = routeSettings.arguments as List<Product>;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ApprovedProducts(
          approvedRequests: products,
        ),
      );
    case AllCatagory.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AllCatagory(),
      );
    // case Manage_Product.id:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => Manage_Product(),
    //   );
    case Vendor_Screen.id:
      var products = routeSettings.arguments as String;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Vendor_Screen(product: products),
      );
    case AdminCompleteBookings.id:
      var products = routeSettings.arguments as List<Order>;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AdminCompleteBookings(orderHistory: products),
      );
    case ProductDetailsScreen.id:
      var products = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(product: products),
      );
    case AddVendorForm.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddVendorForm(),
      );
    case Search.id:
      var search = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => Search(Searchquery: search));
    case Register.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Register(),
      );

    case AdminHomeScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminHomeScreen(),
      );

    // case Dashboard.id:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => Dashboard(),
    //   );
    case Manage_Product.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Manage_Product(),
      );
    case OrderScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderScreen(),
      );

    case ChecklistScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ChecklistScreen(),
      );
    case TrackMyOrder.id:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => TrackMyOrder(order: order),
      );
    case TrackUserOrder.id:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => TrackUserOrder(order: order),
      );
    case AdminBookingScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminBookingScreen(),
      );
    case VendorProductRequest.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VendorProductRequest(),
      );
    case AddVendors.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddVendors(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
