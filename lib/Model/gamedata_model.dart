// To parse this JSON data, do
//
//     final gameModel = gameModelFromJson(jsonString);

import 'dart:convert';

GameModel gameModelFromJson(String str) => GameModel.fromJson(json.decode(str));

String gameModelToJson(GameModel data) => json.encode(data.toJson());

class GameModel {
    List<Item> items;
    bool hasMore;
    int limit;
    int offset;
    int count;
    List<Link> links;

    GameModel({
        required this.items,
        required this.hasMore,
        required this.limit,
        required this.offset,
        required this.count,
        required this.links,
    });

    factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        hasMore: json["hasMore"],
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "hasMore": hasMore,
        "limit": limit,
        "offset": offset,
        "count": count,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
    };
}

class Item {
    int id;
    String title;
    dynamic originalreleasedate;
    String descriptions;
    dynamic originallanguage;
    dynamic officialsiteurl;
    dynamic releases;
    dynamic platforms;
    dynamic companies;
    DateTime createdOn;
    String gameImage;
    dynamic averageRating;

    Item({
        required this.id,
        required this.title,
        required this.originalreleasedate,
        required this.descriptions,
        required this.originallanguage,
        required this.officialsiteurl,
        required this.releases,
        required this.platforms,
        required this.companies,
        required this.createdOn,
        required this.gameImage,
        required this.averageRating,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        originalreleasedate: json["originalreleasedate"],
        descriptions: json["descriptions"],
        originallanguage: json["originallanguage"],
        officialsiteurl: json["officialsiteurl"],
        releases: json["releases"],
        platforms: json["platforms"],
        companies: json["companies"],
        createdOn: DateTime.parse(json["created_on"]),
        gameImage: json["game_image"],
        averageRating: json["average_rating"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "originalreleasedate": originalreleasedate,
        "descriptions": descriptions,
        "originallanguage": originallanguage,
        "officialsiteurl": officialsiteurl,
        "releases": releases,
        "platforms": platforms,
        "companies": companies,
        "created_on": createdOn.toIso8601String(),
        "game_image": gameImage,
        "average_rating": averageRating,
    };
}

class Link {
    String rel;
    String href;

    Link({
        required this.rel,
        required this.href,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "rel": rel,
        "href": href,
    };
}
