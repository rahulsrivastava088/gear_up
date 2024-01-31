// To parse this JSON data, do
//
//     final accessChatResponse = accessChatResponseFromJson(jsonString);

import 'dart:convert';

AccessChatResponse accessChatResponseFromJson(String str) => AccessChatResponse.fromJson(json.decode(str));

String accessChatResponseToJson(AccessChatResponse data) => json.encode(data.toJson());

class AccessChatResponse {
    String? status;
    Chat? chat;

    AccessChatResponse({
        this.status,
        this.chat,
    });

    factory AccessChatResponse.fromJson(Map<String, dynamic> json) => AccessChatResponse(
        status: json["status"],
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "chat": chat?.toJson(),
    };
}

class Chat {
    String? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    Receiver? sender;
    Receiver? receiver;

    Chat({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.sender,
        this.receiver,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
        receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
    };
}

class Receiver {
    String? id;
    String? img;
    String? name;

    Receiver({
        this.id,
        this.img,
        this.name,
    });

    factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["_id"],
        img: json["img"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "img": img,
        "name": name,
    };
}
