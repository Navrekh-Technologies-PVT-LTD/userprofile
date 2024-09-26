// To parse this JSON data, do
//
//     final teamEntity = teamEntityFromJson(jsonString);

import 'dart:convert';

import 'package:yoursportz/domain/tournament/tournaments_entity.dart';

List<TeamModel> teamEntityFromJson(String str) =>
    List<TeamModel>.from(json.decode(str).map((x) => TeamModel.fromJson(x)));

String teamEntityToJson(List<TeamEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamEntity {
  String? id;
  String? teamId;
  String? name;
  String? phone;
  String? city;
  String? logo;
  String? inviteLink;
  String? inviteToken;
  List<Player>? players;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TeamEntity({
    this.id,
    this.teamId,
    this.name,
    this.phone,
    this.city,
    this.logo,
    this.inviteLink,
    this.inviteToken,
    this.players,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TeamEntity.fromJson(Map<String, dynamic> json) => TeamEntity(
        id: json["_id"],
        teamId: json["teamId"],
        name: json["name"],
        phone: json["phone"],
        city: json["city"],
        logo: json["logo"],
        inviteLink: json["invite_link"],
        inviteToken: json["invite_token"],
        players: List<Player>.from(json["players"].map((x) => Player.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "teamId": teamId,
        "name": name,
        "phone": phone,
        "city": city,
        "logo": logo,
        "invite_link": inviteLink,
        "invite_token": inviteToken,
        "players": List<dynamic>.from(players!.map((x) => x.toJson())),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class Player {
  String? name;
  String? phone;
  String? city;
  Position? position;
  String? dp;
  String? id;

  Player({
    this.name,
    this.phone,
    this.city,
    this.position,
    this.dp,
    this.id,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        name: json["name"],
        phone: json["phone"],
        city: json["city"],
        position: positionValues.map[json["position"]],
        dp: json["dp"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "city": city,
        "position": positionValues.reverse[position],
        "dp": dp,
        "_id": id,
      };
}

enum Position {
  CENTER_BACK,
  CENTER_FORWARD,
  CENTER_MIDFIELDER,
  CENTER_PLAYER,
  EMPTY,
  GOALKEEPER,
  LEFT_BACK,
  LEFT_MIDFIELDER,
  LEFT_WINGER,
  RIGHT_BACK,
  RIGHT_MIDFIELDER,
  RIGHT_WINGER
}

final positionValues = EnumValues({
  "Center Back": Position.CENTER_BACK,
  "Center Forward": Position.CENTER_FORWARD,
  "Center Midfielder": Position.CENTER_MIDFIELDER,
  "Center Player": Position.CENTER_PLAYER,
  "": Position.EMPTY,
  "Goalkeeper": Position.GOALKEEPER,
  "Left Back": Position.LEFT_BACK,
  "Left Midfielder": Position.LEFT_MIDFIELDER,
  "Left Winger": Position.LEFT_WINGER,
  "Right Back": Position.RIGHT_BACK,
  "Right Midfielder": Position.RIGHT_MIDFIELDER,
  "Right Winger": Position.RIGHT_WINGER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
