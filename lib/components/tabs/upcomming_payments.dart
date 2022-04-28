import 'package:amiamu/classes/data_sync.dart';
import 'package:amiamu/components/views/item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcommingPaymentTab extends StatelessWidget {
  const UpcommingPaymentTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemView(
      itemFuture: Provider.of<DataSync>(context).getUpcommingPayments(),
      title: 'Upcomming payments',
    );
  }
}
