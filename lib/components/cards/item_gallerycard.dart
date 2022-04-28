import 'package:amiamu/classes/item_data.dart';
import 'package:flutter/material.dart';

class ItemGalleryCard extends StatelessWidget {
  final ItemData data;
  const ItemGalleryCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          //TODO: Add Item Editing
          print('Editing ${data.uuid}');
        },
        child: CoverImage(
          size: size,
          data: data,
        ),
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key? key,
    required this.size,
    required this.data,
  }) : super(key: key);

  final Size size;
  final ItemData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Hero(
        tag: data.title,
        child: Container(
          width: size.width * 0.7,
          height: size.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: Colors.orange),
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              image: MemoryImage(data.image),
            ),
          ),
        ),
      ),
    );
  }
}
