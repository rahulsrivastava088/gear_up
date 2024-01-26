// To parse this JSON data, do
//
//     final getAllMessages = getAllMessagesFromJson(jsonString);

import 'dart:convert';

GetAllMessages getAllMessagesFromJson(String str) => GetAllMessages.fromJson(json.decode(str));

String getAllMessagesToJson(GetAllMessages data) => json.encode(data.toJson());

class GetAllMessages {
    String? status;
    List<Message>? messages;

    GetAllMessages({
        this.status,
        this.messages,
    });

    factory GetAllMessages.fromJson(Map<String, dynamic> json) => GetAllMessages(
        status: json["status"],
        messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    };
}

class Message {
    String? id;
    String? sender;
    String? content;
    String? chat;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Message({
        this.id,
        this.sender,
        this.content,
        this.chat,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        sender: json["sender"],
        content: json["content"],
        chat: json["chat"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender,
        "content": content,
        "chat": chat,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
