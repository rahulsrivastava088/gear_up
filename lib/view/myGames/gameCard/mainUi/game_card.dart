import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/custom_navigator.dart';
import 'package:gear_up/view/myGames/gameCard/model/response/games_list_response.dart';
import '../../../../utils/extension_functions.dart';
import '../../../../utils/strings.dart';

class GameCard extends StatefulWidget {
  final Game game;
  const GameCard({super.key, required this.game});
  @override
  State<GameCard> createState() => _GameCard();
}

class _GameCard extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<GameCardViewModel>(context);
    return GestureDetector(
      onTap: () {
        CustomNavigationHelper.router.push(
          CustomNavigationHelper.gameDetailPath,
          extra: widget.game,
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 16),
            decoration: ShapeDecoration(
              color: const Color(0xFF141414),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                youText(),
                opponentNameText(),
                const SizedBox(height: 16),
                Row(
                  children: [textWidget(), const Spacer(), sportNameWidget()],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text upcomingTextWidget() {
    return Text(
      (convertDate(widget.game.matchDate ?? 0)).toString(),
      style: const TextStyle(
        color: Color(0xFFAFAFAF),
        fontSize: 12,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  IntrinsicHeight recentTextWidget() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text(
            getUiTextForRecentGames(widget.game),
            style: const TextStyle(
              color: Color(0xFF0095F6),
              fontSize: 12,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 6),
          const VerticalDivider(
            color: Color(0xFF333333),
            thickness: 1,
          ),
          const SizedBox(width: 6),
          Text(
            (convertDate(widget.game.matchDate ?? 0)).toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String getUiTextForRecentGames(Game game) {
    if (game.checkedIn?.player1 == true && game.checkedIn?.player1 == true) {
      if (game.scorecard?.updated == true) {
        switch (game.scorecard?.winner) {
          case myUserID:
            return "Won";
          case null:
            return "Draw";
          default:
            return "Lost";
        }
      } else if (game.scorecard?.updated == false) {
        if (game.player1?.id == myUserID) {
          return "Update results";
        } else {
          return "Results Pending";
        }
      }
    } else {
      return "Match cancelled";
    }
    return "-";
  }

  Widget textWidget() {
    if (widget.game.status == "Live") {
      return liveTextWidget();
    } else if (widget.game.status == "Recent") {
      return recentTextWidget();
    } else if (widget.game.status == "Upcoming") {
      return upcomingTextWidget();
    }
    return Container();
  }

  Row liveTextWidget() {
    return const Row(
      children: [
        Text(
          '• Live',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Text opponentNameText() {
    return Text(
      widget.game.player2?.name ?? "",
      style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'General Sans',
          fontWeight: FontWeight.w600),
    );
  }

  Text youText() {
    return const Text(
      'You/',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Container sportNameWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: ShapeDecoration(
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        getSportName(widget.game.sport?.id),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
