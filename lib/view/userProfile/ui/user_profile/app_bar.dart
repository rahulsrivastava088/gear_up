import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:go_router/go_router.dart';

AppBar userProfileAppBar(BuildContext context) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    centerTitle: false,
    toolbarHeight: 68,
    backgroundColor: cardBgColor,
    automaticallyImplyLeading: false,
    actions: [
      PopupMenuButton(
        onSelected: (value) {
          if (value == 1) {
            GoRouter.of(context)
                .pushNamed(RouteConstants.editUserProfilePageRouteName);
          } else if (value == 2) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Share Option coming in next release"),
            ));
          }
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        color: Colors.white,
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Icon(
                  Icons.edit_outlined,
                  color: Colors.black,
                ),
                SizedBox(width: 8),
                Text(
                  'Edit Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                Icon(
                  Icons.share_outlined,
                  color: Colors.black,
                ),
                SizedBox(width: 8),
                Text(
                  'Share',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
        child: Container(
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
          child: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ),
    ],
    title: const Text(
      'Profile',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'General Sans',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
