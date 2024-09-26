/// player model
class AllPlayerModel {
  final String id;
  final String name;
  final String phone;
  final String dp;
  final String dob;
  final String city;
  final String gender;
  final String latitude;
  final String longitude;
  final String language;
  final String token;
  final List<dynamic> followers;
  final int profileViews;
  final String height;
  final String foot;
  final String country;
  final bool isAdmin;
  final String position;
  final String createdAt;
  final String updatedAt;
  final int v;

  AllPlayerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.dp,
    required this.dob,
    required this.city,
    required this.gender,
    required this.latitude,
    required this.longitude,
    required this.language,
    required this.token,
    required this.followers,
    required this.profileViews,
    required this.height,
    required this.foot,
    required this.country,
    required this.isAdmin,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AllPlayerModel.fromJson(Map<String, dynamic> json) {
    return AllPlayerModel(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
      dp: json['dp'] ?? '', // Default to empty string if null
      dob: json['dob'],
      city: json['city'],
      gender: json['gender'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      language: json['language'],
      token: json['token'],
      followers: List<dynamic>.from(json['followers']),
      profileViews: json['profileViews'],
      height: json['height'],
      foot: json['foot'],
      country: json['country'],
      isAdmin: json['isAdmin'],
      position: json['position'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'dp': dp,
      'dob': dob,
      'city': city,
      'gender': gender,
      'latitude': latitude,
      'longitude': longitude,
      'language': language,
      'token': token,
      'followers': followers,
      'profileViews': profileViews,
      'height': height,
      'foot': foot,
      'country': country,
      'isAdmin': isAdmin,
      'position': position,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'v': v,
    };
  }
}


class RecentPlayer {
  final String id;
  final String chatId;
  final String playerId;
  final String secondPlayerId;
  final List<Member> members;
  final List<dynamic> messages;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String lastMessage; // Added
  final String lastMessageDate; // Added

  RecentPlayer({
    required this.id,
    required this.chatId,
    required this.playerId,
    required this.secondPlayerId,
    required this.members,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.lastMessage, // Added
    required this.lastMessageDate, // Added
  });

  factory RecentPlayer.fromJson(Map<String, dynamic> json) {
    var memberList = json['members'] as List;
    List<Member> members = memberList.map((i) => Member.fromJson(i)).toList();

    return RecentPlayer(
      id: json['_id'],
      chatId: json['chatId'],
      playerId: json['playerId'],
      secondPlayerId: json['secondPlayerId'],
      members: members,
      messages: json['messages'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      lastMessage: json['lastMessage'] ?? '', // Default empty string if null
      lastMessageDate: json['lastMessageDate'] ?? '', // Default empty string if null
    );
  }
}

class Member {
  final String phone;
  final String name;
  final String dp;

  Member({
    required this.phone,
    required this.name,
    required this.dp,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      phone: json['phone'],
      name: json['name'],
      dp: json['dp'],
    );
  }
}
