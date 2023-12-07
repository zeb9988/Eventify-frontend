import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';

class Venues extends StatefulWidget {
  const Venues({Key? key}) : super(key: key);

  @override
  State<Venues> createState() => _VenuesState();
}

class _VenuesState extends State<Venues> {
  List<Product> Venueslist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Venueslist =
        await adminServices.fetchcatagory(context: context, catagory: 'Venues');
    print(Venueslist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Venueslist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Venueslist.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('No data'),
              )
            : StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.transparent,
                    height: 205,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Scroll horizontally
                      itemCount: Venueslist.length,
                      itemBuilder: (context, index) {
                        final productdata = Venueslist[index];
                        return AspectRatio(
                          aspectRatio: 2 / 2.2,
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              border: Border.all(color: Colors.grey, width: 2),
                              image: DecorationImage(
                                  image: NetworkImage(productdata.images[0]),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(.9),
                                        Colors.black.withOpacity(.0),
                                      ]),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 90,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productdata.businessName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                              height: 10), // Add some spacing
                                          Text(
                                            '\$${productdata.price}',
                                            // Example price
                                            style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    // Use Spacer to push the IconButton to the bottom
                                    IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        deleteproduct(productdata, index);
                                      },
                                      icon: Icon(Icons.delete_outline),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  );
                }),
      ],
    );
  }
}
