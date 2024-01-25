// To parse this JSON data, do
//
//     final playersListRequestBody = playersListRequestBodyFromJson(jsonString);

import 'dart:convert';

PlayersListRequestBody playersListRequestBodyFromJson(String str) =>
    PlayersListRequestBody.fromJson(json.decode(str));

String playersListRequestBodyToJson(PlayersListRequestBody data) =>
    json.encode(data.toJson());

class PlayersListRequestBody {
  String? gender;
  int? range;
  int? maxAge;
  String? favouriteSport;
  String? favouriteSportLevel;

  PlayersListRequestBody({
    this.gender,
    this.range,
    this.maxAge,
    this.favouriteSport,
    this.favouriteSportLevel,
  });

  factory PlayersListRequestBody.fromJson(Map<String, dynamic> json) =>
      PlayersListRequestBody(
        gender: json["gender"],
        range: json["range"],
        maxAge: json["max_age"],
        favouriteSport: json["favouriteSport"],
        favouriteSportLevel: json["favouriteSportLevel"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "range": range,
        "max_age": maxAge,
        "favouriteSport": favouriteSport,
        "favouriteSportLevel": favouriteSportLevel,
      };
}
