import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/views/item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcommingTab extends StatelessWidget {
  const UpcommingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemView(
      itemFuture: Provider.of<DataSync>(context).getUpcommingItems(),
      title: 'Upcoming Items',
    );
  }
}
