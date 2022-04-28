import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/components/cards/item_gallerycard.dart';
import 'package:yoyaku/components/extras/custom_error.dart';
import 'package:yoyaku/components/extras/loading.dart';
import 'package:yoyaku/components/extras/non_found.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemGalleryView extends StatelessWidget {
  final Future<List<Item>> Function() itemFuture;

  const ItemGalleryView({Key? key, required this.itemFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: itemFuture(),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return CustomError(error: snapshot.error);
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) return const NonFound();

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 1.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final rates = context.watch<Map?>();
                Item item = snapshot.data![index];
                ItemData data = ItemData(item, rates);
                return ItemGalleryCard(data);
              },
            );
          } else {
            return const NonFound();
          }
        } else {
          return const Loading();
        }
      },
    );
  }
}
