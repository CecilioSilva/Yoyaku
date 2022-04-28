import 'package:flutter/material.dart';

class Waiting extends StatelessWidget {
  final void Function()? onPressed;
  const Waiting({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/waiting.png',
          width: size.width * 0.1,
          height: size.width * 0.1,
        ),
        const Text('No items found'),
      ],
    );
  }
}
