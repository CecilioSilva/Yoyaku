import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        width: size.width * 0.15,
        height: size.width * 0.15,
        child: const CircleAvatar(
          backgroundImage: AssetImage(
            'assets/loading.gif',
          ),
        ),
      ),
    );
  }
}
