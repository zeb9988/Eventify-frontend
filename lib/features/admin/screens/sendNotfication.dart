import 'package:eventify/common/widgets/Loader.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/models/user.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custombutton.dart';
import '../services/admin_services.dart';

class SendNotifications extends StatefulWidget {
  static const String id = '/notifications';

  const SendNotifications({Key? key}) : super(key: key);

  @override
  _SendNotificationsState createState() => _SendNotificationsState();
}

class _SendNotificationsState extends State<SendNotifications> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  List<User> users = [];
  int selectedUserIndex = -1; // Initialize with an invalid index
  final AdminServices _adminServices = AdminServices();
  @override
  void dispose() {
    _messageController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  void fetchUsers() async {
    users = await _adminServices.fetchUsers(context: context);
    setState(() {});
  }

  void sendNotification(User user) {
    _adminServices.sendNotification(
        context: context,
        title: _titleController.text,
        body: _messageController.text,
        user: user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Send Notifications Here....',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: COLOR_ACCENT,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 1,
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Enter Title',
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                prefixIcon: const Icon(
                  Icons.notification_important,
                  color: COLOR_ACCENT,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: COLOR_ACCENT),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: COLOR_ACCENT),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: COLOR_ACCENT),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 3,
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Enter Message',
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                prefixIcon: const Icon(
                  Icons.notification_important,
                  color: COLOR_ACCENT,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: COLOR_ACCENT),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: COLOR_ACCENT),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: COLOR_ACCENT),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            users.isEmpty
                ? const Loader()
                : Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedUserIndex = index;
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            color: selectedUserIndex == index
                                ? Colors.blue[100]
                                : Colors.white,
                            child: ListTile(
                              title: Text('Name: ${users[index].name}'),
                              subtitle: Text(
                                'Type: ${users[index].type}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                selectedUserIndex == index
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: selectedUserIndex == index
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Send Notification',
              onTap: () {
                // Implement the logic to send notifications to the selected user
                if (selectedUserIndex != -1 &&
                    _messageController.text.isNotEmpty &&
                    _titleController.text.isNotEmpty) {
                  User selectedUser = users[selectedUserIndex];
                  sendNotification(selectedUser);
                }
              },
              color: COLOR_ACCENT,
            ),
          ],
        ),
      ),
    );
  }
}
