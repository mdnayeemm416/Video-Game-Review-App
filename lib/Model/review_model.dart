// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());



class ReviewModel {
    int id;
    String username;
    String email;
    double rating;
    String comments;
    String latitude;
    String longitude;
    DateTime createdOn;
    int gameId;

    ReviewModel({
        required this.id,
        required this.username,
        required this.email,
        required this.rating,
        required this.comments,
        required this.latitude,
        required this.longitude,
        required this.createdOn,
        required this.gameId,
    });

    factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        rating: json["rating"]?.toDouble(),
        comments: json["comments"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdOn: DateTime.parse(json["created_on"]),
        gameId: json["game_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "rating": rating,
        "comments": comments,
        "latitude": latitude,
        "longitude": longitude,
        "created_on": createdOn.toIso8601String(),
        "game_id": gameId,
    };
}


