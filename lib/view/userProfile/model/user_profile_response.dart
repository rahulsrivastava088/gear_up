// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  String? status;
  User? user;

  UserProfile({
    this.status,
    this.user,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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
  SocialMedia? socialMedia;
  dynamic bio;
  dynamic profession;
  List<dynamic>? connections;
  String? id;
  int? mobileNumber;
  List<FavoriteSport>? favoriteSports;
  String? country;
  bool? newUser;
  String? referralCode;
  List<Address>? addresses;
  List<Token>? tokens;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? firstName;
  int? bucks;
  String? gender;
  String? img;
  dynamic rating;
  List<Rating>? ratings;
  List<GameStat>? gameStats;

  User({
    this.currentAddress,
    this.socialMedia,
    this.bio,
    this.profession,
    this.connections,
    this.id,
    this.mobileNumber,
    this.favoriteSports,
    this.country,
    this.newUser,
    this.referralCode,
    this.addresses,
    this.tokens,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.firstName,
    this.bucks,
    this.gender,
    this.img,
    this.rating,
    this.ratings,
    this.gameStats,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        currentAddress: json["current_address"] == null
            ? null
            : Address.fromJson(json["current_address"]),
        socialMedia: json["social_media"] == null
            ? null
            : SocialMedia.fromJson(json["social_media"]),
        bio: json["bio"],
        profession: json["profession"],
        connections: json["connections"] == null
            ? []
            : List<dynamic>.from(json["connections"]!.map((x) => x)),
        id: json["_id"],
        mobileNumber: json["mobileNumber"],
        favoriteSports: json["favorite_sports"] == null
            ? []
            : List<FavoriteSport>.from(
                json["favorite_sports"]!.map((x) => FavoriteSport.fromJson(x))),
        country: json["country"],
        newUser: json["new_user"],
        referralCode: json["referral_code"],
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
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
        firstName: json["first_name"],
        bucks: json["bucks"],
        gender: json["gender"],
        img: json["img"],
        rating: json["rating"],
        ratings: json["ratings"] == null
            ? []
            : List<Rating>.from(
                json["ratings"]!.map((x) => Rating.fromJson(x))),
        gameStats: json["game_stats"] == null
            ? []
            : List<GameStat>.from(
                json["game_stats"]!.map((x) => GameStat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_address": currentAddress?.toJson(),
        "social_media": socialMedia?.toJson(),
        "bio": bio,
        "profession": profession,
        "connections": connections == null
            ? []
            : List<dynamic>.from(connections!.map((x) => x)),
        "_id": id,
        "mobileNumber": mobileNumber,
        "favorite_sports": favoriteSports == null
            ? []
            : List<dynamic>.from(favoriteSports!.map((x) => x.toJson())),
        "country": country,
        "new_user": newUser,
        "referral_code": referralCode,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "tokens": tokens == null
            ? []
            : List<dynamic>.from(tokens!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "first_name": firstName,
        "bucks": bucks,
        "gender": gender,
        "img": img,
        "rating": rating,
        "ratings": ratings == null
            ? []
            : List<dynamic>.from(ratings!.map((x) => x.toJson())),
        "game_stats": gameStats == null
            ? []
            : List<dynamic>.from(gameStats!.map((x) => x.toJson())),
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

class GameStat {
  String? sportId;
  int? matchesPlayed;
  int? matchesWon;
  String? level;

  GameStat({
    this.sportId,
    this.matchesPlayed,
    this.matchesWon,
    this.level,
  });

  factory GameStat.fromJson(Map<String, dynamic> json) => GameStat(
        sportId: json["sport_id"],
        matchesPlayed: json["matches_played"],
        matchesWon: json["matches_won"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "sport_id": sportId,
        "matches_played": matchesPlayed,
        "matches_won": matchesWon,
        "level": level,
      };
}

class Rating {
  String? name;
  dynamic img;
  String? reviewMessage;
  int? rating;
  int? reviewDate;

  Rating({
    this.name,
    this.img,
    this.reviewMessage,
    this.rating,
    this.reviewDate,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        name: json["name"],
        img: json["img"],
        reviewMessage: json["review_message"],
        rating: json["rating"],
        reviewDate: json["review_date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "img": img,
        "review_message": reviewMessage,
        "rating": rating,
        "review_date": reviewDate,
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
