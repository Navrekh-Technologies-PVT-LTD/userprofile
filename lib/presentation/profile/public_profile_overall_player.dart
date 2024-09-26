import 'package:flutter/material.dart';
import 'package:yoursportz/presentation/widgets/my_profile_stats_card.dart';
import 'package:yoursportz/presentation/widgets/public_profile_stats_card.dart';

class PublicProfileOverallPlayer extends StatelessWidget {
  final Map<String, dynamic> data;
  const PublicProfileOverallPlayer({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 3 / 4,
      shrinkWrap: true,
      crossAxisCount: 3,
      children: [
        MyProfileStatsCard(
          statsTotal: data["Matches"].length ?? 0,
          statsTitle: "Matches",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["Goals"] ?? 0,
          statsTitle: "Goals",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["GoldenGoals"] ?? 0,
          statsTitle: "Golden Goals",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["ShotOnGoal"] ?? 0,
          statsTitle: "Shots On Target",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["ShotOffGoal"] ?? 0,
          statsTitle: "Shots Off Target",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["Offsides"] ?? 0,
          statsTitle: "Offsides",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["RedCards"] ?? 0,
          statsTitle: "Red Cards",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["YellowCards"] ?? 0,
          statsTitle: "Yellow Cards",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["Fouls"] ?? 0,
          statsTitle: "Fouls",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["ThrowIns"] ?? 0,
          statsTitle: "Throw-Ins",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["FreeKicks"] ?? 0,
          statsTitle: "Free Kicks",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["Subtitutions"] ?? 0,
          statsTitle: "Subtitutions",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["CornerKicks"] ?? 0,
          statsTitle: "Corners",
        ),
        MyProfileStatsCard(
          statsTotal: data["Overall"]["Penalties"] ?? 0,
          statsTitle: "Penalties",
        ),
      ],
    );
  }
}
