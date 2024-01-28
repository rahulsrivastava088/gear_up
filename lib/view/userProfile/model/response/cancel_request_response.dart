// To parse this JSON data, do
//
//     final cancelConnectionRequestResponse = cancelConnectionRequestResponseFromJson(jsonString);

import 'dart:convert';

CancelConnectionRequestResponse cancelConnectionRequestResponseFromJson(String str) => CancelConnectionRequestResponse.fromJson(json.decode(str));

String cancelConnectionRequestResponseToJson(CancelConnectionRequestResponse data) => json.encode(data.toJson());

class CancelConnectionRequestResponse {
    String? status;
    String? message;

    CancelConnectionRequestResponse({
        this.status,
        this.message,
    });

    factory CancelConnectionRequestResponse.fromJson(Map<String, dynamic> json) => CancelConnectionRequestResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
