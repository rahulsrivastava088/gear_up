import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar onBoardingAppBar(BuildContext context, {Function? onTap}) {
  return AppBar(
    titleSpacing: 24.0,
    backgroundColor: Colors.transparent,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: IconButton(
        onPressed: () {
          if (onTap == null) {
            if (context.canPop()) {
              context.pop();
            }
          } else {
            onTap();
          }
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 32,
        ),
      ),
    ),
  );
}
