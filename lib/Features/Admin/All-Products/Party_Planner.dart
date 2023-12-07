import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';

import '../../UserHome/widgets/card.dart';



class PartyPlanner extends StatefulWidget {
  const PartyPlanner({Key? key}) : super(key: key);

  @override
  State<PartyPlanner> createState() => _PartyPlannerState();
}

class _PartyPlannerState extends State<PartyPlanner> {
  List<Product> Party_plannerlist = [];
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchweddinglistcatagory();
  }

  void fetchweddinglistcatagory() async {
    Party_plannerlist = await adminServices.fetchcatagory(
        context: context, catagory: 'Party Planner');
    print(Party_plannerlist.length);
    setState(() {});
  }

  void deleteproduct(Product product, int index) {
    adminServices.deleteproduct(
        context: context,
        product: product,
        onsuccess: () {
          Party_plannerlist.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Party Planner', // Add margin to this text
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Party_plannerlist.isEmpty
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
                        (Party_plannerlist.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex = (rowIndex + 1) * 2;
                          return Row(
                            children: [
                              for (int index = startIndex;
                                  index < endIndex;
                                  index++)
                                if (index < Party_plannerlist.length)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Cardss(
                                        product: Party_plannerlist[index],
                                        image:
                                            Party_plannerlist[index].images[0],
                                        name: Party_plannerlist[index]
                                            .businessName,
                                        price: Party_plannerlist[index].price,
                                        onDelete: () {
                                          deleteproduct(
                                              Party_plannerlist[index], index);
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
