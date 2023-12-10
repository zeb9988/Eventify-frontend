import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:el_tooltip/el_tooltip.dart';
import 'package:eventify/common/widgets/customSnackbar.dart';
import 'package:eventify/common/widgets/custombutton.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';
import '../../constant/Theme_constant.dart';
import '../../constant/constant.dart';
import '../UserHome/services/userServices.dart';
import '../UserHome/screens/home_screen.dart';

class EditProduct extends StatefulWidget {
  static const String id = '/editproduct';
  final Product approvedVendors;
  const EditProduct({Key? key, required this.approvedVendors})
      : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _addproductform = GlobalKey<FormState>();
  TextEditingController businessName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController zipcode = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController generalDetail = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final TextEditingController benificiaryName = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController priceDescription = TextEditingController();
  // AdminServices adminServices = AdminServices();
  // VendorServices vendorServices = VendorServices();

  @override
  void dispose() {
    businessName.dispose();
    address.dispose();
    city.dispose();
    state.dispose();
    zipcode.dispose();
    country.dispose();
    email.dispose();
    phonenumber.dispose();
    generalDetail.dispose();
    bankName.dispose();
    benificiaryName.dispose();
    accountNumber.dispose();
    price.dispose();
    priceDescription.dispose();
    super.dispose();
  }

  String category = '';
  List<String> categories = productCategories;
  List<File> images = [];
  List<String> imageUrls = [];
  List<String> allImageUrls = [];
  UserServices userServices = UserServices();
  void editProduct() {
    if (_addproductform.currentState!.validate() && allImageUrls.isNotEmpty) {
      userServices.editProducts(
        context: context,
        businessName: businessName.text,
        id: widget.approvedVendors.id,
        priceDescription: priceDescription.text,
        address: address.text,
        city: city.text,
        state: state.text,
        zipcode: double.parse(zipcode.text),
        images: allImageUrls,
        country: country.text,
        phonenumber: double.parse(phonenumber.text),
        email: email.text,
        generalDetail: generalDetail.text,
        bankName: bankName.text,
        benificiaryName: benificiaryName.text,
        accountNumber: double.parse(accountNumber.text),
        price: double.parse(price.text),
        category: category,
        insuredValue: insuredValue.toString(),
        licenseHolder: licenseValue.toString(),
        onsuccess: () {
          showCustomSnackBar(
              context: context,
              text: 'Product edit successfully',
              label: 'Ok',
              onPressed: () {});
          Navigator.pushNamedAndRemoveUntil(
              context, Homepage.id, (route) => false);
        },
      );
    } else {
      showCustomSnackBar(
          context: context,
          text: 'Some fields are empty or break validation ',
          label: 'Ok',
          onPressed: () {});
    }
  }

