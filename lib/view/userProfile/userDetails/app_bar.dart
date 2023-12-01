import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:go_router/go_router.dart';

AppBar userProfileAppBar(BuildContext context) {
  return AppBar(
    centerTitle: false,
    toolbarHeight: 68,
    backgroundColor: cardBgColor,
    automaticallyImplyLeading: false,
    actions: [
      Container(
        margin: const EdgeInsets.only(right: 18),
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF333333)),
            borderRadius: BorderRadius.circular(80),
          ),
        ),
        child: const Icon(Icons.more_vert),
      )
    ],
    title: InkWell(
      onTap: () {
        if (context.canPop()) context.pop();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 8),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF333333)),
            borderRadius: BorderRadius.circular(80),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.arrow_back, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Back',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
