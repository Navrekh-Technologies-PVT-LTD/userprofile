import 'package:flutter/material.dart';
import 'package:yoursportz/presentation/widgets/my_profile_team_card.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';

class PublicProfileTeamsFragment extends StatefulWidget {
  final Map<String, dynamic> data;
  const PublicProfileTeamsFragment({super.key, required this.data});

  @override
  State<PublicProfileTeamsFragment> createState() =>
      _PublicProfileTeamsFragmentState();
}

class _PublicProfileTeamsFragmentState
    extends State<PublicProfileTeamsFragment> {
  @override
  Widget build(BuildContext context) {
    if (widget.data["Teams"].isEmpty || widget.data["status"] == "error") {
      return const Center(child: Text("No Teams"));
    } else {
      var data = widget.data["Teams"] as List<dynamic>;
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return MyProfileTeamCard(
              imageUrl: data[index]["teamLogo"],
              title: data[index]["teamName"],
              subtitle: data[index]["teamCity"]);
        },
      );
    }
  }
}
