// To parse this JSON data, do
//
//     final sendConnectionRequestResponse = sendConnectionRequestResponseFromJson(jsonString);

import 'dart:convert';

SendConnectionRequestResponse sendConnectionRequestResponseFromJson(String str) => SendConnectionRequestResponse.fromJson(json.decode(str));

String sendConnectionRequestResponseToJson(SendConnectionRequestResponse data) => json.encode(data.toJson());

class SendConnectionRequestResponse {
    String? status;
    ConnectionRequest? connectionRequest;

    SendConnectionRequestResponse({
        this.status,
        this.connectionRequest,
    });

    factory SendConnectionRequestResponse.fromJson(Map<String, dynamic> json) => SendConnectionRequestResponse(
        status: json["status"],
        connectionRequest: json["connectionRequest"] == null ? null : ConnectionRequest.fromJson(json["connectionRequest"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "connectionRequest": connectionRequest?.toJson(),
    };
}

class ConnectionRequest {
    String? sender;
    String? receiver;
    String? status;
    DateTime? sentDate;
    String? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    ConnectionRequest({
        this.sender,
        this.receiver,
        this.status,
        this.sentDate,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory ConnectionRequest.fromJson(Map<String, dynamic> json) => ConnectionRequest(
        sender: json["sender"],
        receiver: json["receiver"],
        status: json["status"],
        sentDate: json["sentDate"] == null ? null : DateTime.parse(json["sentDate"]),
        id: json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "sender": sender,
        "receiver": receiver,
        "status": status,
        "sentDate": sentDate?.toIso8601String(),
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
