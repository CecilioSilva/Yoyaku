import 'package:provider/provider.dart';
import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:yoyaku/pages/item_page.dart';
import 'package:yoyaku/pages/update_page.dart';
import 'package:flutter/material.dart';

class ItemGridMinimalCard extends StatelessWidget {
  final ItemData data;
  const ItemGridMinimalCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => ItemPage(data: data)),
            ),
          );
        },
        onLongPress: () async {
          Item item =
              await Provider.of<DataSync>(context, listen: false).getItemById(
            data.uuid,
          );

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => UpdatePage(item: item)),
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
                FittedBox(
                  child: SizedBox(
                    width: size.width,
                    child: Text(
                      data.title,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
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
          height: size.width * 0.45,
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
