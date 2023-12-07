import 'package:dotted_border/dotted_border.dart';
import 'package:eventify/Language/language_constants.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/common/widgets/customtextfeild.dart';
import 'package:eventify/features/Vendor/Vendor_Page.dart';
import 'package:eventify/features/account/services/accountservices.dart';
import 'package:eventify/features/cart/cart_screen.dart';
import 'package:eventify/features/Feedback/Feedback.dart';
import 'package:eventify/features/home/screens/About.dart';
import 'package:eventify/features/home/screens/Favourite.dart';
import 'package:eventify/features/home/screens/approvalscreen.dart';
import 'package:eventify/features/home/screens/pendingapproval.dart';
import 'package:eventify/features/home/screens/vendor_register.dart';
import 'package:eventify/features/home/services/userServices.dart';
import 'package:eventify/features/home/widgets/language_menu.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/customDialogBox.dart';
import '../../../common/widgets/custombutton.dart';
import '../../Booking/BookingHistory.dart';
import '../../Booking/BookingScreen.dart';

class MenuScreen extends StatefulWidget {
  static const String id = '/MenuScreen';

  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ProfileCompletionCard> profileCompletionCards =
        initializeProfileCompletionCards(context);

    final user = Provider.of<UserProvider>(context).user;
    nameController.text = user.name;
    addressController.text = user.address;
    UserServices services = UserServices();
    void editUser() {
      services.editUser(
          context: context,
          name: nameController.text,
          address: addressController.text);
    }

    List<CustomListTile> tiles = customListTiles(context);

    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        // backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(translation(context).profile),
        actions: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(translation(context).languagesupport,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: LanguageMenu(),
            ),
          ])
        ],
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          // COLUMN THAT WILL CONTAIN THE PROFILE
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                      child: CircleAvatar(
                        maxRadius: 40,
                        backgroundColor: COLOR_ACCENT,
                        child: Text(
                          user.name.isNotEmpty
                              ? user.name[0].toUpperCase()
                              : 'Empty',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(height: 10),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'wallet: Rs ${user.wallet.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: COLOR_ACCENT,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Edit'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      // Handle changing the profile picture here
                                    },
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
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 48,
                                        backgroundImage: AssetImage(
                                            "assets/images/vendor1.png"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CustomTextField(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: COLOR_ACCENT,
                                    ),
                                    hintText: 'Change your name',
                                    is_pass: false,
                                    controller: nameController,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CustomTextField(
                                    icon: const Icon(
                                      Icons.location_city,
                                      color: COLOR_ACCENT,
                                    ),
                                    hintText: 'Address',
                                    is_pass: false,
                                    controller: addressController,
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      editUser();
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          COLOR_ACCENT, // Change the color to the desired color
                                    ),
                                    child: const Text("Save",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, VendorPage.id),
            child: DottedBorder(
              color: COLOR_ACCENT,
              radius: const Radius.circular(10),
              borderType: BorderType.RRect,
              strokeCap: StrokeCap.round,
              dashPattern: const [10, 4],
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    translation(context).becomeavendor,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(height: 10),
          ...List.generate(
            tiles.length,
            (index) {
              final tile = tiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 4,
                  // shadowColor: Colors.black12,
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      tile.icon,
                      color: COLOR_ACCENT,
                    ),
                    title: Text(tile.title),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      tile.onPress!(context);
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class ProfileCompletionCard {
  final String title;
  final String buttonText;
  final IconData icon;
  final Function(BuildContext context, String title)? onPress;
  ProfileCompletionCard({
    required this.title,
    required this.buttonText,
    required this.icon,
    this.onPress,
  });
}

List<ProfileCompletionCard> initializeProfileCompletionCards(
    BuildContext context) {
  return [
    ProfileCompletionCard(
      title: translation(context).registrationform,
      icon: CupertinoIcons.person_circle,
      buttonText: "Click",
      onPress: (context, title) {
        if (title == translation(context).registrationform) {
          Navigator.pushNamed(context, AddVendors.id);
        }
      },
    ),
    ProfileCompletionCard(
      title: translation(context).approvedreq,
      icon: Icons.check,
      buttonText: "Click",
      onPress: (context, title) {
        if (title == translation(context).approvedreq) {
          Navigator.pushNamed(context, ApprovedRequest.id);
        }
      },
    ),
    ProfileCompletionCard(
      title: translation(context).pendingreq,
      icon: Icons.pending,
      buttonText: "Click",
      onPress: (context, title) {
        if (title == translation(context).pendingreq) {
          Navigator.pushNamed(context, PendingRequest.id);
        }
      },
    ),
  ];
}

class CustomListTile {
  final IconData icon;
  final String title;
  final Function(BuildContext context)? onPress;
  final BuildContext context; // Add a field to store the BuildContext

  CustomListTile({
    required this.icon,
    required this.title,
    this.onPress,
    required this.context, // Pass and store the BuildContext
  });
}

List<CustomListTile> customListTiles(BuildContext context) {
  return [
    CustomListTile(
      icon: Icons.list,
      title: translation(context).booking,
      context: context, // Pass the BuildContext
      onPress: (context) {
        Navigator.pushNamed(context, OrderScreen.id);
      },
    ),
    CustomListTile(
      icon: Icons.shopping_cart,
      title: translation(context).bookinghistory,
      context: context,
      onPress: (context) {
        Navigator.pushNamed(context, OrderHistory.id);
      },
    ),
    CustomListTile(
      icon: Icons.shopping_cart,
      title: translation(context).cart,
      context: context,
      onPress: (context) {
        Navigator.pushNamed(context, CartScreen.id);
      },
    ),
    CustomListTile(
      context: context,
      icon: Icons.favorite,
      title: translation(context).favorite,
      onPress: (context) {
        Navigator.pushNamed(context, Favourite.id);
        print("My fav pressed");
      },
    ),
    CustomListTile(
      context: context,
      icon: Icons.feedback,
      title: translation(context).feedback,
      onPress: (context) {
        Navigator.pushNamed(context, FeedbackScreen.id);
      },
    ),
    CustomListTile(
      context: context,
      title: translation(context).about,
      icon: CupertinoIcons.info,
      onPress: (context) {
        Navigator.pushNamed(context, PolicyScreen.id);
        print("about");
      },
    ),
    CustomListTile(
      context: context,
      title: translation(context).logout,
      icon: CupertinoIcons.arrow_right_arrow_left,
      onPress: (context) {
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            title: "Are you sure you want to logout?",
            icon: Icons.logout, // Replace with your desired icon
            buttons: [
              CustomButton(
                  text: "logout",
                  onTap: () {
                    logOut(context);
                    Navigator.of(context).pop();
                  }),
              CustomButton(
                  text: "Cancel",
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        );
      },
    ),
  ];
}
