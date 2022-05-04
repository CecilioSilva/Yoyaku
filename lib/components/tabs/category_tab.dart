import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/views/category_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryView(
      itemFuture: Provider.of<DataSync>(context).getAllUnCanceledItems,
      title: 'Categories',
    );
  }
}
