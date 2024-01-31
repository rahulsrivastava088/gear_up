// To parse this JSON data, do
//
//     final createGameBody = createGameBodyFromJson(jsonString);

import 'dart:convert';

CreateGameBody createGameBodyFromJson(String str) => CreateGameBody.fromJson(json.decode(str));

String createGameBodyToJson(CreateGameBody data) => json.encode(data.toJson());

class CreateGameBody {
    String? player2;
    String? venue;
    String? sport;
    int? matchDate;
    int? duration;

    CreateGameBody({
        this.player2,
        this.venue,
        this.sport,
        this.matchDate,
        this.duration,
    });

    factory CreateGameBody.fromJson(Map<String, dynamic> json) => CreateGameBody(
        player2: json["player2"],
        venue: json["venue"],
        sport: json["sport"],
        matchDate: json["matchDate"],
        duration: json["duration"],
    );

    Map<String, dynamic> toJson() => {
        "player2": player2,
        "venue": venue,
        "sport": sport,
        "matchDate": matchDate,
        "duration": duration,
    };
}
