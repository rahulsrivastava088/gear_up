import 'dart:convert';

RegisterUser registerUserFromJson(String str) =>
    RegisterUser.fromJson(json.decode(str));

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
  String? status;
  String? message;
  String? otpId;

  RegisterUser({
    this.status,
    this.message,
    this.otpId,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        status: json["status"],
        message: json["message"],
        otpId: json["otpId"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "otpId": otpId,
      };
}
