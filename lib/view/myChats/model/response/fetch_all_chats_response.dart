// To parse this JSON data, do
//
//     final fetchAllChatsResponse = fetchAllChatsResponseFromJson(jsonString);

import 'dart:convert';

FetchAllChatsResponse fetchAllChatsResponseFromJson(String str) => FetchAllChatsResponse.fromJson(json.decode(str));

String fetchAllChatsResponseToJson(FetchAllChatsResponse data) => json.encode(data.toJson());

class FetchAllChatsResponse {
    String? status;
    List<Chat>? chats;

    FetchAllChatsResponse({
        this.status,
        this.chats,
    });

    factory FetchAllChatsResponse.fromJson(Map<String, dynamic> json) => FetchAllChatsResponse(
        status: json["status"],
        chats: json["chats"] == null ? [] : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "chats": chats == null ? [] : List<dynamic>.from(chats!.map((x) => x.toJson())),
    };
}

class Chat {
    String? id;
    List<User>? users;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Chat({
        this.id,
        this.users,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class User {
    String? id;
    String? img;
    String? name;

    User({
        this.id,
        this.img,
        this.name,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
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
