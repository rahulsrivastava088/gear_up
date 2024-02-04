import 'package:gear_up/utils/strings.dart';
import 'package:intl/intl.dart';

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
      return "659ae820fc7fd9bad6fe0dc9";
    case 1:
      return "659ae8d6f919dd254d788b26";
    case 2:
      return "659ae8ddf919dd254d788b29";
    case 3:
      return "659ae8fff919dd254d788b2c";
    case 4:
      return "659ae904f919dd254d788b2f";
  }
  return "";
}

int getSportIndex(String? id) {
  switch (id) {
    case "659ae820fc7fd9bad6fe0dc9":
      return 0;
    case "659ae8d6f919dd254d788b26":
      return 1;
    case "659ae8ddf919dd254d788b29":
      return 2;
    case "659ae8fff919dd254d788b2c":
      return 3;
    case "659ae904f919dd254d788b2f":
      return 4;
  }
  return 0;
}

String getSportName(String? id) {
  switch (id) {
    case "659ae820fc7fd9bad6fe0dc9":
      return Strings.sportsList[0];
    case "659ae8d6f919dd254d788b26":
      return Strings.sportsList[1];
    case "659ae8ddf919dd254d788b29":
      return Strings.sportsList[2];
    case "659ae8fff919dd254d788b2c":
      return Strings.sportsList[3];
    case "659ae904f919dd254d788b2f":
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
