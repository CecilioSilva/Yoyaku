import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final void Function()? onPressed;
  final Object? error;
  const CustomError({Key? key, this.onPressed, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/error.png',
          width: size.width * 0.1,
          height: size.width * 0.1,
        ),
        Text(
          'Error loading items',
          style: TextStyle(
            color: Colors.red,
            fontSize: size.width * 0.04,
          ),
        ),
      ],
    );
  }
}
