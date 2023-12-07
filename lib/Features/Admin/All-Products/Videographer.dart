import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';

import '../../UserHome/widgets/card.dart';

class Videographer extends StatefulWidget {
  @override
  State<Videographer> createState() => _WeddingsState();
}

class _WeddingsState extends State<Videographer> {
  List<Product> Videographerlist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Videographerlist = await adminServices.fetchcatagory(
        context: context, catagory: 'Videographer');
    print(Videographerlist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Videographerlist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Videographerlist.isEmpty
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
                        (Videographerlist.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex = (rowIndex + 1) * 2;
                          return Row(
                            children: [
                              for (int index = startIndex;
                                  index < endIndex;
                                  index++)
                                if (index < Videographerlist.length)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Cardss(
                                        product: Videographerlist[index],
                                        image:
                                            Videographerlist[index].images[0],
                                        name: Videographerlist[index]
                                            .businessName,
                                        price: Videographerlist[index].price,
                                        onDelete: () {
                                          deleteproduct(
                                              Videographerlist[index], index);
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
