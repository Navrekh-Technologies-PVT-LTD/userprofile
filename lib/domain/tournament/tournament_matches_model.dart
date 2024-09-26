// models.dart

// Player model
class Player {
  String name;
  String phone;
  String city;
  String position;
  String dp;
  String id;

  Player({
    required this.name,
    required this.phone,
    required this.city,
    required this.position,
    required this.dp,
    required this.id,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      phone: json['phone'],
      city: json['city'],
      position: json['position'],
      dp: json['dp'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'city': city,
      'position': position,
      'dp': dp,
      '_id': id,
    };
  }
}

// Team model
class Team {
  String id;
  String name;
  String phone;
  String city;
  String logo;
  String inviteLink;
  String inviteToken;
  List<Player> players;

  Team({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.logo,
    required this.inviteLink,
    required this.inviteToken,
    required this.players,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    var playerList = json['players'] as List;
    List<Player> playersList = playerList.map((i) => Player.fromJson(i)).toList();

    return Team(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
      city: json['city'],
      logo: json['logo'] ?? '',
      inviteLink: json['invite_link'],
      inviteToken: json['invite_token'],
      players: playersList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'phone': phone,
      'city': city,
      'logo': logo,
      'invite_link': inviteLink,
      'invite_token': inviteToken,
      'players': players.map((player) => player.toJson()).toList(),
    };
  }
}

// Match model
class MatchModel {
  String? tournamentId;
  String? phone;
  String? matchId;
  List<String>? groupName;
  List<dynamic>? teamAplayers;
  List<dynamic>? teamBplayers;
  String? time;
  String? location;
  String? teamALogo;
  String? teamBLogo;
  String? date;
  String? teamA;
  String? teamB;
  TeamForMatch? homeTeam;
  TeamForMatch? opponentTeam;
  String? teamAId;
  String? teamBId;
  List<Scorer?>? scorer;
  Ground? ground;
  String? caller;
  String? tossWon;
  List<dynamic>? streamer;
  List<dynamic>? referee;
  List<dynamic>? linesman;
  String? id;
  List<dynamic>? teamAsubstitutePlayers;
  List<dynamic>? teamBsubstitutePlayers;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? numberOfPlayers;

