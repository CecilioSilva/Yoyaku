import 'package:yoyaku/components/extras/icon_toggle.dart';
import 'package:yoyaku/components/form_fields/custom_dropdown_form_field.dart';
import 'package:yoyaku/components/views/grid_view.dart';
import 'package:yoyaku/components/views/list_view.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:flutter/material.dart';

enum ViewType {
  list,
  grid,
}

class CategoryView extends StatefulWidget {
  final Future<List<Item>> itemFuture;
  final String title;
  final ViewType type;

  const CategoryView({
    Key? key,
    required this.itemFuture,
    this.title = '',
    this.type = ViewType.list,
  }) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  bool isList = true;
  ViewType type = ViewType.list;
  String category = 'Figure';

  Future<List<Item>> getItems(String category) async {
    await Future.delayed(const Duration(milliseconds: 200));
    List<Item> items = await widget.itemFuture;

    Map<String, List<Item>> types = {
      'Figure': [],
      'Manga': [],
      'Game': [],
      'Other': [],
    };

    for (Item item in items) {
      types[['Figure', 'Manga', 'Game', 'Other'][item.type]]!.add(item);
    }

    return types[category] ?? [];
  }

  @override
  void initState() {
    super.initState();
    isList = widget.type == ViewType.list;
    type = widget.type;
  }

  Widget getViewType(String category) {
    switch (type) {
      case ViewType.list:
        return ItemListView(itemFuture: () => getItems(category));
      case ViewType.grid:
        return ItemGridView(itemFuture: () => getItems(category));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Visibility(
                visible: widget.title != '',
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  IconToggle(
                    value: isList,
                    onPressed: (bool newValue) => setState(
                      () {
                        isList = newValue;
                        type = isList ? ViewType.list : ViewType.grid;
                      },
                    ),
                    trueIcon: Icons.apps,
                    falseIcon: Icons.list,
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropDownField(
                  items: [
                    CustomDropdownValue(value: 'Figure', name: 'Figure'),
                    CustomDropdownValue(value: 'Manga', name: 'Manga'),
                    CustomDropdownValue(value: 'Game', name: 'Game'),
                    CustomDropdownValue(value: 'Other', name: 'Other'),
                  ],
                  onChanged: (value) {
                    setState(() {
                      category = value!;
                    });
                  },
                  title: 'Type',
                  initalValue: 'Figure',
                ),
              ),
              Expanded(
                child: getViewType(category),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
