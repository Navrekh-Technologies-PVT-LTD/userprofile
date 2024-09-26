import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/core/constants.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/presentation/tournament/start_match/components/ground_team_logo_name_widget.dart';
import 'package:yoursportz/presentation/widgets/appbar.dart';
import 'package:yoursportz/presentation/widgets/custom_btn.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/size_utils.dart';

class CreateMatchSuccessPage extends StatefulWidget {
  const CreateMatchSuccessPage({super.key, this.isStartScoring = false});
  final bool isStartScoring;

  @override
  State<CreateMatchSuccessPage> createState() => _CreateMatchSuccessPageState();
}

class _CreateMatchSuccessPageState extends State<CreateMatchSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: customAppBarForTournament(
          context: context,
          title: "Start Match",
          onBack: () {
            if (widget.isStartScoring) {
              if (context.read<StartMatchVM>().isFromVirtualToss) {
                for (int i = 0; i < 10; i++) {
                  Navigator.of(context).pop();
                }
                Navigator.of(context).pop();
              } else {
                for (int i = 0; i < 8; i++) {
                  Navigator.of(context).pop();
                }
                Navigator.of(context).pop();
              }
            } else {}
          },
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: height(context, 1),
              width: width(context, 1),
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
                      image: context.watch<StartMatchVM>().homeTeam?.logo,
                      title: context.watch<StartMatchVM>().homeTeam?.name ?? "",
                    ),
                    h(165),
                    GroundTeamLogoNameWidget(
                      image: context.watch<StartMatchVM>().opponentTeam?.logo,
                      title: context.watch<StartMatchVM>().opponentTeam?.name ?? "",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: sizer(context, 0.34),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tr(LocaleKeys.match_created_successfully),
                    //"Match Created Successfully",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff0A0A0A),
                    ),
                  ),
                  h(16),
                  Text(
                    tr(LocaleKeys.match_officials_assigned_notified),
                    //"Match officials have been assigned and notified. Buckle up, because this match is about to take us on a rollercoaster ride of excitement.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff575757),
                    ),
                  ),
                  h(16),
                  customButtonForTournament(
                    title: widget.isStartScoring ? "Start Scoring" : "Go to  My Football",
                    onTap: () {
                      if (widget.isStartScoring) {
                        if (context.read<StartMatchVM>().isFromVirtualToss) {
                          for (int i = 0; i < 10; i++) {
                            Navigator.of(context).pop();
                          }
                          Navigator.of(context).pop(CreateMatchRout.startScoring);
                        } else {
                          for (int i = 0; i < 8; i++) {
                            Navigator.of(context).pop();
                          }
                          Navigator.of(context).pop(CreateMatchRout.startScoring);
                        }
                      } else {}

                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => Standings(
                      //         phone: widget.phone,
                      //         tournamentData: widget.tournament,
                      //       )), // Replace with your new screen widget
                      //       (Route<dynamic> route) =>
                      //   false, // This will remove all previous routes
                      // );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
