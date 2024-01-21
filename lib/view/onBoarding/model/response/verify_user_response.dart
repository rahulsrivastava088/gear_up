import 'dart:convert';

VerifyUser verifyUserResponseFromJson(String str) =>
    VerifyUser.fromJson(json.decode(str));

String verifyUserResponseToJson(VerifyUser data) => json.encode(data.toJson());

class VerifyUser {
  String? status;
  User? user;
  String? token;
  String? message;

  VerifyUser({
    this.status,
    this.user,
    this.token,
    this.message,
  });

  factory VerifyUser.fromJson(Map<String, dynamic> json) => VerifyUser(
        status: json["status"],
        user: User.fromJson(json["user"]),
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user?.toJson(),
        "token": token,
        "message": message,
      };
}

class User {
  int? mobileNumber;
  List<dynamic>? favoriteSports;
  String? country;
  bool? newUser;
  String? referralCode;
  String? id;
  List<dynamic>? addresses;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.mobileNumber,
    this.favoriteSports,
    this.country,
    this.newUser,
    this.referralCode,
    this.id,
    this.addresses,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        mobileNumber: json["mobileNumber"],
        favoriteSports:
            List<dynamic>.from(json["favorite_sports"].map((x) => x)),
        country: json["country"],
        newUser: json["new_user"],
        referralCode: json["referral_code"],
        id: json["_id"],
        addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNumber'] = mobileNumber;
    if (favoriteSports != null) {
      data["favorite_sports"] =
          List<dynamic>.from(favoriteSports!.map((x) => x));
    } else {
      data["favorite_sports"] = List.empty();
    }
    data["country"] = country;
    data["new_user"] = newUser;
    data["referral_code"] = referralCode;
    data["_id"] = id;
    if (addresses != null) {
      data["addresses"] = List<dynamic>.from(addresses!.map((x) => x));
    } else {
      data["addresses"] = List.empty();
    }
    data["createdAt"] = createdAt?.toIso8601String();
    data["updatedAt"] = updatedAt?.toIso8601String();
    data["__v"] = v;
    return data;
  }
}
