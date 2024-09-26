import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/presentation/tournament/tab_options/about.dart';
import 'package:yoursportz/presentation/tournament/tab_options/gallery.dart';
import 'package:yoursportz/presentation/tournament/tab_options/matches.dart';
import 'package:yoursportz/presentation/tournament/tab_options/points_table.dart';
import 'package:yoursportz/presentation/tournament/tab_options/teams.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

class Standings extends StatefulWidget {
  const Standings({super.key, required this.tournamentData, required this.phone});

  final TournamentData tournamentData;
  final String phone;

  @override
  State<Standings> createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  // late TournamentData tournament;
  String selectedTab = "About";
  List<String> tabsList = ["About", "Teams", "Matches", "Points Table", "Gallery"];

  @override
  void initState() {
    super.initState();
    // tournament = widget.tournamentData;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<TournamentProvider>().setSelectedTournament(widget.tournamentData);
        context.read<TournamentProvider>().onInitTournamentDetailsPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TournamentData? tournament = context.watch<TournamentProvider>().selectedTournament;

    if (tournament == null) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'Standings',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        titleSpacing: -8,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/tournament_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.network(
                        tournament.logoUrl!,
                        height: 60.h,
                        width: 60.w,
                        fit: BoxFit.cover,
                        loadingBuilder:
                            (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder:
                            (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/images/app_logo.png',
                            height: 60,
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tournament.tournamentName!,
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          tournament.city!,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                              color: const Color(0xFF575757),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: List.generate(
                    tabsList.length,
                    (index) {
                      final value = tabsList[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedTab = value;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: selectedTab == value ? const Color(0xff554585) : Colors.white,
                              border: Border.all(
                                width: 0.33.w,
                                color: TColor.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min, // Add this line to make Row take minimum width
                              children: [
                                Text(
                                  value,
                                  style: subHeadingStyle.copyWith(
                                    fontSize: 10.sp,
                                    color: selectedTab == value ? Colors.white : TColor.greyText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (selectedTab == "About")
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                    child: About(tournament: tournament),
                  ),
                )
              else if (selectedTab == "Teams")
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                    child: Teams(tournament: tournament),
                  ),
                )
              else if (selectedTab == "Matches")
                MatchesData(
                  tournament: tournament,
                  phone: widget.phone,
                )
              else if (selectedTab == "Points Table")
                const Expanded(child: PointsTableTab())
              else if (selectedTab == "Gallery")
                Expanded(child: Gallery(tournament: tournament))
            ],
          ),
        ],
      ),
    );
  }
}
