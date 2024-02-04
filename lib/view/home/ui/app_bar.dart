import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/custom_navigator.dart';

AppBar homeAppBar(BuildContext context, String location) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    centerTitle: false,
    toolbarHeight: 68,
    backgroundColor: const Color(0x00141414),
    automaticallyImplyLeading: false,
    actions: [
      InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
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
              Icon(Icons.notifications_outlined, color: Colors.white),
            ],
          ),
        ),
      ),
      const SizedBox(width: 8),
      InkWell(
        onTap: () {
          CustomNavigationHelper.router
              .push(CustomNavigationHelper.messagesPath);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
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
              Icon(Icons.chat_outlined, color: Colors.white),
            ],
          ),
        ),
      ),
    ],
    title: InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 8),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF333333)),
            borderRadius: BorderRadius.circular(80),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.location_on_outlined, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              location,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
