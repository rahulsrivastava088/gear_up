// To parse this JSON data, do
//
//     final sendMessageBody = sendMessageBodyFromJson(jsonString);

import 'dart:convert';

SendMessageBody sendMessageBodyFromJson(String str) => SendMessageBody.fromJson(json.decode(str));

String sendMessageBodyToJson(SendMessageBody data) => json.encode(data.toJson());

class SendMessageBody {
    String? content;
    String? chatId;

    SendMessageBody({
        this.content,
        this.chatId,
    });

    factory SendMessageBody.fromJson(Map<String, dynamic> json) => SendMessageBody(
        content: json["content"],
        chatId: json["chatId"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "chatId": chatId,
    };
}
