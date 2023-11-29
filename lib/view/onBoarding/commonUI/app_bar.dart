import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar onBoardingAppBar(BuildContext context) {
  return AppBar(
    titleSpacing: 24.0,
    backgroundColor: Colors.transparent,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 32,
        ),
      ),
    ),
  );
}
