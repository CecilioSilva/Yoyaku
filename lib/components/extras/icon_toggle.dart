import 'package:flutter/material.dart';

class IconToggle extends StatelessWidget {
  final bool value;
  final Function(bool) onPressed;
  final IconData trueIcon;
  final Color trueColor;
  final IconData falseIcon;
  final Color falseColor;

  const IconToggle({
    Key? key,
    required this.value,
    required this.onPressed,
    required this.trueIcon,
    required this.falseIcon,
    this.trueColor = Colors.white,
    this.falseColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(!value),
      icon: Icon(
        value ? trueIcon : falseIcon,
        color: value ? trueColor : falseColor,
      ),
    );
  }
}
