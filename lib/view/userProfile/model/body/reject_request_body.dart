// To parse this JSON data, do
//
//     final rejectConnectionRequestBody = rejectConnectionRequestBodyFromJson(jsonString);

import 'dart:convert';

RejectConnectionRequestBody rejectConnectionRequestBodyFromJson(String str) => RejectConnectionRequestBody.fromJson(json.decode(str));

String rejectConnectionRequestBodyToJson(RejectConnectionRequestBody data) => json.encode(data.toJson());

class RejectConnectionRequestBody {
    String? senderId;

    RejectConnectionRequestBody({
        this.senderId,
    });

    factory RejectConnectionRequestBody.fromJson(Map<String, dynamic> json) => RejectConnectionRequestBody(
        senderId: json["senderId"],
    );

    Map<String, dynamic> toJson() => {
        "senderId": senderId,
    };
}
