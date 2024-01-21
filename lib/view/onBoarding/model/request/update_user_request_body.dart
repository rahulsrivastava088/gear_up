// To parse this JSON data, do
//
//     final updateUserBody = updateUserBodyFromJson(jsonString);

import 'dart:convert';

UpdateUserBody updateUserBodyFromJson(String str) =>
    UpdateUserBody.fromJson(json.decode(str));

String updateUserBodyToJson(UpdateUserBody data) => json.encode(data.toJson());

class UpdateUserBody {
  List<FavoriteSport>? favoriteSports;
  String? objective;
  String? playTime;
  String? firstName;
  String? lastName;
  int? birthday;
  String? gender;
  List<Address>? addresses;
  dynamic bio;
  String? profession;
  Address? currentAddress;
  String? img;

  UpdateUserBody({
    this.favoriteSports,
    this.objective,
    this.playTime,
    this.firstName,
    this.lastName,
    this.birthday,
    this.gender,
    this.addresses,
    this.bio,
    this.profession,
    this.currentAddress,
    this.img,
  });

  factory UpdateUserBody.fromJson(Map<String, dynamic> json) => UpdateUserBody(
        favoriteSports: json["favorite_sports"] == null
            ? []
            : List<FavoriteSport>.from(
                json["favorite_sports"]!.map((x) => FavoriteSport.fromJson(x))),
        objective: json["objective"],
        playTime: json["play_time"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        birthday: json["birthday"],
        gender: json["gender"],
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
        bio: json["bio"],
        profession: json["profession"],
        currentAddress: json["current_address"] == null
            ? null
            : Address.fromJson(json["current_address"]),
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "favorite_sports": favoriteSports == null
            ? []
            : List<dynamic>.from(favoriteSports!.map((x) => x.toJson())),
        "objective": objective,
        "play_time": playTime,
        "first_name": firstName,
        "last_name": lastName,
        "birthday": birthday,
        "gender": gender,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "bio": bio,
        "profession": profession,
        "current_address": currentAddress?.toJson(),
        "img": img,
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

  Address({
    this.name,
    this.lat,
    this.lng,
    this.line1,
    this.line2,
    this.line3,
    this.line4,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"],
        lat: json["lat"],
        lng: json["lng"],
        line1: json["line1"],
        line2: json["line2"],
        line3: json["line3"],
        line4: json["line4"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lng": lng,
        "line1": line1,
        "line2": line2,
        "line3": line3,
        "line4": line4,
      };
}

class FavoriteSport {
  String? sport;
  String? level;

  FavoriteSport({
    this.sport,
    this.level,
  });

  factory FavoriteSport.fromJson(Map<String, dynamic> json) => FavoriteSport(
        sport: json["sport"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "sport": sport,
        "level": level,
      };
}
