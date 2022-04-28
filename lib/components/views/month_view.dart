import 'package:amiamu/classes/item_data.dart';
import 'package:amiamu/components/cards/item_gridcard_minimal.dart';
import 'package:amiamu/components/extras/custom_error.dart';
import 'package:amiamu/components/extras/loading.dart';
import 'package:amiamu/components/extras/non_found.dart';
import 'package:amiamu/models/database_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemMonthView extends StatelessWidget {
  final Future<Map<String, List<Item>>> itemFuture;

  const ItemMonthView({Key? key, required this.itemFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<Item>>>(
      future: itemFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot<Map<String, List<Item>>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return CustomError(error: snapshot.error);
          } else if (snapshot.hasData) {
            List keyList = snapshot.data!.keys.toList();

            if (keyList.isEmpty) return const NonFound();

            return ListView.builder(
              itemCount: keyList.length,
              itemBuilder: (context, keyIndex) {
                List itemList = snapshot.data!.values.toList()[keyIndex];

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          keyList[keyIndex],
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: itemList.length,
                      itemBuilder: (context, itemIndex) {
                        final rates = context.watch<Map?>();
                        Item item = itemList[itemIndex];
                        ItemData data = ItemData(item, rates);
                        return ItemGridMinimalCard(data);
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            return const NonFound();
          }
        } else {
          return const Loading();
        }
      },
    );
  }
}
