import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/presentation/tournament/start_match/tournament_toss1.dart';
import 'package:yoursportz/presentation/widgets/appbar.dart';
import 'package:yoursportz/presentation/widgets/custom_btn.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/size_utils.dart';

import '../../../utils/color.dart';

class SelectedTeamViewPage extends StatefulWidget {
  const SelectedTeamViewPage({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  State<SelectedTeamViewPage> createState() => _SelectedTeamViewPageState();
}

class _SelectedTeamViewPageState extends State<SelectedTeamViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.kBGcolors,
      appBar: customAppBarForTournament(
        context: context,
        title: 'Select Teams',
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: width(context, 1),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          h(22),
                          playerCard(player: context.watch<StartMatchVM>().getHomeTeamGoalkeeper),
                          Expanded(
                            child: Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.spaceEvenly,
                              runSpacing: 20,
                              spacing: 20,
                              children: [
                                ...context
                                    .watch<StartMatchVM>()
                                    .getSelectedHomeTeamWithoutGoalkeeper
                                    .map(
                                      (e) => playerCard(player: e),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Expanded(
                            child: Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.spaceEvenly,
                              runSpacing: 20,
                              spacing: 20,
                              children: [
                                ...context
                                    .watch<StartMatchVM>()
                                    .getSelectedOpponentTeamWithoutGoalkeeper
                                    .map(
                                      (e) => playerCard(player: e),
                                    ),
                              ],
                            ),
                          ),
                          playerCard(
                              player: context.watch<StartMatchVM>().getOpponentTeamGoalkeeper),
                          h(44),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          customButtonForTournament(
            title: "Next",
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TournamentToss1(phone: widget.phone),
                ),
              );
            },
            margin: const EdgeInsets.all(16).copyWith(top: 8),
          ),
        ],
      ),
    );
  }

  playerCard({required Player? player}) {
    if (player == null) {
      return Container();
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: player.dp != null && (player.dp ?? "").isNotEmpty && player.dp != "null"
              ? Image.network(
                  player.dp ?? "",
                  fit: BoxFit.cover,
                  height: 30,
                  width: 30,
                )
              : Image.asset(
                  'assets/images/dp.png',
                  fit: BoxFit.cover,
                  height: 30,
                  width: 30,
                ),
        ),
        h(3),
        Container(
          height: 16,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              (player.name ?? "").trim().split(" ").isNotEmpty
                  ? (player.name ?? "").trim().split(" ").first
                  : "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.inter(
                color: TColor.white,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
