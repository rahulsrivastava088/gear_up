import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:go_router/go_router.dart';
import '../model/response/games_list_response.dart';

AppBar gameCardAppBar(BuildContext context, Game game) {
  return AppBar(
    titleSpacing: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: IconButton(
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          }
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 32,
        ),
      ),
    ),
    scrolledUnderElevation: 0.0,
    centerTitle: false,
    toolbarHeight: 68,
    backgroundColor: cardBgColor,
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        const SizedBox(width: 8),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'You',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextSpan(
                text: ' vs ',
                style: TextStyle(
                  color: Color(0xFFAFAFAF),
                  fontSize: 24,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: game.player2?.name ?? 'Opponent Name',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
