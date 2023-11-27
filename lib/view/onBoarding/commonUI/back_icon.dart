import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // width: 32,
      // height: 32,
      // child: FittedBox(
      onPressed: () {
        context.pop();
        print('Back Button is Pressed');
      },
      icon: Icon(Icons.arrow_back),
      // ),
    );
  }
}
