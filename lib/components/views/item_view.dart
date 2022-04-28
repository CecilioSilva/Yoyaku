import 'package:yoyaku/components/extras/icon_toggle.dart';
import 'package:yoyaku/components/views/gallery_view.dart';
import 'package:yoyaku/components/views/grid_view.dart';
import 'package:yoyaku/components/views/list_view.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:flutter/material.dart';

enum ViewType {
  list,
  grid,
  gallery,
}

class ItemView extends StatefulWidget {
  final Future<List<Item>> itemFuture;
  final bool canChange;
  final bool canOrder;
  final String title;
  final ViewType type;

  const ItemView({
    Key? key,
    required this.itemFuture,
    this.canChange = true,
    this.canOrder = true,
    this.title = '',
    this.type = ViewType.list,
  }) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  bool isReversed = false;
  bool isList = true;
  bool isGallery = false;
  ViewType type = ViewType.list;

  Future<List<Item>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<Item> items = await widget.itemFuture;
    return isReversed ? items.reversed.toList() : items;
  }

  @override
  void initState() {
    super.initState();
    isList = widget.type == ViewType.list;
    isGallery = widget.type == ViewType.gallery;
    type = widget.type;
  }

  Widget getViewType() {
    if (!isGallery) {
      type = isList ? ViewType.list : ViewType.grid;
    }

    switch (type) {
      case ViewType.list:
        return ItemListView(itemFuture: getItems);
      case ViewType.grid:
        return ItemGridView(itemFuture: getItems);
      case ViewType.gallery:
        return ItemGalleryView(itemFuture: getItems);
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
                  Visibility(
                    visible: widget.canChange && !isGallery,
                    child: IconToggle(
                      value: isList,
                      onPressed: (bool newValue) => setState(
                        () => isList = newValue,
                      ),
                      trueIcon: Icons.apps,
                      falseIcon: Icons.list,
                    ),
                  ),
                  Visibility(
                    visible: widget.canOrder,
                    child: IconToggle(
                      value: isReversed,
                      onPressed: (bool newValue) => setState(
                        () => isReversed = newValue,
                      ),
                      trueIcon: Icons.sort_by_alpha,
                      falseIcon: Icons.sort_by_alpha,
                      falseColor: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: getViewType(),
        ),
      ],
    );
  }
}
