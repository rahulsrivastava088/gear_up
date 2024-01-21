// To parse this JSON data, do
//
//     final updateUser = updateUserFromJson(jsonString);

import 'dart:convert';

UpdateUser updateUserFromJson(String str) =>
    UpdateUser.fromJson(json.decode(str));

String updateUserToJson(UpdateUser data) => json.encode(data.toJson());

class UpdateUser {
  String? status;
  User? user;

  UpdateUser({
    this.status,
    this.user,
  });

  factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
        status: json["status"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user?.toJson(),
      };
}

class User {
  Address? currentAddress;
  String? id;
  int? mobileNumber;
  String? country;
  bool? newUser;
  String? referralCode;
  int? bucks;
  List<FavoriteSport>? favoriteSports;
  List<Address>? addresses;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  dynamic bio;
  int? birthday;
  String? firstName;
  String? gender;
  String? img;
  String? lastName;
  String? objective;
  String? playTime;
  String? profession;

  User({
    this.currentAddress,
    this.id,
    this.mobileNumber,
    this.country,
    this.newUser,
    this.referralCode,
    this.bucks,
    this.favoriteSports,
    this.addresses,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.bio,
    this.birthday,
    this.firstName,
    this.gender,
    this.img,
    this.lastName,
    this.objective,
    this.playTime,
    this.profession,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        currentAddress: json["current_address"] == null
            ? null
            : Address.fromJson(json["current_address"]),
        id: json["_id"],
        mobileNumber: json["mobileNumber"],
        country: json["country"],
        newUser: json["new_user"],
        referralCode: json["referral_code"],
        bucks: json["bucks"],
        favoriteSports: json["favorite_sports"] == null
            ? []
            : List<FavoriteSport>.from(
                json["favorite_sports"]!.map((x) => FavoriteSport.fromJson(x))),
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        bio: json["bio"],
        birthday: json["birthday"],
        firstName: json["first_name"],
        gender: json["gender"],
        img: json["img"],
        lastName: json["last_name"],
        objective: json["objective"],
        playTime: json["play_time"],
        profession: json["profession"],
      );

  Map<String, dynamic> toJson() => {
        "current_address": currentAddress?.toJson(),
        "_id": id,
        "mobileNumber": mobileNumber,
        "country": country,
        "new_user": newUser,
        "referral_code": referralCode,
        "bucks": bucks,
        "favorite_sports": favoriteSports == null
            ? []
            : List<dynamic>.from(favoriteSports!.map((x) => x.toJson())),
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "bio": bio,
        "birthday": birthday,
        "first_name": firstName,
        "gender": gender,
        "img": img,
        "last_name": lastName,
        "objective": objective,
        "play_time": playTime,
        "profession": profession,
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
