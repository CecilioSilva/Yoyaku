import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/views/order_view.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderView(itemFuture: Provider.of<DataSync>(context).getOrders());
  }
}
