// To parse this JSON data, do
//
//     final acceptConnectionRequestResponse = acceptConnectionRequestResponseFromJson(jsonString);

import 'dart:convert';

AcceptConnectionRequestResponse acceptConnectionRequestResponseFromJson(String str) => AcceptConnectionRequestResponse.fromJson(json.decode(str));

String acceptConnectionRequestResponseToJson(AcceptConnectionRequestResponse data) => json.encode(data.toJson());

class AcceptConnectionRequestResponse {
    String? status;
    ConnectionRequest? connectionRequest;

    AcceptConnectionRequestResponse({
        this.status,
        this.connectionRequest,
    });

    factory AcceptConnectionRequestResponse.fromJson(Map<String, dynamic> json) => AcceptConnectionRequestResponse(
        status: json["status"],
        connectionRequest: json["connectionRequest"] == null ? null : ConnectionRequest.fromJson(json["connectionRequest"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "connectionRequest": connectionRequest?.toJson(),
    };
}

class ConnectionRequest {
    String? id;
    Sender? sender;
    String? receiver;
    String? status;
    DateTime? sentDate;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    ConnectionRequest({
        this.id,
        this.sender,
        this.receiver,
        this.status,
        this.sentDate,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory ConnectionRequest.fromJson(Map<String, dynamic> json) => ConnectionRequest(
        id: json["_id"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        receiver: json["receiver"],
        status: json["status"],
        sentDate: json["sentDate"] == null ? null : DateTime.parse(json["sentDate"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender?.toJson(),
        "receiver": receiver,
        "status": status,
        "sentDate": sentDate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Sender {
    String? id;
    String? name;

    Sender({
        this.id,
        this.name,
    });

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}
