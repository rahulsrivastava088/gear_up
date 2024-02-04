// To parse this JSON data, do
//
//     final fetchAllChatsResponse = fetchAllChatsResponseFromJson(jsonString);

import 'dart:convert';

FetchAllChatsResponse fetchAllChatsResponseFromJson(String str) =>
    FetchAllChatsResponse.fromJson(json.decode(str));

String fetchAllChatsResponseToJson(FetchAllChatsResponse data) =>
    json.encode(data.toJson());

class FetchAllChatsResponse {
  String? status;
  List<Chat>? chats;

  FetchAllChatsResponse({
    this.status,
    this.chats,
  });

  factory FetchAllChatsResponse.fromJson(Map<String, dynamic> json) =>
      FetchAllChatsResponse(
        status: json["status"],
        chats: json["chats"] == null
            ? []
            : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "chats": chats == null
            ? []
            : List<dynamic>.from(chats!.map((x) => x.toJson())),
      };
}

class Chat {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  LatestMessage? latestMessage;
  Receiver? sender;
  Receiver? receiver;

  Chat({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.latestMessage,
    this.sender,
    this.receiver,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: json["latestMessage"] == null
            ? null
            : LatestMessage.fromJson(json["latestMessage"]),
        sender:
            json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
        receiver: json["receiver"] == null
            ? null
            : Receiver.fromJson(json["receiver"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "latestMessage": latestMessage?.toJson(),
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
      };
}

class LatestMessage {
  String? id;
  Sender? sender;
  String? content;
  String? chat;
  bool? isGame;
  dynamic game;
  int? createdAt;
  DateTime? updatedAt;
  int? v;

  LatestMessage({
    this.id,
    this.sender,
    this.content,
    this.chat,
    this.isGame,
    this.game,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        content: json["content"],
        chat: json["chat"],
        isGame: json["isGame"],
        game: json["game"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender?.toJson(),
        "content": content,
        "chat": chat,
        "isGame": isGame,
        "game": game,
        "createdAt": createdAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Sender {
  String? id;
  String? img;
  String? name;

  Sender({
    this.id,
    this.img,
    this.name,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
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

class Receiver {
  CurrentAddress? currentAddress;
  String? id;
  String? gender;
  String? img;
  int? age;
  String? name;

  Receiver({
    this.currentAddress,
    this.id,
    this.gender,
    this.img,
    this.age,
    this.name,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        currentAddress: json["current_address"] == null
            ? null
            : CurrentAddress.fromJson(json["current_address"]),
        id: json["_id"],
        gender: json["gender"],
        img: json["img"],
        age: json["age"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "current_address": currentAddress?.toJson(),
        "_id": id,
        "gender": gender,
        "img": img,
        "age": age,
        "name": name,
      };
}

class CurrentAddress {
  String? name;
  String? lat;
  String? lng;
  String? line1;
  String? line2;
  String? line3;
  String? line4;

  CurrentAddress({
    this.name,
    this.lat,
    this.lng,
    this.line1,
    this.line2,
    this.line3,
    this.line4,
  });

  factory CurrentAddress.fromJson(Map<String, dynamic> json) => CurrentAddress(
        name: json["name"],
        lat: json["lat"],
        lng: json["lng"],
        line1: json["line1"],
        line2: json["line2"],
        line3: json["line3"],
        line4: json["line4"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lng": lng,
        "line1": line1,
        "line2": line2,
        "line3": line3,
        "line4": line4,
      };
}
