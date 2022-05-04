import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

SpeedDialChild customSpeedDialChild(
  BuildContext context,
  Color color,
  IconData icon,
  String label,
  Widget page,
) {
  return SpeedDialChild(
    backgroundColor: color,
    child: Icon(
      icon,
      color: Colors.white,
    ),
    labelBackgroundColor: color,
    label: label,
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontSize: 16.0,
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    },
  );
}
