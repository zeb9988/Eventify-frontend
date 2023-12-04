import 'package:eventify/Notification/Notification.dart';
import 'package:eventify/features/Feedback/Feedback.dart';
import 'package:eventify/features/Vendor/Vendor_Page.dart';
import 'package:eventify/features/Vendor/bokinghistoryvendor.dart';
import 'package:eventify/features/Vendor/declinebooking.dart';
import 'package:eventify/features/Vendor/newbooking.dart';
import 'package:eventify/features/Vendor/trackmybooking.dart';
import 'package:eventify/features/admin/screens/Add-Vendor-Form.dart';
import 'package:eventify/features/admin/screens/Approved-Products.dart';
import 'package:eventify/features/admin/screens/Detail_Screen.dart';
import 'package:eventify/features/admin/screens/Users.dart';
import 'package:eventify/features/admin/screens/Vendor-Requests.dart';
import 'package:eventify/features/admin/screens/allFeedback.dart';
import 'package:eventify/features/admin/screens/analyticsScreen.dart';
import 'package:eventify/features/admin/screens/sendNotfication.dart';
import 'package:eventify/features/admin/screens/soldOrderscreen.dart';
import 'package:eventify/features/authentication/screens/ForgetPass.dart';
import 'package:eventify/features/checklist/Checklist.dart';
import 'package:eventify/features/home/screens/About.dart';
import 'package:eventify/features/home/screens/Favourite.dart';
import 'package:eventify/features/home/screens/MenuScreen.dart';
import 'package:eventify/features/admin/screens/adminOrderPage.dart';
import 'package:eventify/features/home/screens/edit.dart';
import 'package:eventify/features/home/screens/pendingapproval.dart';
import 'package:eventify/features/cart/cart_screen.dart';
import 'package:eventify/features/home/screens/Allcatagory.dart';
import 'package:eventify/features/home/screens/home_screen.dart';
import 'package:eventify/features/authentication/screens/Login.dart';
import 'package:eventify/features/authentication/screens/regisster.dart';
import 'package:eventify/features/home/screens/vendor_register.dart';
import 'package:eventify/features/product_details/Product_detail_screen.dart';
import 'package:eventify/features/product_details/Vendor_Screen.dart';
import 'package:eventify/models/approvedVendor.dart';
import 'package:eventify/models/order.dart';
import 'package:eventify/common/widgets/splash.dart';
import 'package:flutter/material.dart';
import 'features/Booking/BookingHistory.dart';
import 'features/Booking/BookingScreen.dart';
import 'features/Booking/TrackBooking.dart';
import 'features/admin/screens/Home-Screen.dart';
import 'features/admin/screens/Manage-Products.dart';
import 'features/home/screens/DashPage.dart';
import 'features/Chat/Messages.dart';
import 'features/home/screens/approvalscreen.dart';
import 'features/home/screens/mainEventscreen.dart';
import 'features/search/Search.dart';
import 'models/Product.dart';

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
        builder: (_) => ApprovedRequest(),
      );
    case MenuScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => MenuScreen(),
      );
    case VendorPage.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => VendorPage(),
      );
    case Favourite.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Favourite(),
      );
    case GetFeedbackScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => GetFeedbackScreen(),
      );
    case NewBooking.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => NewBooking(),
      );
    case SendNotifications.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SendNotifications(),
      );
    case SplashScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SplashScreen(),
      );
    case OrderHistory.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderHistory(),
      );

    case PendingRequest.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PendingRequest(),
      );
    case Homepage.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Homepage(),
      );
    case DashPage.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DashPage(),
      );
    case CartScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CartScreen(),
      );

    case PolicyScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PolicyScreen(),
      );

    case EditProduct.id:
      var approvedProducts = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EditProduct(
          approvedVendors: approvedProducts,
        ),
      );
    case AdminOrderHistory.id:
      var soldOrders = routeSettings.arguments as List<Order>;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AdminOrderHistory(
          orderHistory: soldOrders,
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

    case Messages.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Messages(),
      );

    case FeedbackScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => FeedbackScreen(),
      );

    case ForgetPass.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ForgetPass(),
      );
    case AnalyticsScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AnalyticsScreen(),
      );
    case Users.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Users(),
      );

    case NotificationScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => NotificationScreen(),
      );
    case DeclineBooking.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DeclineBooking(),
      );

    case bokinghistoryvendor.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => bokinghistoryvendor(),
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
        builder: (_) => AllCatagory(),
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
    case ProductDetailsScreen.id:
      var products = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(product: products),
      );
    case Addproduct.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Addproduct(),
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

    case Adminscreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Adminscreen(),
      );

    // case Dashboard.id:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => Dashboard(),
    //   );
    case Manage_Product.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Manage_Product(),
      );
    case OrderScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderScreen(),
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
    case AdminOrderScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AdminOrderScreen(),
      );
    case PendingProducts.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PendingProducts(),
      );
    case AddVendors.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddVendors(),
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
