// To parse this JSON data, do
//
//     final rejectConnectionRequestResponse = rejectConnectionRequestResponseFromJson(jsonString);

import 'dart:convert';

RejectConnectionRequestResponse rejectConnectionRequestResponseFromJson(String str) => RejectConnectionRequestResponse.fromJson(json.decode(str));

String rejectConnectionRequestResponseToJson(RejectConnectionRequestResponse data) => json.encode(data.toJson());

class RejectConnectionRequestResponse {
    String? status;
    String? message;

    RejectConnectionRequestResponse({
        this.status,
        this.message,
    });

    factory RejectConnectionRequestResponse.fromJson(Map<String, dynamic> json) => RejectConnectionRequestResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
