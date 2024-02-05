import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/myChats/repo/chat_repository.dart';
import 'package:gear_up/view/myGames/gameCard/model/response/games_list_response.dart';
import 'package:stacked/stacked.dart';
import '../../../onBoarding/loginUi/commonUI/custom_snackbar.dart';

class GameDetailsViewModel extends BaseViewModel {
  final _repo = ChatRepository();

  Future<Game> updateGameStats(BuildContext context, String? gameID,
      int matchesPlayed, int matchesWon, String? winnerID) async {
    if (gameID == null) {
      return Future.error("null");
    }
    var matchesWonByPlayer2 = matchesPlayed - matchesWon;
    Map<String, dynamic> requestBody = {
      "scorecard": {
        "matchesWonByPlayer1": matchesWon,
        "matchesWonByPlayer2": matchesWonByPlayer2,
        "winner": winnerID
      }
    };

    Future<Game> res = Future.error("null");
    await _repo
        .updateGame(requestBody, gameID)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                res = Future.value(Game()),
              }
            else
              {
                customSnackBar(context, "Couldn't update the game stats"),
              },
          },
        )
        .onError(
          (error, stackTrace) => {
            customSnackBar(context, "Couldn't update the game stats"),
          },
        );
    return res;
  }

  Future<Game> updateFeedBack(
    BuildContext context,
    String? gameID,
    bool? isHost,
    int rateSkills,
    int punctuality,
    int sportsmanship,
    int teamPlayer,
    int competitiveness,
    int respectful,
    String reviewMessage,
  ) async {
    if (gameID == null || isHost == null) {
      return Future.error("null");
    }
    Map<String, dynamic> requestBody = {
      isHost == true ? "player1Feedback" : "player2Feedback": {
        "rate_skills": rateSkills,
        "punctuality": punctuality,
        "sportsmanship": sportsmanship,
        "teamPlayer": teamPlayer,
        "competitiveness": competitiveness,
        "respectful": respectful,
        "reviewMessage": null,
      }
    };

    Future<Game> res = Future.error(false);
    await _repo
        .updateGame(requestBody, gameID)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                res = Future.value(Game()),
              }
            else
              {
                customSnackBar(context, "Couldn't share feedback"),
              },
          },
        )
        .onError(
          (error, stackTrace) => {
            customSnackBar(context, "Couldn't share feedback"),
          },
        );
    return res;
  }
}
