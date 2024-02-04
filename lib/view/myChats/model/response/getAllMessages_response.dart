// To parse this JSON data, do
//
//     final getAllMessages = getAllMessagesFromJson(jsonString);

import 'dart:convert';

GetAllMessages getAllMessagesFromJson(String str) =>
    GetAllMessages.fromJson(json.decode(str));

String getAllMessagesToJson(GetAllMessages data) => json.encode(data.toJson());

class GetAllMessages {
  String? status;
  List<Message>? messages;

  GetAllMessages({
    this.status,
    this.messages,
  });

  factory GetAllMessages.fromJson(Map<String, dynamic> json) => GetAllMessages(
        status: json["status"],
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message {
  String? id;
  String? sender;
  String? content;
  String? chat;
  bool? isGame;
  Game? game;
  int? createdAt;
  DateTime? updatedAt;
  int? v;

  Message({
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

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        sender: json["sender"],
        content: json["content"],
        chat: json["chat"],
        isGame: json["isGame"],
        game: json["game"] == null ? null : Game.fromJson(json["game"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender,
        "content": content,
        "chat": chat,
        "isGame": isGame,
        "game": game?.toJson(),
        "createdAt": createdAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Game {
  CheckedIn? checkedIn;
  Scorecard? scorecard;
  PlayerFeedback? player1Feedback;
  PlayerFeedback? player2Feedback;
  String? id;
  String? player1;
  String? player2;
  int? createdDate;
  int? matchDate;
  dynamic duration;
  String? sport;
  Venue? venue;
  String? gameStatus;
  dynamic cancelledBy;
  int? v;

  Game({
    this.checkedIn,
    this.scorecard,
    this.player1Feedback,
    this.player2Feedback,
    this.id,
    this.player1,
    this.player2,
    this.createdDate,
    this.matchDate,
    this.duration,
    this.sport,
    this.venue,
    this.gameStatus,
    this.cancelledBy,
    this.v,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        checkedIn: json["checked_in"] == null
            ? null
            : CheckedIn.fromJson(json["checked_in"]),
        scorecard: json["scorecard"] == null
            ? null
            : Scorecard.fromJson(json["scorecard"]),
        player1Feedback: json["player1Feedback"] == null
            ? null
            : PlayerFeedback.fromJson(json["player1Feedback"]),
        player2Feedback: json["player2Feedback"] == null
            ? null
            : PlayerFeedback.fromJson(json["player2Feedback"]),
        id: json["_id"],
        player1: json["player1"],
        player2: json["player2"],
        createdDate: json["createdDate"],
        matchDate: json["matchDate"],
        duration: json["duration"],
        sport: json["sport"],
        venue: json["venue"] == null ? null : Venue.fromJson(json["venue"]),
        gameStatus: json["gameStatus"],
        cancelledBy: json["cancelledBy"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "checked_in": checkedIn?.toJson(),
        "scorecard": scorecard?.toJson(),
        "player1Feedback": player1Feedback?.toJson(),
        "player2Feedback": player2Feedback?.toJson(),
        "_id": id,
        "player1": player1,
        "player2": player2,
        "createdDate": createdDate,
        "matchDate": matchDate,
        "duration": duration,
        "sport": sport,
        "venue": venue?.toJson(),
        "gameStatus": gameStatus,
        "cancelledBy": cancelledBy,
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

class Venue {
  Location? location;
  String? id;
  String? name;

  Venue({
    this.location,
    this.id,
    this.name,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "name": name,
      };
}

class Location {
  String? lat;
  String? lng;
  String? line1;
  String? line2;
  String? line3;
  String? line4;

  Location({
    this.lat,
    this.lng,
    this.line1,
    this.line2,
    this.line3,
    this.line4,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        lng: json["lng"],
        line1: json["line1"],
        line2: json["line2"],
        line3: json["line3"],
        line4: json["line4"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "line1": line1,
        "line2": line2,
        "line3": line3,
        "line4": line4,
      };
}
