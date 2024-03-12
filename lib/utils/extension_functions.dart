import 'package:gear_up/utils/strings.dart';
import 'package:intl/intl.dart';

import '../view/partners/ui/filter_bottom_sheet.dart';

extension StringExtension on String {
  bool isSuccess() {
    if (this == 'Successful' || this == 'Success') {
      return true;
    } else {
      return false;
    }
  }
}

extension ParseDoubleExtension on String? {
  double? toDouble() {
    try {
      return this != null ? double.parse(this!) : null;
    } catch (e) {
      return null;
    }
  }
}

String getSportID(int index) {
  switch (index) {
    case 0:
      return "65c7bfc60dc5aa5209a49a90";
    case 1:
      return "65c7bfbe0dc5aa5209a49a8d";
    case 2:
      return "65c7bfb90dc5aa5209a49a8a";
    case 3:
      return "65c7bfb30dc5aa5209a49a87";
    case 4:
      return "65c7bfa20dc5aa5209a49a84";
  }
  return "";
}

String getSportIDFromSports(Sports sport) {
  switch (sport) {
    case Sports.badminton:
      return "65c7bfc60dc5aa5209a49a90";
    case Sports.tableTennis:
      return "65c7bfbe0dc5aa5209a49a8d";
    case Sports.pool:
      return "65c7bfb90dc5aa5209a49a8a";
    case Sports.lawnTennis:
      return "65c7bfb30dc5aa5209a49a87";
    case Sports.squash:
      return "65c7bfa20dc5aa5209a49a84";
  }
}

String getLevelName(Level level) {
  switch (level) {
    case Level.beginner:
      return Strings.levelsList[0];
    case Level.intermediate:
      return Strings.levelsList[1];
    case Level.advance:
      return Strings.levelsList[2];
    case Level.professional:
      return Strings.levelsList[3];
    case Level.coachTrainer:
      return Strings.levelsList[4];
  }
}

Level getLevelEnum(int index) {
  switch (index) {
    case 0:
      return Level.beginner;
    case 1:
      return Level.intermediate;
    case 2:
      return Level.advance;
    case 3:
      return Level.professional;
    case 4:
      return Level.coachTrainer;
  }
  return Level.beginner;
}

int getSportIndex(String? id) {
  switch (id) {
    case "65c7bfc60dc5aa5209a49a90":
      return 0;
    case "65c7bfbe0dc5aa5209a49a8d":
      return 1;
    case "65c7bfb90dc5aa5209a49a8a":
      return 2;
    case "65c7bfb30dc5aa5209a49a87":
      return 3;
    case "65c7bfa20dc5aa5209a49a84":
      return 4;
  }
  return 0;
}

String getSportName(String? id) {
  switch (id) {
    case "65c7bfc60dc5aa5209a49a90":
      return Strings.sportsList[0];
    case "65c7bfbe0dc5aa5209a49a8d":
      return Strings.sportsList[1];
    case "65c7bfb90dc5aa5209a49a8a":
      return Strings.sportsList[2];
    case "65c7bfb30dc5aa5209a49a87":
      return Strings.sportsList[3];
    case "65c7bfa20dc5aa5209a49a84":
      return Strings.sportsList[4];
  }
  return "";
}

convertDate(int? timestamp) {
  if (timestamp == null) return "";
  var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
  String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
  return formattedDate;
}

convertTime(int? timestamp) {
  if (timestamp == null) return "";
  var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
  String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
  return formattedDate;
}

String calculateAge(int? timestamp) {
  if (timestamp == null) return "-";
  var birthDate = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
  final now = DateTime.now();
  int age = now.year - birthDate.year;

  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }
  return age.toString();
}
