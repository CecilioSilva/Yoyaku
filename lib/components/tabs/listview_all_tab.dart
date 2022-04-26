import 'package:amiamu/classes/data_sync.dart';
import 'package:amiamu/components/item_listcard.dart';
import 'package:amiamu/models/database_model.dart';
import 'package:amiamu/classes/item_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewTab extends StatelessWidget {
  const ListViewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: Provider.of<DataSync>(context).getAllItems,
      initialData: const [],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var snapshotData = snapshot.data;
          if (snapshotData != null) {
            return ListView.builder(
              itemCount: snapshotData.length,
              itemBuilder: (BuildContext context, int index) {
                Item item = snapshotData[index];
                final data = ItemData(item);
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
