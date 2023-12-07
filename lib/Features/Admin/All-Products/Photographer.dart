
import 'package:flutter/material.dart';

// import '../../../common/Loader.dart';
import '../../../models/Product.dart';
import '../../UserHome/widgets/card.dart';
import '../services/admin_services.dart';

class Photographer extends StatefulWidget {
  @override
  State<Photographer> createState() => _WeddingsState();
}

class _WeddingsState extends State<Photographer> {
  List<Product> Photographerlist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Photographerlist = await adminServices.fetchcatagory(
        context: context, catagory: 'Photographer');
    print(Photographerlist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Photographerlist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Photographerlist.isEmpty
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
                          (Photographerlist.length / 2).ceil(),
                          (rowIndex) {
                            final startIndex = rowIndex * 2;
                            final endIndex = (rowIndex + 1) * 2;
                            return Row(
                              children: [
                                for (int index = startIndex;
                                    index < endIndex;
                                    index++)
                                  if (index < Photographerlist.length)
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Cardss(
                                          product: Photographerlist[index],
                                          image:
                                              Photographerlist[index].images[0],
                                          name: Photographerlist[index]
                                              .businessName,
                                          price: Photographerlist[index].price,
                                          onDelete: () {
                                            deleteproduct(
                                                Photographerlist[index], index);
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
