import 'package:flutter/material.dart';

// import '../../../common/Loader.dart';
import '../../../models/Product.dart';
import '../Widgets/card.dart';
import '../services/admin_services.dart';

class Jewelry extends StatefulWidget {
  @override
  State<Jewelry> createState() => _WeddingsState();
}

class _WeddingsState extends State<Jewelry> {
  List<Product> Jewelrylist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Jewelrylist = await adminServices.fetchcatagory(
        context: context, catagory: 'Jewelry Store');
    print(Jewelrylist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Jewelrylist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Jewelrylist.isEmpty
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
                        (Jewelrylist.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex = (rowIndex + 1) * 2;
                          return Row(
                            children: [
                              for (int index = startIndex;
                                  index < endIndex;
                                  index++)
                                if (index < Jewelrylist.length)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Cardss(
                                        product: Jewelrylist[index],
                                        image: Jewelrylist[index].images[0],
                                        name: Jewelrylist[index].businessName,
                                        price: Jewelrylist[index].price,
                                        onDelete: () {
                                          deleteproduct(
                                              Jewelrylist[index], index);
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
