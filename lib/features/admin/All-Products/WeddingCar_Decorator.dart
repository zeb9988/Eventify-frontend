import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:eventify/features/home/widgets/card.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';

// import '../../../common/Loader.dart';

class WedCarDecore extends StatefulWidget {
  @override
  State<WedCarDecore> createState() => _WeddingsState();
}

class _WeddingsState extends State<WedCarDecore> {
  List<Product> CarDecoratorlist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    CarDecoratorlist = await adminServices.fetchcatagory(
        context: context, catagory: 'Wedding Car Decorators');
    print(CarDecoratorlist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          CarDecoratorlist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarDecoratorlist.isEmpty
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
                        (CarDecoratorlist.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex = (rowIndex + 1) * 2;
                          return Row(
                            children: [
                              for (int index = startIndex;
                                  index < endIndex;
                                  index++)
                                if (index < CarDecoratorlist.length)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Cardss(
                                        product: CarDecoratorlist[index],
                                        image:
                                            CarDecoratorlist[index].images[0],
                                        name: CarDecoratorlist[index]
                                            .businessName,
                                        price: CarDecoratorlist[index].price,
                                        onDelete: () {
                                          deleteproduct(
                                              CarDecoratorlist[index], index);
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
