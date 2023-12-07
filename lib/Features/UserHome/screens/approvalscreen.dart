import 'package:dotted_border/dotted_border.dart';
import 'package:eventify/common/widgets/customDialogBox.dart';
import 'package:eventify/common/widgets/customSnackbar.dart';
import 'package:eventify/common/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import '../../../constant/Theme_constant.dart';
import '../../../models/Product.dart';
import '../services/userServices.dart';
import '../../Vendor/Services/vendor_services.dart';
import 'edit.dart';

class ApprovedRequest extends StatefulWidget {
  static const String id = '/approvedapproval';

  const ApprovedRequest({Key? key}) : super(key: key);

  @override
  _ApprovedRequestState createState() => _ApprovedRequestState();
}

class _ApprovedRequestState extends State<ApprovedRequest> {
  List<Product> approvedRequests = [];
  VendorServices vendorServices = VendorServices();

  @override
  void initState() {
    fetchUserVendors();
    super.initState();
  }

  void deleteproduct(Product product, int index) {
    UserServices userServices = UserServices();
    userServices.deleteVendor(
        context: context,
        product: product,
        onsuccess: () {
          approvedRequests.removeAt(index);

          setState(() {});
        });
  }

  void fetchUserVendors() async {
    approvedRequests = await vendorServices.fetchuserVendor(context: context);
    print(approvedRequests);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: COLOR_PRIMARY,
        centerTitle: true,
        title: Text(
          'Approved Products',
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
          SizedBox(height: 20),
          if (approvedRequests.isEmpty)
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
                      "No Approved Requests",
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
              shrinkWrap: true,
              itemCount: approvedRequests.length,
              itemBuilder: (context, index) {
                final request = approvedRequests[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ApprovedReqCard(
                    ondeleted: () {
                      deleteproduct(approvedRequests[index], index);
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

class ApprovedReqCard extends StatelessWidget {
  final Product product;
  final VoidCallback ondeleted;
  ApprovedReqCard({Key? key, required this.product, required this.ondeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey.shade200,
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle, // Use an approved icon of your choice
                      color: Colors.green, // Set the icon color
                      size: 15,
                    ),
                    Text(
                      "Approved",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  product.businessName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.category,
                  style: TextStyle(
                    color: Colors.orange,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  product.generalDetail,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  '\Rs${product.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    'Delete',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    color: COLOR_ACCENT,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          title: "Are you sure you want to Delete?",
                          icon: Icons.delete, // Replace with your desired icon
                          buttons: [
                            CustomButton(
                                text: "Yes",
                                onTap: () {
                                  ondeleted();
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
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Edit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    color: COLOR_ACCENT,
                    onPressed: () {
                      Navigator.pushNamed(context, EditProduct.id,
                          arguments: product);
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
