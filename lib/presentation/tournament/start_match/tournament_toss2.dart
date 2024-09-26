// ignore_for_file: file_names, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/presentation/widgets/appbar.dart';
import 'package:yoursportz/presentation/widgets/custom_btn.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';

import 'create_match_success_page.dart';
import 'select_match_officials.dart';

class TournamentToss2 extends StatefulWidget {
  const TournamentToss2({super.key, required this.phone, this.isFromVirtualToss = false});

  final String phone;
  final bool isFromVirtualToss;

  @override
  State<TournamentToss2> createState() => _TournamentToss2State();
}

class _TournamentToss2State extends State<TournamentToss2> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<StartMatchVM>().changeIsLoadingCreateMatch(false);
        context.read<StartMatchVM>().changeIsFromVirtualToss(widget.isFromVirtualToss);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var homeTeam = context.watch<StartMatchVM>().homeTeam;
    var opponentTeam = context.watch<StartMatchVM>().opponentTeam;
    return Scaffold(
      backgroundColor: TColor.kBGcolors,
      appBar: customAppBarForTournament(
        context: context,
        title: 'Toss',
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(24),
        children: [
          Text(
            tr(LocaleKeys.who_is_the_caller),
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          h(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              teamSelectionCard(
                team: homeTeam,
                isSelected: context.watch<StartMatchVM>().callerTeamId == homeTeam?.id,
                onTap: () {
                  context.read<StartMatchVM>().changeCallerTeamId(homeTeam?.id);
                  context.read<StartMatchVM>().changeTossWonTeamId(null);
                  context.read<StartMatchVM>().changeWinnerDecidedTo(null);
                },
              ),
              w(12),
              teamSelectionCard(
                team: opponentTeam,
                isSelected: context.watch<StartMatchVM>().callerTeamId == opponentTeam?.id,
                onTap: () {
                  context.read<StartMatchVM>().changeCallerTeamId(opponentTeam?.id);
                  context.read<StartMatchVM>().changeTossWonTeamId(null);
                  context.read<StartMatchVM>().changeWinnerDecidedTo(null);
                },
              ),
            ],
          ),
          h(24),
          Text(
            tr(LocaleKeys.who_won_the_toss),
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          h(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              teamSelectionCard(
                team: homeTeam,
                isSelected: context.watch<StartMatchVM>().tossWonTeamId == homeTeam?.id,
                onTap: () {
                  if (context.read<StartMatchVM>().callerTeamId == null) {
                    showSnackBar(context, tr(LocaleKeys.please_select_caller_first));
                    return;
                  }
                  context.read<StartMatchVM>().changeTossWonTeamId(homeTeam?.id);
                  context.read<StartMatchVM>().changeWinnerDecidedTo(null);
                },
              ),
              w(12),
              teamSelectionCard(
                team: opponentTeam,
                isSelected: context.watch<StartMatchVM>().tossWonTeamId == opponentTeam?.id,
                onTap: () {
                  if (context.read<StartMatchVM>().callerTeamId == null) {
                    showSnackBar(context, tr(LocaleKeys.please_select_caller_first));
                    return;
                  }
                  context.read<StartMatchVM>().changeTossWonTeamId(opponentTeam?.id);
                  context.read<StartMatchVM>().changeWinnerDecidedTo(null);
                },
              ),
            ],
          ),
          h(24),
          Text(
            "Winner decided to?",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          h(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              actionSelectionCard(
                label: "Kick-Off",
                image: 'assets/images/kickOff.png',
                isSelected: context.watch<StartMatchVM>().winnerDecidedTo == "Kick-Off",
                onTap: () {
                  if (context.read<StartMatchVM>().callerTeamId == null) {
                    showSnackBar(context, tr(LocaleKeys.please_select_caller_first));
                    return;
                  } else if (context.read<StartMatchVM>().tossWonTeamId == null) {
                    showSnackBar(context, tr(LocaleKeys.please_select_team_won_toss));
                    return;
                  }
                  context.read<StartMatchVM>().changeWinnerDecidedTo("Kick-Off");
                },
              ),
              w(12),
              actionSelectionCard(
                label: "Defence",
                image: 'assets/images/defender.png',
                isSelected: context.watch<StartMatchVM>().winnerDecidedTo == "Defence",
                onTap: () {
                  if (context.read<StartMatchVM>().callerTeamId == null) {
                    showSnackBar(context, tr(LocaleKeys.please_select_caller_first));
                    return;
                  } else if (context.read<StartMatchVM>().tossWonTeamId == null) {
                    showSnackBar(context, tr(LocaleKeys.please_select_team_won_toss));
                    return;
                  }
                  context.read<StartMatchVM>().changeWinnerDecidedTo("Defence");
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, top: 8),
        child: Row(
          children: [
            w(28),
            Expanded(
              child: customButtonForTournament(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectMatchOfficial(phone: widget.phone),
                    ),
                  );
                },
                title: "Select Scorer",
                isOutLine: true,
              ),
            ),
            w(28),
            Expanded(
              child: customButtonForTournament(
                title: "Start Scoring",
                isLoading: context.watch<StartMatchVM>().isLoadingCreateMatch,
                onTap: () async {
                  context
                      .read<StartMatchVM>()
                      .createMatch(
                        selectedTournament: context.read<TournamentProvider>().selectedTournament!,
                        phone: widget.phone,
                      )
                      .then(
                    (value) {
                      if (value == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CreateMatchSuccessPage(isStartScoring: true),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            w(28),
          ],
        ),
      ),
    );
  }

  Widget teamSelectionCard({
    required TeamModel? team,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: sizer(context, 0.175),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? TColor.msgbck : Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  team?.logo ?? "",
                  height: 90,
                  width: 90,
                  loadingBuilder:
                      (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/images/app_logo.png',
                    height: 90,
                    width: 90,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 9),
            Text(
              team?.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : const Color(0xFF575757),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget actionSelectionCard({
    required String label,
    required String image,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: sizer(context, 0.175),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? TColor.msgbck : Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Image.asset(
              image,
              height: 90,
              width: 90,
              color: isSelected ? TColor.white : null,
            ),
            const SizedBox(height: 9),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : const Color(0xFF575757),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
