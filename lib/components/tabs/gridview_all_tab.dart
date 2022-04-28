import 'package:amiamu/classes/data_sync.dart';
import 'package:amiamu/classes/item_data.dart';
import 'package:amiamu/components/item_gridcard.dart';
import 'package:amiamu/components/waiting.dart';
import 'package:amiamu/models/database_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridViewTab extends StatelessWidget {
  const GridViewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: Provider.of<DataSync>(context).getAllItems,
      initialData: [],
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var snapshotData = snapshot.data;
          if (snapshotData != null) {
            if (snapshotData.isEmpty) return const Waiting();
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshotData.length,
              itemBuilder: (context, index) {
                final rates = context.watch<Map?>();
                Item item = snapshotData[index];
                ItemData data = ItemData(item, rates);
                return ItemGridCard(data);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
