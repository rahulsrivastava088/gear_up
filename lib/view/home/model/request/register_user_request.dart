import 'dart:convert';

RegisterUserBody registerUserBodyFromJson(String str) =>
    RegisterUserBody.fromJson(json.decode(str));

String registerUserBodyToJson(RegisterUserBody data) =>
    json.encode(data.toJson());

class RegisterUserBody {
  String? country;
  String? mobileNumber;

  RegisterUserBody({
    this.country,
    this.mobileNumber,
  });

  factory RegisterUserBody.fromJson(Map<String, dynamic> json) =>
      RegisterUserBody(
        country: json["country"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "mobileNumber": mobileNumber,
      };
}
