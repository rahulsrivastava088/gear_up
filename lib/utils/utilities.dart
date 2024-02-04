import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gear_up/view/home/model/response/players_list_response.dart';
import 'package:gear_up/view/partners/ui/filter_bottom_sheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../view/onBoarding/loginUi/commonUI/custom_snackbar.dart';
import 'package:http/http.dart' as http;

showSnackBar(BuildContext context, String text) {
  customSnackBar(context, text);
}

Future<void> hitSocialMediaLink(String url) async {
  try {
    await canLaunch(url) ? await launch(url) : '';
    // ignore: empty_catches
  } catch (e) {}
}

Center circularImage(String? userImage) {
  return Center(
    child: ClipOval(
      child: SizedBox.fromSize(
        size: const Size.fromRadius(80), // Image radius
        // child: Container(
        // color: Colors.grey,
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/person_image.png',
          image: userImage ?? '',
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "assets/images/person_image.png",
              width: 100,
              height: 100,
            );
          },
        ),
      ),
    ),
    // ),
  );
}

uiText(String? text) {
  if (text == null || text.isEmpty) {
    return "NA";
  } else {
    return text;
  }
}

getSportIconData(String? sportID) {
  switch (sportID) {
    case "659ae820fc7fd9bad6fe0dc9":
      return "assets/sport_icons/ic_badminton.svg";
    case "659ae8d6f919dd254d788b26":
      return "assets/sport_icons/ic_table_tennis.svg";
    case "659ae8ddf919dd254d788b29":
      return "assets/sport_icons/ic_pool.svg";
    case "659ae8fff919dd254d788b2c":
      return "assets/sport_icons/ic_lawn_tennis.svg";
    case "659ae904f919dd254d788b2f":
      return "assets/sport_icons/ic_squash.svg";
  }
  return "";
}

String getSportIconDataFromSportName(Sports sport) {
  switch (sport) {
    case Sports.badminton:
      return "assets/sport_icons/ic_badminton.svg";
    case Sports.tableTennis:
      return "assets/sport_icons/ic_table_tennis.svg";
    case Sports.pool:
      return "assets/sport_icons/ic_pool.svg";
    case Sports.lawnTennis:
      return "assets/sport_icons/ic_lawn_tennis.svg";
    case Sports.squash:
      return "assets/sport_icons/ic_squash.svg";
  }
}

String getConnectionUiText(ConnectionData? data) {
  if (data == null) {
    return 'Connect';
  }
  if (data.connection == false) {
    return "Connect";
  } else if (data.connection == true) {
    return data.connectionStatus ?? 'Connect';
  }
  return "Connect";
}

Future<Position> getCurrentLocation(BuildContext context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Location Services are disabled");
  }
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location permissions are denied");
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        "Location permissions are denied forever, we cannot request it");
  }

  return await Geolocator.getCurrentPosition();
}

Future<String> getAddressFromLatLng(context, double? lat, double? lng) async {
  if (lat == null || lng == null) {
    return Future.error("null");
  }
  String host = 'https://maps.google.com/maps/api/geocode/json';
  final url =
      '$host?key=AIzaSyAMoZuA1fXx58e5qiqebq0DYIGp3Jhbysk&language=en&latlng=$lat,$lng';

  // if (lng != null) {
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map data = jsonDecode(response.body);
    // Logger().d("address: $data");
    String _formattedAddress = data["results"][0]["formatted_address"];
    // print("response ==== $_formattedAddress");
    return _formattedAddress;
  } else {
    return Future.error("null");
  }
  // } else {
  //   return Future.error("null");
  // }
}

const defaultLocation = LatLng(20.5937, 78.9629);

String formatEpochToDate(int? epoch) {
  if (epoch == null) {
    return '-';
  }
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch);
  DateTime now = DateTime.now();

  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    return 'Today';
  } else if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day - 1) {
    return 'Yesterday';
  } else {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}

String formatEpochToTime(int? epoch) {
  if (epoch == null) {
    return '-';
  }
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch);
  return DateFormat('h:mm a').format(dateTime);
}
