import 'package:gear_up/view/home/model/request/players_list_request_body.dart';
import 'package:stacked/stacked.dart';
import '../partners/ui/filter_bottom_sheet.dart';

class FilterViewModel extends BaseViewModel {
  Sports favouriteSport = Sports.badminton;
  Level favouriteSportLevel = Level.beginner;
  int range = 10;
  int minAge = 18;
  int maxAge = 24;
  Gender gender = Gender.All;

  int currentlySelectedSportIndex = -1;

  getPlayersListRequestBody() {
    PlayersListRequestBody playersListRequestBody = PlayersListRequestBody();
    // playersListRequestBody.range = range;
    // playersListRequestBody.maxAge = maxAge;
    playersListRequestBody.gender = gender.name;
    // playersListRequestBody.favouriteSport = favouriteSport;
    // playersListRequestBody.favouriteSportLevel = favouriteSportLevel;
    return playersListRequestBody;
  }
}
