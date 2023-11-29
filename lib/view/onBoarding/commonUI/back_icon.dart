import 'package:flutter/material.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // width: 32,
      // height: 32,
      // child: FittedBox(
      onPressed: () {
        // print('Back Button is Pressed');
      },
      icon: const Icon(Icons.arrow_back),
      // ),
    );
  }
}
