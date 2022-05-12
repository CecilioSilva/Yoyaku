import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/components/cards/item_gridcard_minimal.dart';
import 'package:yoyaku/components/extras/custom_error.dart';
import 'package:yoyaku/components/extras/loading.dart';
import 'package:yoyaku/components/extras/non_found.dart';
import 'package:yoyaku/models/database_model.dart';

class ItemMonthView extends StatefulWidget {
  final Future<Map<String, List<Item>>> itemFuture;

  const ItemMonthView({Key? key, required this.itemFuture}) : super(key: key);

  @override
  State<ItemMonthView> createState() => _ItemMonthViewState();
}

class _ItemMonthViewState extends State<ItemMonthView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<Map<String, List<Item>>>(
      future: widget.itemFuture,
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

            return RefreshIndicator(
              backgroundColor: const Color(0xFF03071e),
              color: Colors.orange,
              onRefresh: () async {
                setState(() {});
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 10,
                      right: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Monthly',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: keyList.length,
                      itemBuilder: (context, keyIndex) {
                        List itemList =
                            snapshot.data!.values.toList()[keyIndex];

                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      keyList[keyIndex],
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
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
