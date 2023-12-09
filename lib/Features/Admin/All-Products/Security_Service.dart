import 'package:flutter/material.dart';

// import '../../../common/Loader.dart';
import '../../../models/Product.dart';
import '../Widgets/card.dart';
import '../services/admin_services.dart';

class Security extends StatefulWidget {
  @override
  State<Security> createState() => _WeddingsState();
}

class _WeddingsState extends State<Security> {
  List<Product> Securitylist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Securitylist = await adminServices.fetchcatagory(
        context: context, catagory: 'Security Service');
    print(Securitylist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Securitylist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Securitylist.isEmpty
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
                        (Securitylist.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex = (rowIndex + 1) * 2;
                          return Row(
                            children: [
                              for (int index = startIndex;
                                  index < endIndex;
                                  index++)
                                if (index < Securitylist.length)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Cardss(
                                        product: Securitylist[index],
                                        image: Securitylist[index].images[0],
                                        name: Securitylist[index].businessName,
                                        price: Securitylist[index].price,
                                        onDelete: () {
                                          deleteproduct(
                                              Securitylist[index], index);
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
