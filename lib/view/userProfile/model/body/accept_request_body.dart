// To parse this JSON data, do
//
//     final acceptConnectionRequestBody = acceptConnectionRequestBodyFromJson(jsonString);

import 'dart:convert';

AcceptConnectionRequestBody acceptConnectionRequestBodyFromJson(String str) => AcceptConnectionRequestBody.fromJson(json.decode(str));

String acceptConnectionRequestBodyToJson(AcceptConnectionRequestBody data) => json.encode(data.toJson());

class AcceptConnectionRequestBody {
    String? senderId;

    AcceptConnectionRequestBody({
        this.senderId,
    });

    factory AcceptConnectionRequestBody.fromJson(Map<String, dynamic> json) => AcceptConnectionRequestBody(
        senderId: json["senderId"],
    );

    Map<String, dynamic> toJson() => {
        "senderId": senderId,
    };
}
