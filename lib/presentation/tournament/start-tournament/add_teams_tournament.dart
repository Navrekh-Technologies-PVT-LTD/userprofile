import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/core/extension.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/search_team_widget.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/team_card_widget.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

@RoutePage()
class AddTeamsToTournamentScreen extends StatefulWidget {
  const AddTeamsToTournamentScreen({
    super.key,
    required this.phone,
    required this.tournamentId,
    required this.numberofteams,
    required this.tournamentData,
  });

  final String phone;
  final String tournamentId;
  final String numberofteams;
  final TournamentData tournamentData;

  @override
  State<AddTeamsToTournamentScreen> createState() =>
      _AddTeamsToTournamentScreenState();
}

class _AddTeamsToTournamentScreenState
    extends State<AddTeamsToTournamentScreen> {
  @override
  void initState() {
    super.initState();
    final data = widget.tournamentData.teams;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<TournamentProvider>(context, listen: false)
          .getAllTeams(data!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentProvider>(
      builder: (context, tournamentState, _) {
        return Scaffold(
          backgroundColor: TColor.kBGcolors,
          bottomNavigationBar: Container(
            color: const Color.fromARGB(255, 235, 235, 240),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
                  .copyWith(top: 8),
              child: ElevatedButton(
                onPressed: () {
                  if (tournamentState.isLoadingAddTeams) {
                    return;
                  }
                  tournamentState.addTeamToTournament(
                      context, widget.tournamentId);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xff554585)),
                child: tournamentState.isLoadingAddTeams
                    ? loadingWidgetForBtn()
                    : const Text(
                        "Save Changes",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonContainer(
                height: 130.h,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 10.0,
                    spreadRadius: 2,
                    offset: const Offset(0.0, 0.75),
                  )
                ],
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 21.w, bottom: 10.h, right: 21.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              context.popBack();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: TColor.greyText,
                            ),
                          ),
                          SizedBox(width: 7.25.w),
                          Text(
                            "Add Teams to Tournament",
                            style: subHeadingStyle,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      SearchTeamWidget(
                        tournamentState: tournamentState,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: tournamentState.isLoadingGetAllTeam
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: tournamentState.finalTeamList.length,
                        itemBuilder: (context, index) {
                          final data = tournamentState.finalTeamList[index];
                          bool isAdded = false;

                          for (var element
                              in tournamentState.selectedTeamList) {
                            if (element.id == data.id) {
                              isAdded = true;
                              break;
                            }
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: TeamCardWidget(
                              team: data,
                              isAdded: isAdded,
                              onTapAdd: () {
                                tournamentState.addTeamToSelectedTeamList(
                                    widget.numberofteams, data);
                              },
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
