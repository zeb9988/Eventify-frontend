import 'package:flutter/material.dart';

// import '../../../common/widgets/Loader.dart';
import '../../../models/Product.dart';

import '../../UserHome/widgets/card.dart';
import '../services/admin_services.dart';

class Florist extends StatefulWidget {
  @override
  State<Florist> createState() => _CataringsState();
}

class _CataringsState extends State<Florist> {
  List<Product> Floristlist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Floristlist = await adminServices.fetchcatagory(
        context: context, catagory: 'Florists');
    print(Floristlist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Floristlist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Floristlist.isEmpty
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
                    (Floristlist.length / 2).ceil(),
                    (rowIndex) {
                      final startIndex = rowIndex * 2;
                      final endIndex = (rowIndex + 1) * 2;
                      return Row(
                        children: [
                          for (int index = startIndex;
                              index < endIndex;
                              index++)
                            if (index < Floristlist.length)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Cardss(
                                    product: Floristlist[index],
                                    image: Floristlist[index].images[0],
                                    name: Floristlist[index].businessName,
                                    price: Floristlist[index].price,
                                    onDelete: () {
                                      deleteproduct(Floristlist[index], index);
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
            });
  }
}