  @override
  void initState() {
    allImageUrls.addAll(widget.approvedVendors.images);
    super.initState();
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });

    final cloudinary = CloudinaryPublic('deprueuwl', 'bnq90myj');

    for (int i = 0; i < images.length; i++) {
      CloudinaryResponse res =
          await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path));
      imageUrls.add(res.secureUrl);
    }
    // Add the newly uploaded image URLs to the allImageUrls list
    // allImageUrls.addAll(imageUrls);
    setState(() {
      allImageUrls = [...widget.approvedVendors.images, ...imageUrls];
    });
  }

  String? insuredValue;
  String? licenseValue;

  @override
  Widget build(BuildContext context) {
    businessName.text = widget.approvedVendors.businessName;
    address.text = widget.approvedVendors.address;
    city.text = widget.approvedVendors.city;
    state.text = widget.approvedVendors.state;
    zipcode.text = widget.approvedVendors.zipcode.toStringAsFixed(0);
    country.text = widget.approvedVendors.country;
    phonenumber.text = widget.approvedVendors.phonenumber.toStringAsFixed(0);
    email.text = widget.approvedVendors.email;
    generalDetail.text = widget.approvedVendors.generalDetail;
    bankName.text = widget.approvedVendors.bankName;
    benificiaryName.text = widget.approvedVendors.benificiaryName;
    accountNumber.text =
        widget.approvedVendors.accountNumber.toStringAsFixed(0);
    price.text = widget.approvedVendors.price.toStringAsFixed(0);
    priceDescription.text = widget.approvedVendors.priceDescription;

    category = widget.approvedVendors.category;
    // images.add(widget.approvedVendors.images);

    String selectedCountry = 'Pakistan';
    String selectedCity = 'Rawalpindi';
    String selectedStates = 'Punjab';

    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: COLOR_PRIMARY,
        elevation: 0,

        centerTitle: true, // Center the title and widgets
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  20), // Adjust the border radius as needed
              color: Colors.white, // Background color of the container
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 10, // Blur radius
                  offset: const Offset(0, 3), // Offset in the x and y direction
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _addproductform,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Edit Product Form',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Company Contact Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 16),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                    ),
                    items: allImageUrls.map((i) {
                      return Builder(
                        builder: (BuildContext context) => Stack(
                          children: [
                            Image.network(
                              i,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    imageUrls.remove(i);
                                    allImageUrls.remove(i);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: selectImages,
                    child: Container(
                      decoration: BoxDecoration(
                        color: COLOR_ACCENT, // Background color for the button
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 50,
                      height: 50,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add, // An icon representing "add"
                            color: Colors.white, // Icon color
                            size: 48, // Icon size
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Business Name *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              controller: businessName,
                              decoration: const InputDecoration(
                                hintText: 'Organization/Business Name',
                                icon: Icon(
                                  Icons.shopping_bag,
                                  color: COLOR_ACCENT,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Please enter your name';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('Enter your product name'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Address *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              controller: address,
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: 'Company Address',
                                icon: Icon(
                                  Icons.location_on,
                                  color: COLOR_ACCENT,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Please enter your address';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        // position: ElTooltipPosition.leftStart,
                        content: Text('Enter your Company name'),
                        // position: ElTooltipPosition.leftStart,
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'City',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              value: selectedCity,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCity = newValue!;
                                });
                              },
                              items: cities.map((String city) {
                                return DropdownMenuItem<String>(
                                  value: city, // Make sure values are unique
                                  child: Text(city),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                hintText: 'City',
                                icon: Icon(
                                  Icons.location_city,
                                  color:
                                      COLOR_ACCENT, // Change to your desired color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('Select you city'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Province',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              value: selectedStates,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedStates = newValue!;
                                });
                              },
                              items: States.map((String state) {
                                return DropdownMenuItem<String>(
                                  value: state, // Make sure values are unique
                                  child: Text(state),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                hintText: 'State/Province',
                                icon: Icon(
                                  Icons.location_city,
                                  color:
                                      COLOR_ACCENT, // Change to your desired color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('Select your state'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Country',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              value: selectedCountry,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCountry = newValue!;
                                });
                              },
                              items: countries.map((String country) {
                                return DropdownMenuItem<String>(
                                  value: country, // Make sure values are unique
                                  child: Text(country),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                hintText: 'Country',
                                icon: Icon(
                                  Icons.place,
                                  color:
                                      COLOR_ACCENT, // Change to your desired color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('Select your country'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Postal Code',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              maxLength: 5,
                              controller: zipcode,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Postal/Zip Code',
                                icon: Icon(
                                  Icons.code,
                                  color: COLOR_ACCENT,
                                ),
                              ),
                              validator: (value) {
                                if (value?.length != 5) {
                                  return '*Enter correct postal code';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('Postal code of your Area'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phone Number *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              controller: phonenumber,
                              decoration: const InputDecoration(
                                hintText: 'Phone Number',
                                prefix: Text('+92'),
                                icon: Icon(
                                  Icons.contact_phone,
                                  color: COLOR_ACCENT,
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Please enter your phone number';
                                } else if (value.length != 10) {
                                  return '*Phone number is incorrect';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('+923xxxxxxxxx'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              controller: email,
                              enabled: false,
                              decoration: const InputDecoration(
                                hintText: 'Use Same E-Mail you logged in',
                                icon: Icon(
                                  Icons.mail,
                                  color: COLOR_ACCENT,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('Leave this section'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Company Overview',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ), // Text color
                              controller: generalDetail,
                              maxLines: null, // Allow flexible number of lines
                              decoration: const InputDecoration(
                                hintText: 'General Details of Services',
                                icon: Icon(
                                  Icons.description,
                                  color: COLOR_ACCENT,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Please enter product description';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('Detals of your selling product'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Banking Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bank Name *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              controller: bankName,
                              decoration: const InputDecoration(
                                hintText: 'Bank Name',
                                icon: Icon(
                                  Icons.comment_bank,
                                  color: COLOR_ACCENT,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Please enter your bank name';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('Bank name having current account'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              ' IBAN # *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              maxLength: 24,
                              controller: benificiaryName,
                              decoration: const InputDecoration(
                                hintText: 'Beneficiary Bank Account #',
                                icon: Icon(
                                  Icons.account_box,
                                  color: COLOR_ACCENT,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Please enter your IBAN #';
                                } else if (value.length != 24) {
                                  return '*Enter correct IBAN';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('PK82xxxxxxxxxxx'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              ' Bank Account # *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: accountNumber,
                              decoration: const InputDecoration(
                                hintText: 'Account Number',
                                icon: Icon(
                                  Icons.numbers,
                                  color: COLOR_ACCENT,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Please enter your account number';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('375394xxxxxxxx'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Basic Price *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: price,
                              decoration: const InputDecoration(
                                hintText: 'Enter the numerical price',
                                icon: Icon(
                                  Icons.attach_money,
                                  color: COLOR_ACCENT,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a price';
                                }
                                // Convert the input value to a double
                                double? priceValue = double.tryParse(value);

                                // Check if the value is less than 1000
                                if (priceValue != null && priceValue < 1000) {
                                  return '*Minimum price is 1000';
                                }
                                return null; // Return null if the input is valid
                              },
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('Set your service price'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Basic package description *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              controller: priceDescription,
                              decoration: const InputDecoration(
                                hintText: 'Enter basic package description',
                                icon: Icon(
                                  Icons.description,
                                  color: COLOR_ACCENT,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const ElTooltip(
                        content: Text('Enter basic package description'),
                        child: Icon(
                          Icons.info_outline,
                          color: COLOR_ACCENT,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Icon(
                                Icons.list,
                                size: 16,
                                color: COLOR_ACCENT,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: COLOR_ACCENT,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          value: category,
                          onChanged: (String? newVal) {
                            setState(() {
                              category = newVal!;
                            });
                          },
                          items: productCategories
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          buttonStyleData: ButtonStyleData(
                            height: 50,
                            width: 160,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: COLOR_PRIMARY,
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.black,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    color: Colors.white,
                    onTap: editProduct,
                    text: 'Submit Request',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
