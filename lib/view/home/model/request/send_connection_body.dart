// To parse this JSON data, do
//
//     final sendConnectionRequestBody = sendConnectionRequestBodyFromJson(jsonString);

import 'dart:convert';

SendConnectionRequestBody sendConnectionRequestBodyFromJson(String str) => SendConnectionRequestBody.fromJson(json.decode(str));

String sendConnectionRequestBodyToJson(SendConnectionRequestBody data) => json.encode(data.toJson());

class SendConnectionRequestBody {
    String? receiverId;

    SendConnectionRequestBody({
        this.receiverId,
    });

    factory SendConnectionRequestBody.fromJson(Map<String, dynamic> json) => SendConnectionRequestBody(
        receiverId: json["receiverId"],
    );

    Map<String, dynamic> toJson() => {
        "receiverId": receiverId,
    };
}
