import 'package:flutter/cupertino.dart';
import 'package:gear_up/data/response/status.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/myGames/gameCard/model/response/games_list_response.dart';
import 'package:gear_up/view/myGames/gameCard/repo/game_card_repo.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/response/api_response.dart';

class GameCardViewModel extends BaseViewModel {
  // String opponentName = "Ayush Agarwal";
  // String sport = "Badminton";
  // String date = "Wed, 10th Jan";
  // String time = "8:00 PM (IST)";
  // String venue = "Bangalore";
  // int gameWinner = -1;
  // int matchesPlayed = -1;
  // int matchesWon = -1;
  // Feedback host = Feedback();
  // Feedback opponent = Feedback();
  // int
  int index = 1;

  // String? selectedSportId = null;
  final _repo = GamesRepository();
  bool apiCalled = false;
  var game = Game();

  ApiResponse<GamesList> gamesListResponse = ApiResponse.idle();

  updateGame() {
    game = gamesListResponse.data?.games?[index] ?? Game();
    print(game);
    // notifyListeners();
  }

  fetchMyGames(BuildContext context) async {
    gamesListResponse = ApiResponse.loading();
    _repo
        .fetchMyGames()
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                print("response: " + value.toString()),
                updateGame(),
                gamesListResponse = ApiResponse.completed(value),
                apiCalled = true,
              }
            else
              {
                gamesListResponse = ApiResponse.error(""),
                apiCalled = true,
                // showSnackBar(context, "There is some issue at our end"),
              },
            // updateGame(),
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            gamesListResponse = ApiResponse.error(""),
            apiCalled = true,
            print(stackTrace),
            // showSnackBar(context, "There is some issue at our end, please ret"),
            notifyListeners()
          },
        );
  }

  bool isHost() {
    return true;
  }

  List<Game> recentGames() {
    var recentGames = List<Game>.empty(growable: true);
    if (gamesListResponse.status == Status.COMPLETED) {
      for (final game in gamesListResponse.data?.games ?? List<Game>.empty()) {
        if (game.status == "Recent") {
          recentGames.add(game);
        }
      }
    }
    return recentGames;
  }

  List<Game> upcomingGames() {
    var upcomingGames = List<Game>.empty(growable: true);
    if (gamesListResponse.status == Status.COMPLETED) {
      for (final game in gamesListResponse.data?.games ?? List<Game>.empty()) {
        if (game.status == "Upcoming") {
          upcomingGames.add(game);
        }
      }
    }
    return upcomingGames;
  }

  List<Game> liveGames() {
    var liveGames = List<Game>.empty(growable: true);
    if (gamesListResponse.status == Status.COMPLETED) {
      for (final game in gamesListResponse.data?.games ?? List<Game>.empty()) {
        if (game.status == "Live") {
          liveGames.add(game);
        }
      }
    }
    return liveGames;
  }
}

class Feedback {
  int rateSKills = -1;
  int punctuality = -1;
  int sportsmanship = -1;
  int teamPlayer = -1;
  int competitiveness = -1;
  int respectful = -1;
  String review = '';
}
