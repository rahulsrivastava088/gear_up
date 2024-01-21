// To parse this JSON data, do
//
//     final playersList = playersListFromJson(jsonString);

import 'dart:convert';

PlayersList playersListFromJson(String str) =>
    PlayersList.fromJson(json.decode(str));

String playersListToJson(PlayersList data) => json.encode(data.toJson());

class PlayersList {
  String? status;
  List<PlayersWithConnection>? playersWithConnections;

  PlayersList({
    this.status,
    this.playersWithConnections,
  });

  factory PlayersList.fromJson(Map<String, dynamic> json) => PlayersList(
        status: json["status"],
        playersWithConnections: json["playersWithConnections"] == null
            ? []
            : List<PlayersWithConnection>.from(json["playersWithConnections"]!
                .map((x) => PlayersWithConnection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "playersWithConnections": playersWithConnections == null
            ? []
            : List<dynamic>.from(
                playersWithConnections!.map((x) => x.toJson())),
      };
}

class PlayersWithConnection {
  Address? currentAddress;
  SocialMedia? socialMedia;
  String? bio;
  String? profession;
  int? bucks;
  String? id;
  int? mobileNumber;
  List<FavoriteSport>? favoriteSports;
  String? country;
  bool? newUser;
  String? referralCode;
  List<Token>? tokens;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<Address>? addresses;
  String? firstName;
  String? lastName;
  String? gender;
  String? img;
  int? birthday;
  List<dynamic>? connections;
  double? distance;
  int? age;
  dynamic rating;
  ConnectionData? connectionData;
  String? objective;
  String? playTime;

  PlayersWithConnection({
    this.currentAddress,
    this.socialMedia,
    this.bio,
    this.profession,
    this.bucks,
    this.id,
    this.mobileNumber,
    this.favoriteSports,
    this.country,
    this.newUser,
    this.referralCode,
    this.tokens,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.addresses,
    this.firstName,
    this.lastName,
    this.gender,
    this.img,
    this.birthday,
    this.connections,
    this.distance,
    this.age,
    this.rating,
    this.connectionData,
    this.objective,
    this.playTime,
  });

  factory PlayersWithConnection.fromJson(Map<String, dynamic> json) =>
      PlayersWithConnection(
        currentAddress: json["current_address"] == null
            ? null
            : Address.fromJson(json["current_address"]),
        socialMedia: json["social_media"] == null
            ? null
            : SocialMedia.fromJson(json["social_media"]),
        bio: json["bio"],
        profession: json["profession"],
        bucks: json["bucks"],
        id: json["_id"],
        mobileNumber: json["mobileNumber"],
        favoriteSports: json["favorite_sports"] == null
            ? []
            : List<FavoriteSport>.from(
                json["favorite_sports"]!.map((x) => FavoriteSport.fromJson(x))),
        country: json["country"],
        newUser: json["new_user"],
        referralCode: json["referral_code"],
        tokens: json["tokens"] == null
            ? []
            : List<Token>.from(json["tokens"]!.map((x) => Token.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        img: json["img"],
        birthday: json["birthday"],
        connections: json["connections"] == null
            ? []
            : List<dynamic>.from(json["connections"]!.map((x) => x)),
        distance: json["distance"]?.toDouble(),
        age: json["age"],
        rating: json["rating"],
        connectionData: json["connection_data"] == null
            ? null
            : ConnectionData.fromJson(json["connection_data"]),
        objective: json["objective"],
        playTime: json["play_time"],
      );

  Map<String, dynamic> toJson() => {
        "current_address": currentAddress?.toJson(),
        "social_media": socialMedia?.toJson(),
        "bio": bio,
        "profession": profession,
        "bucks": bucks,
        "_id": id,
        "mobileNumber": mobileNumber,
        "favorite_sports": favoriteSports == null
            ? []
            : List<dynamic>.from(favoriteSports!.map((x) => x.toJson())),
        "country": country,
        "new_user": newUser,
        "referral_code": referralCode,
        "tokens": tokens == null
            ? []
            : List<dynamic>.from(tokens!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "img": img,
        "birthday": birthday,
        "connections": connections == null
            ? []
            : List<dynamic>.from(connections!.map((x) => x)),
        "distance": distance,
        "age": age,
        "rating": rating,
        "connection_data": connectionData?.toJson(),
        "objective": objective,
        "play_time": playTime,
      };
}

class Address {
  String? name;
  String? lat;
  String? lng;
  String? line1;
  String? line2;
  String? line3;
  String? line4;
  String? id;

  Address({
    this.name,
    this.lat,
    this.lng,
    this.line1,
    this.line2,
    this.line3,
    this.line4,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"],
        lat: json["lat"],
        lng: json["lng"],
        line1: json["line1"],
        line2: json["line2"],
        line3: json["line3"],
        line4: json["line4"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lng": lng,
        "line1": line1,
        "line2": line2,
        "line3": line3,
        "line4": line4,
        "_id": id,
      };
}

class ConnectionData {
  bool? connection;
  dynamic connectionStatus;
  dynamic isSender;

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

class SocialMedia {
  dynamic instagram;
  dynamic facebook;
  dynamic linkedin;
  dynamic youtube;

  SocialMedia({
    this.instagram,
    this.facebook,
    this.linkedin,
    this.youtube,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        instagram: json["instagram"],
        facebook: json["facebook"],
        linkedin: json["linkedin"],
        youtube: json["youtube"],
      );

  Map<String, dynamic> toJson() => {
        "instagram": instagram,
        "facebook": facebook,
        "linkedin": linkedin,
        "youtube": youtube,
      };
}

class Token {
  String? token;
  String? id;

  Token({
    this.token,
    this.id,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "_id": id,
      };
}
