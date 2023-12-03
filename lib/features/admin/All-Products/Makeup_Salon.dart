import 'package:flutter/material.dart';

// import '../../../common/Loader.dart';
import '../../../models/Product.dart';
import '../../home/widgets/card.dart';
import '../services/admin_services.dart';

class Makeup extends StatefulWidget {
  @override
  State<Makeup> createState() => _WeddingsState();
}

class _WeddingsState extends State<Makeup> {
  List<Product> Makeuplist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Makeuplist = await adminServices.fetchcatagory(
        context: context, catagory: 'Makeup Artist & Salon');
    print(Makeuplist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Makeuplist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Makeuplist.isEmpty
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
                        (Makeuplist.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex = (rowIndex + 1) * 2;
                          return Row(
                            children: [
                              for (int index = startIndex;
                                  index < endIndex;
                                  index++)
                                if (index < Makeuplist.length)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Cardss(
                                        product: Makeuplist[index],
                                        image: Makeuplist[index].images[0],
                                        name: Makeuplist[index].businessName,
                                        price: Makeuplist[index].price,
                                        onDelete: () {
                                          deleteproduct(
                                              Makeuplist[index], index);
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
