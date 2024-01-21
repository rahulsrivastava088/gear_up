import 'package:stacked/stacked.dart';

class PoshViewModel extends BaseViewModel {
  final pageIndexes = [0, 1, 2, 3, 4];
  var selectedIndex = 0;
  final pageHeader = [
    "Introduction",
    "Types of Sexual Harassment",
    "Recognizing Sexual Harassment",
    "Reporting Mechanisms",
    "Consequences of Sexual Harassment"
  ];

  void moveToNextPage() {
    if (selectedIndex < pageIndexes.length) {
      selectedIndex++;
      notifyListeners();
    }
  }

  void moveToPreviousPage() {
    if (selectedIndex > 0) {
      selectedIndex--;
      notifyListeners();
    }
  }

  String getHeaderText() {
    return pageHeader[selectedIndex];
  }
}
