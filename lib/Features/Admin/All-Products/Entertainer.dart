import 'package:flutter/material.dart';

// import '../../../common/widgets/Loader.dart';
import '../../../models/Product.dart';
import '../../home/widgets/card.dart';
import '../services/admin_services.dart';

class Entertainer extends StatefulWidget {
  @override
  State<Entertainer> createState() => _CataringsState();
}

class _CataringsState extends State<Entertainer> {
  List<Product> Entertainerlist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Entertainerlist = await adminServices.fetchcatagory(
        context: context, catagory: 'Entertainer');
    print(Entertainerlist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Entertainerlist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Entertainerlist.isEmpty
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
                        (Entertainerlist.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex = (rowIndex + 1) * 2;
                          return Row(
                            children: [
                              for (int index = startIndex;
                                  index < endIndex;
                                  index++)
                                if (index < Entertainerlist.length)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Cardss(
                                        product: Entertainerlist[index],
                                        image: Entertainerlist[index].images[0],
                                        name: Entertainerlist[index].businessName,
                                        price: Entertainerlist[index].price,
                                        onDelete: () {
                                          deleteproduct(
                                              Entertainerlist[index], index);
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
