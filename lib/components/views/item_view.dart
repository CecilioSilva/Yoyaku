import 'package:amiamu/components/extras/icon_toggle.dart';
import 'package:amiamu/components/views/grid_view.dart';
import 'package:amiamu/components/views/list_view.dart';
import 'package:amiamu/models/database_model.dart';
import 'package:flutter/material.dart';

class ItemView extends StatefulWidget {
  final Future<List<Item>> itemFuture;
  final bool canChange;

  const ItemView({
    Key? key,
    required this.itemFuture,
    this.canChange = true,
  }) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  bool isReversed = false;
  bool isList = true;

  Future<List<Item>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<Item> items = await widget.itemFuture;
    return isReversed ? items.reversed.toList() : items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconToggle(
              value: isList,
              onPressed: (bool newValue) => setState(
                () => isList = newValue,
              ),
              trueIcon: Icons.apps,
              falseIcon: Icons.list,
            ),
            IconToggle(
              value: isReversed,
              onPressed: (bool newValue) => setState(
                () => isReversed = newValue,
              ),
              trueIcon: Icons.sort_by_alpha,
              falseIcon: Icons.sort_by_alpha,
              falseColor: Colors.orange,
            ),
          ],
        ),
        Expanded(
          child: isList
              ? ItemListView(
                  itemFuture: getItems,
                )
              : ItemGridView(
                  itemFuture: getItems,
                ),
        ),
      ],
    );
  }
}
