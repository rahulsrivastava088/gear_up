// To parse this JSON data, do
//
//     final createGameResponse = createGameResponseFromJson(jsonString);

import 'dart:convert';

CreateGameResponse createGameResponseFromJson(String str) => CreateGameResponse.fromJson(json.decode(str));

String createGameResponseToJson(CreateGameResponse data) => json.encode(data.toJson());

class CreateGameResponse {
    String? status;
    Game? game;

    CreateGameResponse({
        this.status,
        this.game,
    });

    factory CreateGameResponse.fromJson(Map<String, dynamic> json) => CreateGameResponse(
        status: json["status"],
        game: json["game"] == null ? null : Game.fromJson(json["game"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "game": game?.toJson(),
    };
}

class Game {
    String? player1;
    String? player2;
    int? createdDate;
    int? matchDate;
    int? duration;
    String? sport;
    String? venue;
    CheckedIn? checkedIn;
    Scorecard? scorecard;
    PlayerFeedback? player1Feedback;
    PlayerFeedback? player2Feedback;
    String? id;
    int? v;

    Game({
        this.player1,
        this.player2,
        this.createdDate,
        this.matchDate,
        this.duration,
        this.sport,
        this.venue,
        this.checkedIn,
        this.scorecard,
        this.player1Feedback,
        this.player2Feedback,
        this.id,
        this.v,
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        player1: json["player1"],
        player2: json["player2"],
        createdDate: json["createdDate"],
        matchDate: json["matchDate"],
        duration: json["duration"],
        sport: json["sport"],
        venue: json["venue"],
        checkedIn: json["checked_in"] == null ? null : CheckedIn.fromJson(json["checked_in"]),
        scorecard: json["scorecard"] == null ? null : Scorecard.fromJson(json["scorecard"]),
        player1Feedback: json["player1Feedback"] == null ? null : PlayerFeedback.fromJson(json["player1Feedback"]),
        player2Feedback: json["player2Feedback"] == null ? null : PlayerFeedback.fromJson(json["player2Feedback"]),
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "player1": player1,
        "player2": player2,
        "createdDate": createdDate,
        "matchDate": matchDate,
        "duration": duration,
        "sport": sport,
        "venue": venue,
        "checked_in": checkedIn?.toJson(),
        "scorecard": scorecard?.toJson(),
        "player1Feedback": player1Feedback?.toJson(),
        "player2Feedback": player2Feedback?.toJson(),
        "_id": id,
        "__v": v,
    };
}

class CheckedIn {
    bool? player1;
    bool? player2;

    CheckedIn({
        this.player1,
        this.player2,
    });

    factory CheckedIn.fromJson(Map<String, dynamic> json) => CheckedIn(
        player1: json["player1"],
        player2: json["player2"],
    );

    Map<String, dynamic> toJson() => {
        "player1": player1,
        "player2": player2,
    };
}

class PlayerFeedback {
    dynamic rateSkills;
    dynamic punctuality;
    dynamic sportsmanship;
    dynamic teamPlayer;
    dynamic competitiveness;
    dynamic respectful;
    dynamic reviewMessage;
    bool? updated;

    PlayerFeedback({
        this.rateSkills,
        this.punctuality,
        this.sportsmanship,
        this.teamPlayer,
        this.competitiveness,
        this.respectful,
        this.reviewMessage,
        this.updated,
    });

    factory PlayerFeedback.fromJson(Map<String, dynamic> json) => PlayerFeedback(
        rateSkills: json["rate_skills"],
        punctuality: json["punctuality"],
        sportsmanship: json["sportsmanship"],
        teamPlayer: json["teamPlayer"],
        competitiveness: json["competitiveness"],
        respectful: json["respectful"],
        reviewMessage: json["reviewMessage"],
        updated: json["updated"],
    );

    Map<String, dynamic> toJson() => {
        "rate_skills": rateSkills,
        "punctuality": punctuality,
        "sportsmanship": sportsmanship,
        "teamPlayer": teamPlayer,
        "competitiveness": competitiveness,
        "respectful": respectful,
        "reviewMessage": reviewMessage,
        "updated": updated,
    };
}

class Scorecard {
    dynamic matchesPlayed;
    dynamic matchesWonByPlayer1;
    dynamic matchesWonByPlayer2;
    dynamic matchesDrawn;
    bool? updated;
    dynamic winner;

    Scorecard({
        this.matchesPlayed,
        this.matchesWonByPlayer1,
        this.matchesWonByPlayer2,
        this.matchesDrawn,
        this.updated,
        this.winner,
    });

    factory Scorecard.fromJson(Map<String, dynamic> json) => Scorecard(
        matchesPlayed: json["matchesPlayed"],
        matchesWonByPlayer1: json["matchesWonByPlayer1"],
        matchesWonByPlayer2: json["matchesWonByPlayer2"],
        matchesDrawn: json["matchesDrawn"],
        updated: json["updated"],
        winner: json["winner"],
    );

    Map<String, dynamic> toJson() => {
        "matchesPlayed": matchesPlayed,
        "matchesWonByPlayer1": matchesWonByPlayer1,
        "matchesWonByPlayer2": matchesWonByPlayer2,
        "matchesDrawn": matchesDrawn,
        "updated": updated,
        "winner": winner,
    };
}
