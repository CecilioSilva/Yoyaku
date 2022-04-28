import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/views/total_view.dart';

class TotalTab extends StatelessWidget {
  const TotalTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rates = context.watch<Map?>();
    return TotalView(
      totalFuture: Provider.of<DataSync>(context).getTotalData(rates),
    );
  }
}
