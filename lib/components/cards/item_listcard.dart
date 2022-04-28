import 'package:provider/provider.dart';
import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/components/extras/type_tag.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:yoyaku/pages/item_page.dart';
import 'package:yoyaku/pages/update_page.dart';
import 'package:flutter/material.dart';

class ItemListCard extends StatelessWidget {
  final ItemData data;
  const ItemListCard(this.data, {Key? key}) : super(key: key);

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
                stops: [0, 0.2, 0.5, 0.8]),
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: SizedBox(
            width: size.width,
            child: Row(
              children: [
                CoverImage(size: size, data: data),
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TypeTag(data.type),
                          Text(
                            data.totalPrice,
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.6,
                            child: Row(
                              children: [
                                Visibility(
                                  visible: !data.canceled,
                                  child: checkbox(
                                    Icons.paid,
                                    data.paid,
                                    size,
                                  ),
                                ),
                                Visibility(
                                  visible: data.canceled,
                                  child: checkbox(
                                    Icons.cancel_outlined,
                                    data.canceled,
                                    size,
                                  ),
                                ),
                                checkbox(
                                  Icons.directions_boat,
                                  data.import,
                                  size,
                                ),
                                checkbox(
                                  Icons.local_shipping,
                                  data.delivered,
                                  size,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget checkbox(IconData icon, bool value, Size size) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        Checkbox(
          value: value,
          onChanged: (value) => {},
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.all(const Color(0xFF03071e)),
        ),
      ],
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
      padding: const EdgeInsets.only(
        left: 4,
        top: 4,
        bottom: 4,
        right: 8,
      ),
      child: Hero(
        tag: data.title,
        child: Container(
          width: size.width * 0.3,
          height: size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: MemoryImage(data.image),
            ),
          ),
        ),
      ),
    );
  }
}
