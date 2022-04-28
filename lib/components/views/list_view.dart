import 'package:yoyaku/components/extras/custom_error.dart';
import 'package:yoyaku/components/extras/loading.dart';
import 'package:yoyaku/components/extras/non_found.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/components/cards/item_listcard.dart';

class ItemListView extends StatelessWidget {
  final Future<List<Item>> Function() itemFuture;

  const ItemListView({Key? key, required this.itemFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: itemFuture(),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return CustomError(error: snapshot.error);
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) return const NonFound();

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final rates = context.watch<Map>();
                Item item = snapshot.data![index];
                final data = ItemData(item, rates);
                return ItemListCard(data);
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
