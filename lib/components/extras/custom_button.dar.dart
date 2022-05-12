import 'package:flutter/material.dart';

class YoyakuButton extends StatelessWidget {
  const YoyakuButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.color = Colors.red,
  }) : super(key: key);

  final void Function()? onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        right: 4,
        top: 4,
        bottom: 30.0,
      ),
      child: SizedBox(
        width: size.width,
        height: size.width * 0.15,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
