// To parse this JSON data, do
//
//     final getVenuesResponse = getVenuesResponseFromJson(jsonString);

import 'dart:convert';

GetVenuesResponse getVenuesResponseFromJson(String str) => GetVenuesResponse.fromJson(json.decode(str));

String getVenuesResponseToJson(GetVenuesResponse data) => json.encode(data.toJson());

class GetVenuesResponse {
    String? status;
    List<Venue>? venues;

    GetVenuesResponse({
        this.status,
        this.venues,
    });

    factory GetVenuesResponse.fromJson(Map<String, dynamic> json) => GetVenuesResponse(
        status: json["status"],
        venues: json["venues"] == null ? [] : List<Venue>.from(json["venues"]!.map((x) => Venue.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "venues": venues == null ? [] : List<dynamic>.from(venues!.map((x) => x.toJson())),
    };
}

class Venue {
    Location? location;
    String? id;
    String? name;
    String? img;
    List<SportsList>? sportsList;
    int? v;

    Venue({
        this.location,
        this.id,
        this.name,
        this.img,
        this.sportsList,
        this.v,
    });

    factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        id: json["_id"],
        name: json["name"],
        img: json["img"],
        sportsList: json["sportsList"] == null ? [] : List<SportsList>.from(json["sportsList"]!.map((x) => SportsList.fromJson(x))),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "name": name,
        "img": img,
        "sportsList": sportsList == null ? [] : List<dynamic>.from(sportsList!.map((x) => x.toJson())),
        "__v": v,
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

class SportsList {
    String? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    SportsList({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory SportsList.fromJson(Map<String, dynamic> json) => SportsList(
        id: json["_id"],
        name: json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
