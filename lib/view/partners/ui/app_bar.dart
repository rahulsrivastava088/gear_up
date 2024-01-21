import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';

AppBar partnersAppBar(BuildContext context) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    centerTitle: false,
    toolbarHeight: 68,
    backgroundColor: cardBgColor,
    automaticallyImplyLeading: false,
    title: const Row(
      children: [
        SizedBox(width: 8),
        Text(
          'Partners Near You',
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
