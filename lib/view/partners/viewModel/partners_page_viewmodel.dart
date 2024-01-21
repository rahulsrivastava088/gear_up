import 'package:flutter/cupertino.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:stacked/stacked.dart';
import '../../../data/response/api_response.dart';
import '../../../utils/utilities.dart';
import '../../home/model/response/players_list_response.dart';
import '../../home/repo/home_page_repo.dart';

class PartnersPageViewModel extends BaseViewModel {
  final _repo = HomePageRepository();
  bool apiCalled = false;

  String? selectedSport;
  int? range;
  int? minAge;
  int? maxAge;
  String? gender;

  List<PlayersWithConnection> _playersList = [];

  ApiResponse<PlayersList> playersListResponse = ApiResponse.idle();

  fetchAllPlayers(BuildContext context) async {
    playersListResponse = ApiResponse.loading();
    _repo
        .fetchAllPlayers()
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                playersListResponse = ApiResponse.completed(value),
                apiCalled = true
              }
            else
              {
                playersListResponse = ApiResponse.error(""),
                showSnackBar(context, "There is some issue at our end"),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            playersListResponse = ApiResponse.error(""),
            showSnackBar(context, "There is some issue at our end, please ret"),
            notifyListeners()
          },
        );
  }

  List<PlayersWithConnection> getPlayersList() {
    _playersList = playersListResponse.data?.playersWithConnections ?? [];
    applyFilters();
    return _playersList;
  }

  applyFilters() {}
}
