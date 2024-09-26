import 'package:flutter/material.dart';
import 'package:yoursportz/presentation/widgets/my_profile_stats_card.dart';
import 'package:yoursportz/presentation/widgets/public_profile_stats_card.dart';

class PublicProfileLast5Player extends StatelessWidget {
  final Map<String, dynamic> data;
  const PublicProfileLast5Player({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 3 / 4,
      shrinkWrap: true,
      crossAxisCount: 3,
      children: [
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["Matches"] ?? 0,
          statsTitle: "Matches",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["Goals"] ?? 0,
          statsTitle: "Goals",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["GoldenGoals"] ?? 0,
          statsTitle: "Golden Goals",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["ShotOnGoal"] ?? 0,
          statsTitle: "Shots On Target",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["ShotOffGoal"] ?? 0,
          statsTitle: "Shots Off Target",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["Offsides"] ?? 0,
          statsTitle: "Offsides",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["RedCards"] ?? 0,
          statsTitle: "Red Cards",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["YellowCards"] ?? 0,
          statsTitle: "Yellow Cards",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["Fouls"] ?? 0,
          statsTitle: "Fouls",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["ThrowIns"] ?? 0,
          statsTitle: "Throw-Ins",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["FreeKicks"] ?? 0,
          statsTitle: "Free Kicks",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["Subtitutions"] ?? 0,
          statsTitle: "Subtitutions",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["CornerKicks"] ?? 0,
          statsTitle: "Corners",
        ),
        MyProfileStatsCard(
          statsTotal: data["lastFiveMatches"]["Penalties"] ?? 0,
          statsTitle: "Penalties",
        ),
      ],
    );
  }
}
