// To parse this JSON data, do
//
//     final accessChatBody = accessChatBodyFromJson(jsonString);

import 'dart:convert';

AccessChatBody accessChatBodyFromJson(String str) => AccessChatBody.fromJson(json.decode(str));

String accessChatBodyToJson(AccessChatBody data) => json.encode(data.toJson());

class AccessChatBody {
    String? userId;

    AccessChatBody({
        this.userId,
    });

    factory AccessChatBody.fromJson(Map<String, dynamic> json) => AccessChatBody(
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
    };
}
