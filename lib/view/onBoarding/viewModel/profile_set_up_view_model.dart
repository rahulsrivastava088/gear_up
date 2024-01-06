import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SportsData {
  int? nameIndex;
  int? levelIndex;
}

class ProfileSetUpViewModel extends BaseViewModel {
  List<int> selectedSports = [];
  List<int> selectedLevel = [];
  int selectedGender = -1;
  int selectedObjective = -1;
  int selectedPlayTime = -1;
  String firstName = '';
  String lastName = '';
  String dob = '';

  void markSportAsSelected(int index) {
    if (!selectedSports.contains(index)) {
      selectedSports.add(index);
    }
    updatedSelectedLevelList();
  }

  void markSportAsUnselected(int index) {
    selectedSports.remove(index);
    updatedSelectedLevelList();
  }

  void updatedSelectedLevelList() {
    selectedLevel.clear();
    for (final _ in selectedSports) {
      selectedLevel.add(-1);
    }
  }

  bool isLevelListValid() {
    for (final index in selectedLevel) {
      if (index == -1) {
        return false;
      }
    }
    return true;
  }

  bool isValidDate(String input) {
    try {
      List<String> parts = input.split('/');
      if (parts.length != 3) {
        return false;
      }
      String formattedDate = "${parts[2]}-${parts[1]}-${parts[0]}";
      DateFormat format = DateFormat("yyyy-MM-dd");
      format.parseStrict(formattedDate);
      return true;
    } catch (e) {
      return false;
    }
  }
}
