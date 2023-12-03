import 'dart:convert';
import 'dart:developer';

import 'package:eventify/features/admin/screens/Home-Screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//
// class MessagingService {
//   static String? fcmToken; // Variable to store the FCM token
//
//   static final MessagingService _instance = MessagingService._internal();
//
//   factory MessagingService() => _instance;
//
//   MessagingService._internal();
//
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//   Future<void> init(BuildContext context) async {
//     // Requesting permission for notifications
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     debugPrint(
//         'User granted notifications permission: ${settings.authorizationStatus}');
//
//     // Retrieving the FCM token
//     fcmToken = await _fcm.getToken();
//     log('fcmToken: $fcmToken');
//
//     // Handling background messages using the specified handler
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     // Listening for incoming messages while the app is in the foreground
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint('Got a message whilst in the foreground!');
//       debugPrint('Message data: ${message.notification!.title.toString()}');
//
//       if (message.notification != null) {
//         if (message.notification!.title != null &&
//             message.notification!.body != null) {
//           final notificationData = message.data;
//           final screen = notificationData['screen'];
//
//           // Showing an alert dialog when a notification is received (Foreground state)
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (BuildContext context) {
//               return WillPopScope(
//                 onWillPop: () async => false,
//                 child: Card(
//                   elevation: 4.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       ListTile(
//                         title: Text(message.notification!.title!),
//                         subtitle: Text(message.notification!.body!),
//                       ),
//                       ButtonBar(
//                         children: <Widget>[
//                           if (notificationData.containsKey('screen'))
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 Navigator.of(context).pushNamed(Adminscreen.id);
//                               },
//                               child: const Text('Open Screen'),
//                             ),
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(),
//                             child: const Text('Dismiss'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       }
//     });
//
//     // Handling the initial message received when the app is launched from dead (killed state)
//     // When the app is killed and a new notification arrives when user clicks on it
//     // It gets the data to which screen to open
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         _handleNotificationClick(context, message);
//       }
//     });
//
//     // Handling a notification click event when the app is in the background
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint(
//           'onMessageOpenedApp: ${message.notification!.title.toString()}');
//       _handleNotificationClick(context, message);
//     });
//   }
//
//   // Handling a notification click event by navigating to the specified screen
//   void _handleNotificationClick(BuildContext context, RemoteMessage message) {
//     final notificationData = message.data;
//     if (notificationData.containsKey('screen')) {
//       final screen = notificationData['screen'];
//       Navigator.of(context).pushNamed(screen);
//     }
//   }
// }
//
// // Handler for background messages
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   debugPrint('Handling a background message: ${message.notification!.title}');
// }
class MessagingService {
  static String? fcmToken;

  static final MessagingService _instance = MessagingService._internal();

  factory MessagingService() => _instance;

  MessagingService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init(BuildContext context) async {
    // Requesting permission for notifications
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
        'User granted notifications permission: ${settings.authorizationStatus}');

    // Retrieving the FCM token
    fcmToken = await _fcm.getToken();
    debugPrint('fcmToken: $fcmToken');

    // Handling background messages using the specified handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listening for incoming messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.notification!.title.toString()}');

      if (message.notification != null) {
        if (message.notification!.title != null &&
            message.notification!.body != null) {
          final notificationData = message.data;
          final screen = notificationData['screen'];

          // Showing a system notification when a notification is received (Foreground state)
          showNotification(context, message);
        }
      }
    });

    // Handling the initial message received when the app is launched from dead (killed state)
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(context, message);
      }
    });

    // Handling a notification click event when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          'onMessageOpenedApp: ${message.notification!.title.toString()}');
      _handleNotificationClick(context, message);
    });
  }

  Future<void> showNotification(
      BuildContext context, RemoteMessage message) async {
    final notificationData = message.data;

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id', // Replace with a unique channel ID
      'Your Channel Name', // Replace with a channel name
      // 'Your Channel Description', // Replace with a channel description
      importance: Importance.max,
      priority: Priority.high,
    );

    final platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID (you can use different IDs for different notifications)
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: jsonEncode(notificationData),
    );
  }

  void _handleNotificationClick(BuildContext context, RemoteMessage message) {
    final notificationData = message.data;
    if (notificationData.containsKey('screen')) {
      final screen = notificationData['screen'];
      Navigator.of(context).pushNamed(screen);
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message: ${message.notification!.title}');
}
