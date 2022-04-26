import 'dart:typed_data';

import 'package:amiamu/classes/item_data.dart';
import 'package:amiamu/components/type_tag.dart';
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
          //TODO: Add Item Editing
          print('Editing ${data.uuid}');
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
          child: IntrinsicWidth(
            child: Row(
              children: [
                image(data.image, size),
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
                          Row(
                            children: [
                              checkbox('Paid', data.paid, size),
                              checkbox('Canceled', data.canceled, size),
                              checkbox('Import', data.import, size),
                            ],
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

  Widget checkbox(String title, bool value, Size size) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: TextStyle(fontSize: size.width * 0.030),
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

  Widget image(Uint8List image, Size size) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        top: 4,
        bottom: 4,
        right: 8,
      ),
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
    );
  }
}
