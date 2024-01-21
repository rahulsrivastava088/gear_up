import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:go_router/go_router.dart';

AppBar editUserProfileAppBar(BuildContext context) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    centerTitle: false,
    toolbarHeight: 68,
    backgroundColor: cardBgColor,
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.check,
          color: Color(0xFF0095F6),
          size: 24,
        ),
      ),
      const SizedBox(width: 8)
    ],
    title: Row(
      children: [
        InkWell(
          onTap: () {
            if (context.canPop()) context.pop();
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 32,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'General Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
