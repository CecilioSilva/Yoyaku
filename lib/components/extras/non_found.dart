import 'package:flutter/material.dart';

class NonFound extends StatelessWidget {
  final void Function()? onPressed;
  const NonFound({Key? key, this.onPressed}) : super(key: key);

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
        Text(
          'No items found',
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.04,
          ),
        ),
      ],
    );
  }
}
