import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:eventify/features/home/widgets/card.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';

class WedDress extends StatefulWidget {
  @override
  State<WedDress> createState() => _WeddingsState();
}

class _WeddingsState extends State<WedDress> {
  List<Product> Dresslist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Dresslist = await adminServices.fetchcatagory(
        context: context, catagory: 'Wedding Dress Boutique');
    print(Dresslist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Dresslist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Dresslist.isEmpty
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
                        (Dresslist.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex = (rowIndex + 1) * 2;
                          return Row(
                            children: [
                              for (int index = startIndex;
                                  index < endIndex;
                                  index++)
                                if (index < Dresslist.length)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Cardss(
                                        product: Dresslist[index],
                                        image: Dresslist[index].images[0],
                                        name: Dresslist[index].businessName,
                                        price: Dresslist[index].price,
                                        onDelete: () {
                                          deleteproduct(
                                              Dresslist[index], index);
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
