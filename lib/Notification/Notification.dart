
import 'package:eventify/constant/Theme_constant.dart';
import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String description;
  final IconData icon;

  NotificationItem({required this.title, required this.description, required this.icon});
}

class NotificationScreen extends StatelessWidget {

  static const String id = '/Notification';
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'New Message',
      description: 'You have a new message from John Doe.',
      icon: Icons.message,
    ), NotificationItem(
      title: 'New Message',
      description: 'You have a new message from John Doe.',
      icon: Icons.message,
    ), NotificationItem(
      title: 'New Message',
      description: 'You have a new message from John Doe.',
      icon: Icons.message,
    ), NotificationItem(
      title: 'New Message',
      description: 'You have a new message from John Doe.',
      icon: Icons.message,
    ), NotificationItem(
      title: 'New Message',
      description: 'You have a new message from John Doe.',
      icon: Icons.message,
    ), NotificationItem(
      title: 'New Message',
      description: 'You have a new message from John Doe.',
      icon: Icons.message,
    ), NotificationItem(
      title: 'New Message',
      description: 'You have a new message from John Doe.',
      icon: Icons.message,
    ),
    NotificationItem(
      title: 'Friend Request',
      description: 'John Smith sent you a friend request.',
      icon: Icons.person_add,
    ),
    NotificationItem(
      title: 'New Like',
      description: 'Your post received a new like from Sarah.',
      icon: Icons.thumb_up,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar:AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Notifications', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body:ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            color: COLOR_PRIMARY, // Set the background color for the tile
            child: Column(
              children: [
                SizedBox(height: 12,),
                NotificationTile(notification: notification),

              ],
            ),
          );
        },
      ),


    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(

        leading: CircleAvatar(
          backgroundColor: COLOR_ACCENT,
          child: Icon(
            notification.icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          notification.description,
          style: TextStyle(fontSize: 16),
        ),
        onTap: () {
          // Handle notification tap action here
        },
      ),
    );
  }
}