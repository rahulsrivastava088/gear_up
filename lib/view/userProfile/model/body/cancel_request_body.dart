// To parse this JSON data, do
//
//     final cancelConnectionRequestBody = cancelConnectionRequestBodyFromJson(jsonString);

import 'dart:convert';

CancelConnectionRequestBody cancelConnectionRequestBodyFromJson(String str) => CancelConnectionRequestBody.fromJson(json.decode(str));

String cancelConnectionRequestBodyToJson(CancelConnectionRequestBody data) => json.encode(data.toJson());

class CancelConnectionRequestBody {
    String? connectionUserId;

    CancelConnectionRequestBody({
        this.connectionUserId,
    });

    factory CancelConnectionRequestBody.fromJson(Map<String, dynamic> json) => CancelConnectionRequestBody(
        connectionUserId: json["connectionUserId"],
    );

    Map<String, dynamic> toJson() => {
        "connectionUserId": connectionUserId,
    };
}
