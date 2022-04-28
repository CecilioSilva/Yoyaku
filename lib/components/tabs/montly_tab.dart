import 'package:amiamu/classes/data_sync.dart';
import 'package:amiamu/components/views/month_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MontlyTab extends StatelessWidget {
  const MontlyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemMonthView(
      itemFuture: Provider.of<DataSync>(context).getMontlyItems(),
    );
  }
}
