// ignore_for_file: public_member_api_docs, sort_constructors_first
class TournamentsEntity {
  List<TournamentData>? past;
  List<TournamentData>? ongoing;
  List<TournamentData>? upcoming;

  TournamentsEntity({
    this.past,
    this.ongoing,
    this.upcoming,
  });

  factory TournamentsEntity.fromJson(Map<String, dynamic> json) => TournamentsEntity(
        past: List<TournamentData>.from(json["past"].map((x) => TournamentData.fromJson(x))),
        ongoing: List<TournamentData>.from(json["ongoing"].map((x) => TournamentData.fromJson(x))),
        upcoming:
            List<TournamentData>.from(json["upcoming"].map((x) => TournamentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "past": List<dynamic>.from(past!.map((x) => x.toJson())),
        "ongoing": List<dynamic>.from(ongoing!.map((x) => x.toJson())),
        "upcoming": List<dynamic>.from(upcoming!.map((x) => x.toJson())),
      };
}

class TournamentData {
  Matches? matches;
  String? id;
  String? tournamentId;
  String? phone;
  String? logoUrl;
  String? bannerUrl;
  String? tournamentName;
  String? organizerName;
  String? organizerPhone;
  String? city;
  List<String>? groundNames;
  String? numberOfTeams;
  String? numberOfGroups;
  String? startDate;
  String? endDate;
  String? invite;
  String? inviteToken;
  String? share;
  String? gameTime;
  String? firstHalf;
  String? tournamentCategory;
  String? additionalDetails;
  List<TeamModel>? teams;
  String? tournamentType;
  List<List<TeamModel>>? groupedTeams;
  List<List<PointsTableModel>>? pointsTable;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? status;

  TournamentData({
    this.matches,
    this.id,
    this.tournamentId,
    this.phone,
    this.logoUrl,
    this.bannerUrl,
    this.tournamentName,
    this.organizerName,
    this.organizerPhone,
    this.city,
    this.groundNames,
    this.numberOfTeams,
    this.numberOfGroups,
    this.startDate,
    this.endDate,
    this.invite,
    this.inviteToken,
    this.share,
    this.gameTime,
    this.firstHalf,
    this.tournamentCategory,
    this.additionalDetails,
    this.teams,
    this.tournamentType,
    this.groupedTeams,
    this.pointsTable,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.status,
  });

  factory TournamentData.fromJson(Map<String, dynamic> json) => TournamentData(
        matches: Matches.fromJson(json["matches"]),
        id: json["_id"],
        tournamentId: json["tournamentId"],
        phone: json["phone"],
        logoUrl: json["logoUrl"],
        bannerUrl: json["bannerUrl"],
        tournamentName: json["tournamentName"],
        organizerName: json["organizerName"],
        organizerPhone: json["organizerPhone"],
        city: json["city"],
        groundNames: List<String>.from(json["groundNames"].map((x) => x)),
        numberOfTeams: json["numberOfTeams"],
        numberOfGroups: json["numberOfGroups"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        invite: json["invite"],
        inviteToken: json["invite_token"],
        share: json["share"],
        gameTime: json["gameTime"],
        firstHalf: json["firstHalf"],
        tournamentCategory: json["tournamentCategory"],
        additionalDetails: json["additionalDetails"],
        teams: List<TeamModel>.from(json["teams"].map((x) => TeamModel.fromJson(x))),
        tournamentType: json["tournamentType"],
        groupedTeams: List<List<TeamModel>>.from(json["groupedTeams"]
            .map((x) => List<TeamModel>.from(x.map((x) => TeamModel.fromJson(x))))),
        pointsTable: json["pointsTable"] == null
            ? []
            : List<List<PointsTableModel>>.from(json["pointsTable"]!.map(
                (x) => List<PointsTableModel>.from(x.map((x) => PointsTableModel.fromJson(x))))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "matches": matches!.toJson(),
        "_id": id,
        "tournamentId": tournamentId,
        "phone": phone,
        "logoUrl": logoUrl,
        "bannerUrl": bannerUrl,
        "tournamentName": tournamentName,
        "organizerName": organizerName,
        "organizerPhone": organizerPhone,
        "city": city,
        "groundNames": List<dynamic>.from(groundNames!.map((x) => x)),
        "numberOfTeams": numberOfTeams,
        "numberOfGroups": numberOfGroups,
        "startDate": startDate,
        "endDate": endDate,
        "invite": invite,
        "invite_token": inviteToken,
        "share": share,
        "gameTime": gameTime,
        "firstHalf": firstHalf,
        "tournamentCategory": tournamentCategory,
        "additionalDetails": additionalDetails,
        "teams": List<dynamic>.from(teams!.map((x) => x.toJson())),
        "tournamentType": tournamentType,
        "groupedTeams": List<dynamic>.from(
            groupedTeams!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "pointsTable": pointsTable == null
            ? []
            : List<dynamic>.from(
                pointsTable!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "status": status,
      };
}

class TeamModel {
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

  TeamModel({
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

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
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

  @override
  String toString() {
    return 'Team(id: $id, teamId: $teamId, name: $name, phone: $phone, city: $city, logo: $logo, inviteLink: $inviteLink, inviteToken: $inviteToken, players: $players, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }
}

class Player {
  String? name;
  String? phone;
  String? city;
  String? position;
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

enum Position {
  CENTER_BACK,
  CENTER_FORWARD,
  CENTER_MIDFIELDER,
  CENTER_PLAYER,
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
  "Goalkeeper": Position.GOALKEEPER,
  "Left Back": Position.LEFT_BACK,
  "Left Midfielder": Position.LEFT_MIDFIELDER,
  "Left Winger": Position.LEFT_WINGER,
  "Right Back": Position.RIGHT_BACK,
  "Right Midfielder": Position.RIGHT_MIDFIELDER,
  "Right Winger": Position.RIGHT_WINGER
});

class Matches {
  List<Past>? past;
  List<Live>? live;
  List<Past>? upcoming;

  Matches({
    this.past,
    this.live,
    this.upcoming,
  });

  factory Matches.fromJson(Map<String, dynamic> json) => Matches(
        past: List<Past>.from(json["past"].map((x) => Past.fromJson(x))),
        live: List<Live>.from(json["live"].map((x) => Live.fromJson(x))),
        upcoming: List<Past>.from(json["upcoming"].map((x) => Past.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "past": List<dynamic>.from(past!.map((x) => x.toJson())),
        "live": List<dynamic>.from(live!.map((x) => x.toJson())),
        "upcoming": List<dynamic>.from(upcoming!.map((x) => x.toJson())),
      };
}

class Live {
  String? tournamentId;
  String? phone;
  String? matchId;
  String? groupName;
  List<Player>? teamAplayers;
  List<Player>? teamBplayers;
  String? time;
  String? location;
  String? teamALogo;
  String? teamBLogo;
  String? date;
  String? teamA;
  String? teamB;
  TeamModel? homeTeam;
  TeamModel? opponentTeam;
  String? teamAId;
  String? teamBId;
  Scorer? scorer;
  Ground? ground;
  List<dynamic>? streamer;
  List<dynamic>? referee;
  List<dynamic>? linesman;
  String? id;
  List<dynamic>? teamAsubstitutePlayers;
  List<dynamic>? teamBsubstitutePlayers;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? timeSlot;

  Live({
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
    this.streamer,
    this.referee,
    this.linesman,
    this.id,
    this.teamAsubstitutePlayers,
    this.teamBsubstitutePlayers,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.timeSlot,
  });

  factory Live.fromJson(Map<String, dynamic> json) => Live(
        tournamentId: json["tournamentId"],
        phone: json["phone"],
        matchId: json["matchId"],
        groupName: json["groupName"],
        teamAplayers: List<Player>.from(json["teamAplayers"].map((x) => Player.fromJson(x))),
        teamBplayers: List<Player>.from(json["teamBplayers"].map((x) => Player.fromJson(x))),
        time: json["time"],
        location: json["location"],
        teamALogo: json["teamALogo"],
        teamBLogo: json["teamBLogo"],
        date: json["date"],
        teamA: json["teamA"],
        teamB: json["teamB"],
        homeTeam: TeamModel.fromJson(json["homeTeam"]),
        opponentTeam: TeamModel.fromJson(json["opponentTeam"]),
        teamAId: json["teamAId"],
        teamBId: json["teamBId"],
        scorer: Scorer.fromJson(json["scorer"]),
        ground: Ground.fromJson(json["ground"]),
        streamer: List<dynamic>.from(json["streamer"].map((x) => x)),
        referee: List<dynamic>.from(json["referee"].map((x) => x)),
        linesman: List<dynamic>.from(json["linesman"].map((x) => x)),
        id: json["_id"],
        teamAsubstitutePlayers: List<dynamic>.from(json["teamAsubstitutePlayers"].map((x) => x)),
        teamBsubstitutePlayers: List<dynamic>.from(json["teamBsubstitutePlayers"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        timeSlot: json["timeSlot"],
      );

  Map<String, dynamic> toJson() => {
        "tournamentId": tournamentId,
        "phone": phone,
        "matchId": matchId,
        "groupName": groupName,
        "teamAplayers": List<dynamic>.from(teamAplayers!.map((x) => x.toJson())),
        "teamBplayers": List<dynamic>.from(teamBplayers!.map((x) => x.toJson())),
        "time": time,
        "location": location,
        "teamALogo": teamALogo,
        "teamBLogo": teamBLogo,
        "date": date,
        "teamA": teamA,
        "teamB": teamB,
        "homeTeam": homeTeam!.toJson(),
        "opponentTeam": opponentTeam!.toJson(),
        "teamAId": teamAId,
        "teamBId": teamBId,
        "scorer": scorer!.toJson(),
        "ground": ground!.toJson(),
        "streamer": List<dynamic>.from(streamer!.map((x) => x)),
        "referee": List<dynamic>.from(referee!.map((x) => x)),
        "linesman": List<dynamic>.from(linesman!.map((x) => x)),
        "_id": id,
        "teamAsubstitutePlayers": List<dynamic>.from(teamAsubstitutePlayers!.map((x) => x)),
        "teamBsubstitutePlayers": List<dynamic>.from(teamBsubstitutePlayers!.map((x) => x)),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "timeSlot": timeSlot,
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

class Scorer {
  Id? id;
  Name? name;
  String? phone;
  String? dp;
  Dob? dob;
  String? city;
  Gender? gender;
  String? latitude;
  String? longitude;
  Language? language;
  String? token;
  List<dynamic>? followers;
  int? profileViews;
  String? height;
  Foot? foot;
  Country? country;
  bool? isAdmin;
  Position? position;
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
        id: idValues.map[json["_id"]],
        name: nameValues.map[json["name"]],
        phone: json["phone"],
        dp: json["dp"],
        dob: dobValues.map[json["dob"]],
        city: json["city"],
        gender: genderValues.map[json["gender"]],
        latitude: json["latitude"],
        longitude: json["longitude"],
        language: languageValues.map[json["language"]],
        token: json["token"],
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        profileViews: json["profileViews"],
        height: json["height"],
        foot: footValues.map[json["foot"]],
        country: countryValues.map[json["country"]],
        isAdmin: json["isAdmin"],
        position: positionValues.map[json["position"]],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "name": nameValues.reverse[name],
        "phone": phone,
        "dp": dp,
        "dob": dobValues.reverse[dob],
        "city": city,
        "gender": genderValues.reverse[gender],
        "latitude": latitude,
        "longitude": longitude,
        "language": languageValues.reverse[language],
        "token": token,
        "followers": List<dynamic>.from(followers!.map((x) => x)),
        "profileViews": profileViews,
        "height": height,
        "foot": footValues.reverse[foot],
        "country": countryValues.reverse[country],
        "isAdmin": isAdmin,
        "position": positionValues.reverse[position],
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

enum Country { IND }

final countryValues = EnumValues({"IND": Country.IND});

enum Dob { THE_05_FEB_1993, THE_12_JAN_1998 }

final dobValues =
    EnumValues({"05-Feb-1993": Dob.THE_05_FEB_1993, "12-Jan-1998": Dob.THE_12_JAN_1998});

enum Foot { RIGHT }

final footValues = EnumValues({"RIGHT": Foot.RIGHT});

enum Gender { GENDER_MALE, MALE }

final genderValues = EnumValues({"Male": Gender.GENDER_MALE, "male": Gender.MALE});

enum Id { THE_669117410441_FC846_DDD8_BFB, THE_66911_F2_C0384507218_DCB7_AE }

final idValues = EnumValues({
  "669117410441fc846ddd8bfb": Id.THE_669117410441_FC846_DDD8_BFB,
  "66911f2c0384507218dcb7ae": Id.THE_66911_F2_C0384507218_DCB7_AE
});

enum Language { ENG, ENGLISH }

final languageValues = EnumValues({"eng": Language.ENG, "English": Language.ENGLISH});

enum Name { ABRAR_HUSSAIN, OWAIS_YOSUF }

final nameValues =
    EnumValues({"Abrar Hussain": Name.ABRAR_HUSSAIN, "Owais Yosuf": Name.OWAIS_YOSUF});

class Past {
  String? tournamentId;
  String? phone;
  String? matchId;
  // String? groupName;
  String? timeSlot;
  String? location;
  String? date;
  String? teamA;
  String? teamB;
  String? teamAId;
  String? teamBId;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? time;

  Past({
    this.tournamentId,
    this.phone,
    this.matchId,
    // this.groupName,
    this.timeSlot,
    this.location,
    this.date,
    this.teamA,
    this.teamB,
    this.teamAId,
    this.teamBId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.time,
  });

  factory Past.fromJson(Map<String, dynamic> json) => Past(
        tournamentId: json["tournamentId"],
        phone: json["phone"],
        matchId: json["matchId"],
        // groupName: json["groupName"],
        timeSlot: json["timeSlot"],
        location: json["location"],
        date: json["date"],
        teamA: json["teamA"],
        teamB: json["teamB"],
        teamAId: json["teamAId"],
        teamBId: json["teamBId"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "tournamentId": tournamentId,
        "phone": phone,
        "matchId": matchId,
        // "groupName": groupName,
        "timeSlot": timeSlot,
        "location": location,
        "date": date,
        "teamA": teamA,
        "teamB": teamB,
        "teamAId": teamAId,
        "teamBId": teamBId,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "time": time,
      };
}

class TournamentRules {
  bool? extraTime;
  bool? penaltyKicks;
  bool? goldenGoal;

  TournamentRules({
    this.extraTime,
    this.penaltyKicks,
    this.goldenGoal,
  });

  factory TournamentRules.fromJson(Map<String, dynamic> json) => TournamentRules(
        extraTime: json["extraTime"],
        penaltyKicks: json["penaltyKicks"],
        goldenGoal: json["goldenGoal"],
      );

  Map<String, dynamic> toJson() => {
        "extraTime": extraTime,
        "penaltyKicks": penaltyKicks,
        "goldenGoal": goldenGoal,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class PointsTableModel {
  String? name;
  String? teamId;
  String? logo;
  String? city;
  String? phone;
  int? played;
  int? won;
  int? loss;
  int? draw;
  int? points;

  PointsTableModel({
    this.name,
    this.teamId,
    this.logo,
    this.city,
    this.phone,
    this.played,
    this.won,
    this.loss,
    this.draw,
    this.points,
  });

  factory PointsTableModel.fromJson(Map<String, dynamic> json) => PointsTableModel(
        name: json["name"],
        teamId: json["teamId"],
        logo: json["logo"],
        city: json["city"],
        phone: json["phone"],
        played: json["played"],
        won: json["won"],
        loss: json["loss"],
        draw: json["draw"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "teamId": teamId,
        "logo": logo,
        "city": city,
        "phone": phone,
        "played": played,
        "won": won,
        "loss": loss,
        "draw": draw,
        "points": points,
      };
}
