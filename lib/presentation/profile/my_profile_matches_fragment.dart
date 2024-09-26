import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/widgets/my_profile_matches_card.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';

class MyProfileMatchesFragment extends StatefulWidget {
  final Map<String, dynamic> data;
  const MyProfileMatchesFragment({required this.data, super.key});

  @override
  State<MyProfileMatchesFragment> createState() =>
      _MyProfileMatchesFragmentState();
}

class _MyProfileMatchesFragmentState extends State<MyProfileMatchesFragment> {
  @override
  Widget build(BuildContext context) {
    if (widget.data["Matches"].isEmpty || widget.data["status"] == "error") {
      return const Center(child: Text("No Teams"));
    } else {
      var data = widget.data["Matches"] as List<dynamic>;
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return MyProfileMatchesCard(
            matchName: "${data[index]["teamA"]} VS ${data[index]["teamB"]}"
                .toUpperCase(),
            matchVenue: data[0]["location"].toString().toUpperCase(),
            matchDate: data[index]["date"],
            scoreline:
                "${data[index]["teamAGoals"].toString()} - ${data[index]["teamBGoals"].toString()}",
            homeTeamName: data[index]["teamA"].toString().toUpperCase(),
            matchQuarter: data[index]["time"],
            matchState: data[index]["status"],
            awayTeamName: data[index]["teamB"].toString().toUpperCase(),
            homeImageUrl: data[index]["teamALogo"],
            awayImageUrl: data[index]["teamBLogo"],
          );
        },
      );
    }
  }
}
