import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/views/item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsTab extends StatelessWidget {
  const ItemsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemView(
      itemFuture: Provider.of<DataSync>(context).getAllItems,
      title: 'Items',
    );
  }
}
