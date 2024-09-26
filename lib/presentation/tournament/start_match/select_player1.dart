import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/tournament/start_match/components/ground_team_logo_name_widget.dart';
import 'package:yoursportz/presentation/widgets/appbar.dart';
import 'package:yoursportz/presentation/widgets/custom_btn.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';

import 'select_player2.dart';

class SelectPlayerOne extends StatefulWidget {
  const SelectPlayerOne({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  State<SelectPlayerOne> createState() => _SelectPlayerOneState();
}

class _SelectPlayerOneState extends State<SelectPlayerOne> {
  @override
  Widget build(BuildContext context) {
    var homeTeam = context.watch<StartMatchVM>().homeTeam;
    var opponentTeam = context.watch<StartMatchVM>().opponentTeam;

    return Scaffold(
      backgroundColor: TColor.kBGcolors,
      appBar: customAppBarForTournament(context: context, title: "Select Players"),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GroundTeamLogoNameWidget(
                image: homeTeam?.logo,
                title: homeTeam?.name ?? "",
              ),
              h(53),
              customButtonForTournament(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                title: "Select Players",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectPlayer2(phone: widget.phone),
                    ),
                  );
                },
              ),
              h(53),
              GroundTeamLogoNameWidget(
                image: opponentTeam?.logo,
                title: opponentTeam?.name ?? "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
