import 'package:flutter/material.dart';

LinearGradient getCardGradient(bool canceled) {
  const List<Color> normalColors = [
    Colors.orange,
    Colors.orangeAccent,
    Colors.red,
    Colors.redAccent
  ];

  const List<Color> canceledColors = [
    Colors.purple,
    Colors.purpleAccent,
    Colors.pink,
    Colors.pinkAccent,
  ];

  return LinearGradient(
    colors: canceled ? canceledColors : normalColors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0, 0.2, 0.5, 0.8],
  );
}
