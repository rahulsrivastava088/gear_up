// To parse this JSON data, do
//
//     final sendMessageResponse = sendMessageResponseFromJson(jsonString);

import 'dart:convert';

import 'package:gear_up/view/myChats/model/response/getAllMessages_response.dart';

SendMessageResponse sendMessageResponseFromJson(String str) => SendMessageResponse.fromJson(json.decode(str));

String sendMessageResponseToJson(SendMessageResponse data) => json.encode(data.toJson());

class SendMessageResponse {
    String? status;
    Message? message;

    SendMessageResponse({
        this.status,
        this.message,
    });

    factory SendMessageResponse.fromJson(Map<String, dynamic> json) => SendMessageResponse(
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message?.toJson(),
    };
}

class Chat {
    String? id;
    List<String>? users;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? latestMessage;

    Chat({
        this.id,
        this.users,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.latestMessage,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        users: json["users"] == null ? [] : List<String>.from(json["users"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: json["latestMessage"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "latestMessage": latestMessage,
    };
}

class Sender {
    String? id;
    String? firstName;
    String? lastName;
    String? img;

    Sender({
        this.id,
        this.firstName,
        this.lastName,
        this.img,
    });

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "img": img,
    };
}
