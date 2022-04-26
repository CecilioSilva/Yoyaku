import 'package:flutter/material.dart';

class TypeTag extends StatelessWidget {
  final String tag;
  const TypeTag(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Color tagColor = Colors.green;

    switch (tag) {
      case 'Figure':
        tagColor = const Color(0xFF06d6a0);
        break;
      case 'Manga':
        tagColor = const Color(0xFFef476f);
        break;
      case 'Game':
        tagColor = const Color(0xFF118ab2);
        break;
      case 'Other':
        tagColor = const Color(0xFF073b4c);
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: tagColor,
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            tag,
            maxLines: 1,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: size.width * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