  MatchModel({
    this.tournamentId,
    this.phone,
    this.matchId,
    this.groupName,
    this.teamAplayers,
    this.teamBplayers,
    this.time,
    this.location,
    this.teamALogo,
    this.teamBLogo,
    this.date,
    this.teamA,
    this.teamB,
    this.homeTeam,
    this.opponentTeam,
    this.teamAId,
    this.teamBId,
    this.scorer,
    this.ground,
    this.caller,
    this.tossWon,
    this.streamer,
    this.referee,
    this.linesman,
    this.id,
    this.teamAsubstitutePlayers,
    this.teamBsubstitutePlayers,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.numberOfPlayers,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
        tournamentId: json["tournamentId"],
        phone: json["phone"],
        matchId: json["matchId"],
        groupName:
            json["groupName"] == null ? [] : List<String>.from(json["groupName"]!.map((x) => x)),
        teamAplayers: json["teamAplayers"] == null
            ? []
            : List<dynamic>.from(json["teamAplayers"]!.map((x) => x)),
        teamBplayers: json["teamBplayers"] == null
            ? []
            : List<dynamic>.from(json["teamBplayers"]!.map((x) => x)),
        time: json["time"],
        location: json["location"],
        teamALogo: json["teamALogo"],
        teamBLogo: json["teamBLogo"],
        date: json["date"],
        teamA: json["teamA"],
        teamB: json["teamB"],
        homeTeam: json["homeTeam"] == null ? null : TeamForMatch.fromJson(json["homeTeam"]),
        opponentTeam:
            json["opponentTeam"] == null ? null : TeamForMatch.fromJson(json["opponentTeam"]),
        teamAId: json["teamAId"],
        teamBId: json["teamBId"],
        scorer: json["scorer"] == null
            ? []
            : List<Scorer?>.from(json["scorer"]!.map((x) => x == null ? null : Scorer.fromJson(x))),
        ground: json["ground"] == null ? null : Ground.fromJson(json["ground"]),
        caller: json["caller"],
        tossWon: json["tossWon"],
        streamer:
            json["streamer"] == null ? [] : List<dynamic>.from(json["streamer"]!.map((x) => x)),
        referee: json["referee"] == null ? [] : List<dynamic>.from(json["referee"]!.map((x) => x)),
        linesman:
            json["linesman"] == null ? [] : List<dynamic>.from(json["linesman"]!.map((x) => x)),
        id: json["_id"],
        teamAsubstitutePlayers: json["teamAsubstitutePlayers"] == null
            ? []
            : List<dynamic>.from(json["teamAsubstitutePlayers"]!.map((x) => x)),
        teamBsubstitutePlayers: json["teamBsubstitutePlayers"] == null
            ? []
            : List<dynamic>.from(json["teamBsubstitutePlayers"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        numberOfPlayers: json["numberOfPlayers"],
      );

  Map<String, dynamic> toJson() => {
        "tournamentId": tournamentId,
        "phone": phone,
        "matchId": matchId,
        "groupName": groupName == null ? [] : List<dynamic>.from(groupName!.map((x) => x)),
        "teamAplayers": teamAplayers == null ? [] : List<dynamic>.from(teamAplayers!.map((x) => x)),
        "teamBplayers": teamBplayers == null ? [] : List<dynamic>.from(teamBplayers!.map((x) => x)),
        "time": time,
        "location": location,
        "teamALogo": teamALogo,
        "teamBLogo": teamBLogo,
        "date": date,
        "teamA": teamA,
        "teamB": teamB,
        "homeTeam": homeTeam?.toJson(),
        "opponentTeam": opponentTeam?.toJson(),
        "teamAId": teamAId,
        "teamBId": teamBId,
        "scorer": scorer == null ? [] : List<dynamic>.from(scorer!.map((x) => x?.toJson())),
        "ground": ground?.toJson(),
        "caller": caller,
        "tossWon": tossWon,
        "streamer": streamer == null ? [] : List<dynamic>.from(streamer!.map((x) => x)),
        "referee": referee == null ? [] : List<dynamic>.from(referee!.map((x) => x)),
        "linesman": linesman == null ? [] : List<dynamic>.from(linesman!.map((x) => x)),
        "_id": id,
        "teamAsubstitutePlayers": teamAsubstitutePlayers == null
            ? []
            : List<dynamic>.from(teamAsubstitutePlayers!.map((x) => x)),
        "teamBsubstitutePlayers": teamBsubstitutePlayers == null
            ? []
            : List<dynamic>.from(teamBsubstitutePlayers!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "numberOfPlayers": numberOfPlayers,
      };
}

class Ground {
  String? firstHalf;

  Ground({
    this.firstHalf,
  });

  factory Ground.fromJson(Map<String, dynamic> json) => Ground(
        firstHalf: json["firstHalf"],
      );

  Map<String, dynamic> toJson() => {
        "firstHalf": firstHalf,
      };
}

class TeamForMatch {
  String? id;
  String? teamId;
  String? name;
  String? phone;
  String? city;
  String? logo;
  String? inviteLink;
  String? inviteToken;
  List<PlayerForMatch>? players;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TeamForMatch({
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

  factory TeamForMatch.fromJson(Map<String, dynamic> json) => TeamForMatch(
        id: json["_id"],
        teamId: json["teamId"],
        name: json["name"],
        phone: json["phone"],
        city: json["city"],
        logo: json["logo"],
        inviteLink: json["invite_link"],
        inviteToken: json["invite_token"],
        players: json["players"] == null
            ? []
            : List<PlayerForMatch>.from(json["players"]!.map((x) => PlayerForMatch.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        "players": players == null ? [] : List<dynamic>.from(players!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class PlayerForMatch {
  String? name;
  String? phone;
  String? city;
  String? position;
  String? dp;
  String? id;

  PlayerForMatch({
    this.name,
    this.phone,
    this.city,
    this.position,
    this.dp,
    this.id,
  });

  factory PlayerForMatch.fromJson(Map<String, dynamic> json) => PlayerForMatch(
        name: json["name"],
        phone: json["phone"],
        city: json["city"],
        position: json["position"],
        dp: json["dp"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "city": city,
        "position": position,
        "dp": dp,
        "_id": id,
      };
}

class Scorer {
  String? id;
  String? name;
  String? phone;
  String? dp;
  String? dob;
  String? city;
  String? gender;
  String? latitude;
  String? longitude;
  String? language;
  String? token;
  List<dynamic>? followers;
  int? profileViews;
  String? height;
  String? foot;
  String? country;
  bool? isAdmin;
  String? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Scorer({
    this.id,
    this.name,
    this.phone,
    this.dp,
    this.dob,
    this.city,
    this.gender,
    this.latitude,
    this.longitude,
    this.language,
    this.token,
    this.followers,
    this.profileViews,
    this.height,
    this.foot,
    this.country,
    this.isAdmin,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Scorer.fromJson(Map<String, dynamic> json) => Scorer(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        dp: json["dp"],
        dob: json["dob"],
        city: json["city"],
        gender: json["gender"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        language: json["language"],
        token: json["token"],
        followers:
            json["followers"] == null ? [] : List<dynamic>.from(json["followers"]!.map((x) => x)),
        profileViews: json["profileViews"],
        height: json["height"],
        foot: json["foot"],
        country: json["country"],
        isAdmin: json["isAdmin"],
        position: json["position"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["v"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "dp": dp,
        "dob": dob,
        "city": city,
        "gender": gender,
        "latitude": latitude,
        "longitude": longitude,
        "language": language,
        "token": token,
        "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x)),
        "profileViews": profileViews,
        "height": height,
        "foot": foot,
        "country": country,
        "isAdmin": isAdmin,
        "position": position,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "v": v,
      };
}
