import 'dart:convert';

VerifyUserBody verifyUserBodyFromJson(String str) =>
    VerifyUserBody.fromJson(json.decode(str));

String verifyUserBodyToJson(VerifyUserBody data) => json.encode(data.toJson());

class VerifyUserBody {
  String? otpEntered;
  String? otpId;

  VerifyUserBody({
    this.otpEntered,
    this.otpId,
  });

  factory VerifyUserBody.fromJson(Map<String, dynamic> json) => VerifyUserBody(
        otpEntered: json["otpEntered"],
        otpId: json["otpId"],
      );

  Map<String, dynamic> toJson() => {
        "otpEntered": otpEntered,
        "otpId": otpId,
      };
}
