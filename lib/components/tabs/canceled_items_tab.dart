import 'package:amiamu/classes/data_sync.dart';
import 'package:amiamu/components/cards/item_listcard.dart';
import 'package:amiamu/components/extras/non_found.dart';
import 'package:amiamu/models/database_model.dart';
import 'package:amiamu/classes/item_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CanceledTab extends StatelessWidget {
  const CanceledTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: Provider.of<DataSync>(context).getCanceledItems,
      initialData: const [],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var snapshotData = snapshot.data;
          if (snapshotData != null) {
            if (snapshotData.isEmpty) return const NonFound();
            return ListView.builder(
              itemCount: snapshotData.length,
              itemBuilder: (BuildContext context, int index) {
                final rates = context.watch<Map>();
                Item item = snapshotData[index];
                final data = ItemData(item, rates);
                return ItemListCard(data);
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
