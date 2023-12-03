import 'dart:convert';
import 'package:eventify/constant/constant.dart';
import 'package:eventify/features/address/services/addressservices.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:eventify/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../common/widgets/customSnackbar.dart';
import '../../../constant/Theme_constant.dart';

class AddressScreen extends StatefulWidget {
  // static const String routeName = '/address';
  final String totalAmount;

  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController city = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  AddressServices _addressServices = AddressServices();

  String addressToBeUsed = "";

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    country.dispose();
    city.dispose();
  }

  void payPressed(String addressFromProvider) {
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        country.text.isNotEmpty ||
        city.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${city.text} - ${country.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      return showSnackBar(context, 'ERROR');
    }
    saveAdress();
  }

  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent(
          widget.totalAmount, 'PKR'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  merchantDisplayName: 'Zohaib'))
          .then((value) {});
      await displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  void placeOrder() {
    _addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: widget.totalAmount.toString());
  }

  void saveAdress() {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      _addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    makePayment();
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        showCustomSnackBar(
            text: "Successfully Paid",
            onPressed: () {},
            label: "Ok",
            context: context);
        placeOrder();
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(widget.totalAmount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51O53xnInF3xMZni1IHQ9IXNcHJJp7iaFpCIktMfEBVi49tsP8TU7q5XHOrNqo8XAFsDeilHpbBjTfj0YludM2TtF00bREIcjon',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final double parsedAmount = double.tryParse(amount) ?? 0.0;
    final int amountInCents = (parsedAmount).toInt() * 100;
    return amountInCents.toString();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    // String selectedCity = 'Rawalpindi';
    // String selectedCountry = 'Pakistan';
    // city.text = selectedCity;
    // country.text = selectedCountry;

    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_PRIMARY,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 60, // Set the desired height
                    decoration: const BoxDecoration(
                      color: COLOR_PRIMARY, // Set your desired background color
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Icon(
                            Icons.arrow_circle_down_outlined,
                            color: COLOR_ACCENT, // Set your desired arrow color
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Confirm address',
                          style: TextStyle(
                            color: Colors.black, // Set your desired text color
                            fontSize: 20, // Set your desired font size
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                if (address.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:
                            Colors.white, // Set your desired background color
                        borderRadius: BorderRadius.circular(
                            12), // Set your desired border radius
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Current Address", // Heading text
                              style: TextStyle(
                                fontSize: 20, // Set your desired font size
                                fontWeight:
                                    FontWeight.bold, // Make it bold if needed
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              address,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                const Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white, // Set your desired background color
                      borderRadius: BorderRadius.circular(
                          12), // Set your desired border radius
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Form(
                      key: _addressFormKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'House number *',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        controller: flatBuildingController,
                                        decoration: const InputDecoration(
                                          hintText: 'Flat, House Number',
                                          icon: Icon(
                                            Icons.shopping_bag,
                                            color: COLOR_ACCENT,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '* Please enter your House number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Street number/Area *',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        controller: areaController,
                                        decoration: const InputDecoration(
                                          hintText: 'Street number/Area',
                                          icon: Icon(
                                            Icons.shopping_bag,
                                            color: COLOR_ACCENT,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '* Please enter your Street number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'City',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        controller: city,
                                        decoration: const InputDecoration(
                                          hintText: 'City',
                                          icon: Icon(
                                            Icons.shopping_bag,
                                            color: COLOR_ACCENT,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '* Please enter your Street number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Country',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        controller: city,
                                        decoration: const InputDecoration(
                                          hintText: 'Country',
                                          icon: Icon(
                                            Icons.shopping_bag,
                                            color: COLOR_ACCENT,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '* Please enter your Street number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           const Text(
                            //             'City',
                            //             style: TextStyle(
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //           DropdownButtonFormField<String>(
                            //             value: selectedCity,
                            //             onChanged: (String? newValue) {
                            //               setState(() {
                            //                 selectedCity = newValue!;
                            //               });
                            //             },
                            //             items: cities.map((String city) {
                            //               return DropdownMenuItem<String>(
                            //                 value:
                            //                     city, // Make sure values are unique
                            //                 child: Text(city),
                            //               );
                            //             }).toList(),
                            //             decoration: const InputDecoration(
                            //               hintText: 'City',
                            //               icon: Icon(
                            //                 Icons.location_city,
                            //                 color:
                            //                     COLOR_ACCENT, // Change to your desired color
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(height: 10),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           const Text(
                            //             'Country',
                            //             style: TextStyle(
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //           DropdownButtonFormField<String>(
                            //             value: selectedCountry,
                            //             onChanged: (String? newValue) {
                            //               setState(() {
                            //                 selectedCountry = newValue!;
                            //               });
                            //             },
                            //             items: countries.map((String country) {
                            //               return DropdownMenuItem<String>(
                            //                 value:
                            //                     country, // Make sure values are unique
                            //                 child: Text(country),
                            //               );
                            //             }).toList(),
                            //             decoration: const InputDecoration(
                            //               hintText: 'Country',
                            //               icon: Icon(
                            //                 Icons.place,
                            //                 color:
                            //                     COLOR_ACCENT, // Change to your desired color
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => payPressed(address),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        COLOR_ACCENT, // Set your desired background color
                  ),
                  child: const Text('Proceed to Payment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
