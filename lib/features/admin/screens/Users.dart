import 'package:dotted_border/dotted_border.dart';
import 'package:eventify/common/widgets/customtextfeild.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class Users extends StatefulWidget {
  static const String id = '/User';

  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  TextEditingController adminNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<User> users = [];
  AdminServices _adminServices = AdminServices();
  String selectedRole = "admin";
  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  void fetchUsers() async {
    users = await _adminServices.fetchUsers(context: context);
    setState(() {});
  }

  void deleteUsers(User user, int index) {
    _adminServices.deleteUsers(
        context: context,
        user: user,
        onsuccess: () {
          users.removeAt(index);
        });
    setState(() {});
  }

  @override
  void dispose() {
    adminNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void registerUser() {
      _adminServices.register(
          context: context,
          email: emailController.text,
          password: passwordController.text,
          name: adminNameController.text,
          type: selectedRole);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_PRIMARY,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text('All Users', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                        child: AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(20),
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Add New Admin",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 3,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 48,
                                    backgroundImage:
                                        AssetImage("assets/images/vendor1.png"),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              CustomTextField(
                                icon: Icon(
                                  Icons.person,
                                  color: COLOR_ACCENT,
                                ),
                                hintText: 'Name',
                                is_pass: false,
                                controller: adminNameController,
                              ),
                              SizedBox(height: 10),
                              CustomTextField(
                                icon: Icon(
                                  Icons.email,
                                  color: COLOR_ACCENT,
                                ),
                                hintText: 'Email',
                                controller: emailController,
                                is_pass: false,
                              ),
                              SizedBox(height: 10),
                              CustomTextField(
                                icon: Icon(
                                  Icons.lock,
                                  color: COLOR_ACCENT,
                                ),
                                hintText: 'Password',
                                is_pass: true,
                                controller: passwordController,
                              ),
                              SizedBox(height: 20),
                              DropdownButton<String>(
                                value: selectedRole,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedRole = newValue;
                                    });
                                  }
                                },
                                items: <String>['admin', 'user']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(
                                              child: Text(
                                                "Registration Successful",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Center(
                                              child: Text(
                                                  "You are registered successfully!"),
                                            ),
                                            SizedBox(height: 20),
                                            TextButton(
                                              onPressed: () {
                                                registerUser();
                                                Navigator.pop(
                                                    context); // Close the dialog
                                                Navigator.pop(
                                                    context); // Close the screen or previous dialog
                                              },
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: COLOR_ACCENT),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: COLOR_ACCENT,
                                ),
                                child: Text("Register",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          );
                        },
                      ),
                    ));
                  },
                );
              },
              color: Colors.black,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (users.isEmpty)
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: DottedBorder(
                  color: COLOR_ACCENT,
                  radius: const Radius.circular(10),
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "NO USER",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: COLOR_ACCENT, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Type: ${user.type}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "Name: ${user.name}",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Email: ${user.email}",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Address: ${user.address}",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _showDeleteUserDialog(user, index);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteUserDialog(User user, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Delete User",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                    'Are you sure you want to delete user "${user.name}"?'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: COLOR_ACCENT),
                    ),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      deleteUsers(user, index);
                      Navigator.pop(context);
                      fetchUsers();
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
