import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/tournament/start_match/components/ground_team_logo_name_widget.dart';
import 'package:yoursportz/presentation/widgets/appbar.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';

import 'tournament_toss_1_options.dart';

class TournamentToss1 extends StatefulWidget {
  const TournamentToss1({super.key, required this.phone});

  final String phone;

  @override
  State<TournamentToss1> createState() => _TournamentToss1State();
}

class _TournamentToss1State extends State<TournamentToss1> {
  @override
  Widget build(BuildContext context) {
    var homeTeam = context.watch<StartMatchVM>().homeTeam;
    var opponentTeam = context.watch<StartMatchVM>().opponentTeam;

    return Scaffold(
      appBar: customAppBarForTournament(
        context: context,
        title: 'Begin Match',
      ),
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
                title:
                    "${homeTeam?.name ?? ""} (${context.watch<StartMatchVM>().homeSelectedPlayerIdList.length} Players)",
              ),
              h(50),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TournamentToss1Options(phone: widget.phone),
                    ),
                  );
                },
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(
                      100,
                    ), // Adjust the radius as needed
                  ),
                  child: Center(
                    child: Text(
                      "Toss",
                      style: GoogleFonts.inter(color: TColor.msgbck, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              h(50),
              GroundTeamLogoNameWidget(
                image: opponentTeam?.logo,
                title:
                    "${opponentTeam?.name ?? ""} (${context.watch<StartMatchVM>().opponentSelectedPlayerIdList.length} Players)",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
