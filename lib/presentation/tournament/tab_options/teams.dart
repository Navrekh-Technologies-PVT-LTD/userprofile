import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/presentation/tournament/group_team/group_team_view_page.dart';
import 'package:yoursportz/presentation/tournament/group_team/group_teams.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/routing/app_router.gr.dart';
import 'package:yoursportz/utils/toast.dart';

class Teams extends StatefulWidget {
  const Teams({super.key, required this.tournament});

  final TournamentData tournament;

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      width: MediaQuery.sizeOf(context).width,
      color: Colors.white.withOpacity(0.40),
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(8.r),
      child: widget.tournament.teams!.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Teams Added",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 16),
                    child: Text(
                      "Please add teams first to get started",
                      style: GoogleFonts.inter(color: Colors.black54),
                    ),
                  ),
                  CommonContainer(
                    onTap: () {
                      context.navigateTo(
                        AddTeamsToTournamentRoute(
                            phone: widget.tournament.phone!,
                            tournamentId: widget.tournament.tournamentId!,
                            numberofteams: widget.tournament.numberOfTeams!,
                            tournamentData: widget.tournament),
                      );
                    },
                    height: 35.h,
                    width: 226.w,
                    color: const Color(0xff554585),
                    borderRadius: BorderRadius.circular(8.r),
                    child: Center(
                      child: Text(
                        "Add Teams",
                        style: GoogleFonts.inter(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
                  child: ListView.builder(
                    itemCount: widget.tournament.teams!.length,
                    itemBuilder: (context, index) {
                      final team = widget.tournament.teams![index];
                      return TeamCard(
                        teamLogo: team.logo!,
                        teamName: team.name!,
                        city: team.city!,
                      );
                    },
                  ),
                ),
                Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.navigateTo(
                                  AddTeamsToTournamentRoute(
                                      phone: widget.tournament.phone!,
                                      tournamentId:
                                          widget.tournament.tournamentId!,
                                      numberofteams:
                                          widget.tournament.numberOfTeams!,
                                      tournamentData: widget.tournament),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 235, 235, 245)),
                              child: Center(
                                child: Text(
                                  "Add Teams",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xff554585),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (widget.tournament.teams!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "No teams added to tournament yet."),
                                          backgroundColor: Colors.red));
                                } else if (widget.tournament.teams!.length <
                                    int.parse(
                                        widget.tournament.numberOfTeams!)) {
                                  showToast("You Need to add ${widget.tournament.numberOfTeams} Team For Crate Groups", Colors.red);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: ((context) => GroupTeamsPartially(
                                  //         phone: widget.tournament.phone!,
                                  //         tournamentId:
                                  //             widget.tournament.tournamentId!,
                                  //         teams: widget.tournament.teams!,
                                  //         numberOfTeams:
                                  //             widget.tournament.numberOfTeams!,
                                  //         numberOfGroups:
                                  //             widget.tournament.numberOfGroups!)),
                                  //   ),
                                  // );
                                } else if ((widget.tournament.groupedTeams ??
                                            [])
                                        .isNotEmpty &&
                                    (widget.tournament.groupedTeams ?? [])
                                        .first
                                        .isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          const GroupTeamViewPage()),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          const GroupTeams()),
                                    ),
                                    // MaterialPageRoute(
                                    //   builder: ((context) => GroupTeams2(
                                    //         phone: widget.tournament.phone!,
                                    //         tournamentId:
                                    //             widget.tournament.tournamentId!,
                                    //         teams: widget.tournament.teams!,
                                    //         numberOfTeams:
                                    //             widget.tournament.numberOfTeams!,
                                    //         numberOfGroups:
                                    //             widget.tournament.numberOfGroups!,
                                    //         GroupTeamsapi:
                                    //             widget.tournament.groupedTeams!,
                                    //       )),
                                    // ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: const Color(0xff554585)),
                              child: const Text(
                                "Group Teams",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
    );
  }
}

class TeamCard extends StatelessWidget {
  const TeamCard(
      {super.key,
      required this.teamLogo,
      required this.teamName,
      required this.city});

  final String teamLogo;
  final String teamName;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                  teamLogo,
                  height: 50,
                  width: 50,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/images/app_logo.png',
                      height: 50,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    teamName.length <= 15
                        ? teamName
                        : teamName.substring(0, 15),
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500, fontSize: 17)),
                Text(
                  city.length <= 15 ? city : city.substring(0, 15),
                  style: GoogleFonts.inter(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
