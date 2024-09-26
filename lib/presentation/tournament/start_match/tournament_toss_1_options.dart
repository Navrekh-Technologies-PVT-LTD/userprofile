import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/tournament/start_match/toss_page.dart';
import 'package:yoursportz/presentation/widgets/appbar.dart';
import 'package:yoursportz/presentation/widgets/custom_btn.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';

import 'components/ground_team_logo_name_widget.dart';
import 'tournament_toss2.dart';

class TournamentToss1Options extends StatefulWidget {
  const TournamentToss1Options({super.key, required this.phone});

  final String phone;

  @override
  State<TournamentToss1Options> createState() => _TournamentToss1OptionsState();
}

class _TournamentToss1OptionsState extends State<TournamentToss1Options> {
  @override
  Widget build(BuildContext context) {
    var homeTeam = context.watch<StartMatchVM>().homeTeam;
    var opponentTeam = context.watch<StartMatchVM>().opponentTeam;

    return Scaffold(
      appBar: customAppBarForTournament(
        context: context,
        title: 'Begin Match',
      ),
      backgroundColor: TColor.kBGcolors,
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
              h(75),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButtonForTournament(
                    width: 142,
                    height: 35,
                    title: "Next",
                    isOutLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TournamentToss2(phone: widget.phone),
                        ),
                      );
                    },
                  ),
                  customButtonForTournament(
                    width: 142,
                    height: 35,
                    title: "Virtual Toss",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TossPage(phone: widget.phone),
                        ),
                      );
                    },
                  ),
                ],
              ),
              h(75),
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
