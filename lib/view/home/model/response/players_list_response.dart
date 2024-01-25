// To parse this JSON data, do
//
//     final playersList = playersListFromJson(jsonString);

import 'dart:convert';

PlayersList playersListFromJson(String str) =>
    PlayersList.fromJson(json.decode(str));

String playersListToJson(PlayersList data) => json.encode(data.toJson());

class PlayersList {
  String? status;
  List<Player>? players;

  PlayersList({
    this.status,
    this.players,
  });

  factory PlayersList.fromJson(Map<String, dynamic> json) => PlayersList(
        status: json["status"],
        players: json["players"] == null
            ? []
            : List<Player>.from(
                json["players"]!.map((x) => Player.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "players": players == null
            ? []
            : List<dynamic>.from(players!.map((x) => x.toJson())),
      };
}

class Player {
  String? id;
  List<FavoriteSport>? favoriteSports;
  String? gender;
  String? img;
  int? birthday;
  dynamic distance;
  int? age;
  String? name;
  dynamic rating;
  ConnectionData? connectionData;

  Player({
    this.id,
    this.favoriteSports,
    this.gender,
    this.img,
    this.birthday,
    this.distance,
    this.age,
    this.name,
    this.rating,
    this.connectionData,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["_id"],
        favoriteSports: json["favorite_sports"] == null
            ? []
            : List<FavoriteSport>.from(
                json["favorite_sports"]!.map((x) => FavoriteSport.fromJson(x))),
        gender: json["gender"],
        img: json["img"],
        birthday: json["birthday"],
        distance: json["distance"],
        age: json["age"],
        name: json["name"],
        rating: json["rating"],
        connectionData: json["connection_data"] == null
            ? null
            : ConnectionData.fromJson(json["connection_data"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "favorite_sports": favoriteSports == null
            ? []
            : List<dynamic>.from(favoriteSports!.map((x) => x.toJson())),
        "gender": gender,
        "img": img,
        "birthday": birthday,
        "distance": distance,
        "age": age,
        "name": name,
        "rating": rating,
        "connection_data": connectionData?.toJson(),
      };
}

class ConnectionData {
  bool? connection;
  String? connectionStatus;
  bool? isSender;

  ConnectionData({
    this.connection,
    this.connectionStatus,
    this.isSender,
  });

  factory ConnectionData.fromJson(Map<String, dynamic> json) => ConnectionData(
        connection: json["connection"],
        connectionStatus: json["connection_status"],
        isSender: json["isSender"],
      );

  Map<String, dynamic> toJson() => {
        "connection": connection,
        "connection_status": connectionStatus,
        "isSender": isSender,
      };
}

class FavoriteSport {
  String? sport;
  String? level;
  String? id;

  FavoriteSport({
    this.sport,
    this.level,
    this.id,
  });

  factory FavoriteSport.fromJson(Map<String, dynamic> json) => FavoriteSport(
        sport: json["sport"],
        level: json["level"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "sport": sport,
        "level": level,
        "_id": id,
      };
}
