import 'package:flutter/material.dart';

// import '../../../common/Loader.dart';
import '../../../models/Product.dart';
import '../Widgets/card.dart';
import '../services/admin_services.dart';

class Mehndi extends StatefulWidget {
  @override
  State<Mehndi> createState() => _WeddingsState();
}

class _WeddingsState extends State<Mehndi> {
  List<Product> Mehndilist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Mehndilist = await adminServices.fetchcatagory(
        context: context, catagory: 'Mehndi Artist');
    print(Mehndilist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Mehndilist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Mehndilist.isEmpty
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
                        (Mehndilist.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex = (rowIndex + 1) * 2;
                          return Row(
                            children: [
                              for (int index = startIndex;
                                  index < endIndex;
                                  index++)
                                if (index < Mehndilist.length)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Cardss(
                                        product: Mehndilist[index],
                                        image: Mehndilist[index].images[0],
                                        name: Mehndilist[index].businessName,
                                        price: Mehndilist[index].price,
                                        onDelete: () {
                                          deleteproduct(
                                              Mehndilist[index], index);
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
