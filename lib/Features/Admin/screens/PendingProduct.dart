import 'package:dotted_border/dotted_border.dart';
import 'package:eventify/common/widgets/customSnackbar.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/admin/screens/Detail_Screen.dart';
import 'package:flutter/material.dart';
import '../../../models/approvedVendor.dart';
import '../../Vendor/Services/vendor_services.dart';

class VendorProductRequest extends StatefulWidget {
  static const String id = '/UserPending';

  const VendorProductRequest({Key? key}) : super(key: key);
  @override
  State<VendorProductRequest> createState() => _VendorProductRequestState();
}

class _VendorProductRequestState extends State<VendorProductRequest> {
  List<ApprovedVendors> vendorRequests = [];
  VendorServices vendorServices = VendorServices();

  // AdminServices adminServices = AdminServices();

  void acceptApprovals(ApprovedVendors product, int index) async {
    vendorServices.acceptApproval(
        context: context,
        images: product.images,
        userId: product.userId,
        businessName: product.businessName,
        address: product.address,
        city: product.city,
        state: product.state,
        zipcode: product.zipcode,
        country: product.country,
        phonenumber: product.phonenumber,
        email: product.email,
        generalDetail: product.generalDetail,
        insuredValue: product.insureValue,
        licenseHolder: product.licensedValue,
        bankName: product.bankName,
        category: product.category,
        benificiaryName: product.benificiaryName,
        accountNumber: product.accountNumber,
        price: product.price,
        priceDescription: product.priceDescription);

    vendorServices.removeApproval(
        context: context,
        product: product,
        onsuccess: () {
          vendorRequests.removeAt(index);
          // showSnackBar(context, 'done');
          setState(() {});
        });
  }

  void declineapproval(ApprovedVendors product, int index) async {
    vendorServices.removeApproval(
        context: context,
        product: product,
        onsuccess: () {
          vendorRequests.removeAt(index);
          showCustomSnackBar(
              context: context, text: 'Done', label: 'ok', onPressed: () {});
          setState(() {});
        });
  }

  @override
  void initState() {
    fetchVendor2();
    super.initState();
  }

  void fetchVendor2() async {
    vendorRequests = await vendorServices.fetchVendors(context: context);
    // print(vendorRequests[1].catagory);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: COLOR_PRIMARY,
        centerTitle: true,
        title: const Text(
          'Pending Products',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (vendorRequests.isEmpty)
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: DottedBorder(
                color: COLOR_ACCENT,
                radius: const Radius.circular(10),
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "No Pending Products",
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
          Expanded(
            child: ListView.builder(
              shrinkWrap:
                  true, // Ensure the ListView takes only the required height
              itemCount: vendorRequests.length,
              itemBuilder: (context, index) {
                final request = vendorRequests[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PendingReqCard(
                    onDecline: () {
                      declineapproval(vendorRequests[index], index);
                    },
                    onAccept: () {
                      acceptApprovals(vendorRequests[index], index);
                    },
                    product: request,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PendingReqCard extends StatelessWidget {
  final ApprovedVendors product;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  PendingReqCard({
    Key? key,
    required this.product,
    required this.onAccept,
    required this.onDecline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Status",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.pending,
                  color: COLOR_ACCENT,
                  size: 15,
                ),
                Text(
                  "Pending",
                  style: TextStyle(
                    color: COLOR_ACCENT,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, DetailScreen.id,
                            arguments: product);
                      },
                      child: Row(
                        children: [
                          Text(
                            'Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Text(
              product.businessName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product.generalDetail,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '\Rs${product.price}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: onAccept,
                  child: const Text(
                    "Accept",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onDecline,
                  child: const Text(
                    "Decline",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// class Productsss {
//   final List<String> images;
//   final String businessName;
//   final String generalDetail;
//   final double price;

//   Productsss({
//     required this.images,
//     required this.businessName,
//     required this.generalDetail,
//     required this.price,
//   });
// }
