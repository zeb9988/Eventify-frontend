import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';

import '../Widgets/card.dart';

// import '../../../common/widgets/Loader.dart';

class Cataring extends StatefulWidget {
  @override
  State<Cataring> createState() => _CataringsState();
}

class _CataringsState extends State<Cataring> {
  List<Product> cateringlist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    cateringlist = await adminServices.fetchcatagory(
        context: context, catagory: 'Catering');
    print(cateringlist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          cateringlist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cateringlist.isEmpty
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
                          (cateringlist.length / 2).ceil(),
                          (rowIndex) {
                            final startIndex = rowIndex * 2;
                            final endIndex = (rowIndex + 1) * 2;
                            return Row(
                              children: [
                                for (int index = startIndex;
                                    index < endIndex;
                                    index++)
                                  if (index < cateringlist.length)
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Cardss(
                                          product: cateringlist[index],
                                          image: cateringlist[index].images[0],
                                          name:
                                              cateringlist[index].businessName,
                                          price: cateringlist[index].price,
                                          onDelete: () {
                                            deleteproduct(
                                                cateringlist[index], index);
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
      ),
    );
  }
}
