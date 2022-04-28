import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/components/extras/type_tag.dart';
import 'package:yoyaku/pages/update_page.dart';
import 'package:flutter/material.dart';

class ItemGridCard extends StatelessWidget {
  final ItemData data;
  const ItemGridCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => UpdatePage(uuid: data.uuid)),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.orange,
                Colors.orangeAccent,
                Colors.red,
                Colors.redAccent
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 0.2, 0.5, 0.8],
            ),
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CoverImage(size: size, data: data),
                Text(
                  data.title,
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    data.releaseDate,
                    style: TextStyle(
                      fontSize: size.width * 0.035,
                    ),
                  ),
                ),
                Text(
                  data.totalPrice,
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TypeTag(data.type),
              ],
            ),
          ),
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
          width: size.width * 0.45,
          height: size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
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
