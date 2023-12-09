import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';

import '../Widgets/card.dart';


class Branding extends StatefulWidget {
  @override
  State<Branding> createState() => _WeddingsState();
}

class _WeddingsState extends State<Branding> {
  List<Product> BrandMarklist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    BrandMarklist = await adminServices.fetchcatagory(
        context: context, catagory: 'Branding & Marketing');
    print(BrandMarklist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          BrandMarklist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandMarklist.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('No data'),
              )
            : StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: List.generate(
                        (BrandMarklist.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex = (rowIndex + 1) * 2;
                          return Row(
                            children: [
                              for (int index = startIndex;
                                  index < endIndex;
                                  index++)
                                if (index < BrandMarklist.length)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Cardss(
                                        product: BrandMarklist[index],
                                        image: BrandMarklist[index].images[0],
                                        name: BrandMarklist[index].businessName,
                                        price: BrandMarklist[index].price,
                                        onDelete: () {
                                          deleteproduct(
                                              BrandMarklist[index], index);
                                        },
                                      ),
                                    ),
                                  )
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }),
      ],
    );
  }
}
