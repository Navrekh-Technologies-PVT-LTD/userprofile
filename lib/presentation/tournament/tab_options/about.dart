import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/routing/app_router.gr.dart';
import 'package:yoursportz/utils/color.dart';

class About extends StatelessWidget {
  const About({super.key, required this.tournament});

  final TournamentData tournament;

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentProvider>(
      builder: (context, tournamentState, _) {
        return CommonContainer(
          width: MediaQuery.sizeOf(context).width,
          color: Colors.white.withOpacity(0.40),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8.r),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        tournamentState.updateEditTournamentValue(
                          tournament.logoUrl!,
                          tournament.bannerUrl!,
                          tournament.tournamentName!,
                          tournament.organizerName!,
                          tournament.organizerPhone!,
                          tournament.city!,
                          tournament.groundNames!.first,
                          tournament.numberOfTeams!,
                          tournament.numberOfGroups!,
                          tournament.startDate!,
                          tournament.endDate!,
                          tournament.gameTime!,
                          tournament.firstHalf!,
                          tournament.additionalDetails!,
                        );
                        AutoRouter.of(context)
                            .push(
                          CreateTournamentRoute(
                            phone: tournament.phone!.split('91').last,
                            isEdit: true,
                            tournamentId: tournament.tournamentId,
                          ),
                        )
                            .then(
                          (value) {
                            if (value is TournamentData) {
                              context
                                  .read<TournamentProvider>()
                                  .setSelectedTournament(value);
                            }
                          },
                        );
                      },
                      child: Container(
                        width: 71.h,
                        height: 31.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: TColor.borderColor,
                            width: 0.33.w,
                          ),
                          borderRadius: BorderRadius.circular(5.0.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Edit",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF575757),
                              ),
                            ),
                            const Icon(Icons.edit_note,
                                color: Color(0xFF575757)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    buildRow(
                      leftText: "Organizer Name",
                      rightText: "Organizer Contact      ",
                      leftController: tournament.organizerName!,
                      rightController: tournament.organizerPhone!,
                    ),
                    SizedBox(height: 17.h),
                    buildRow(
                      leftText: "Number Of Teams",
                      rightText: "Number Of Groups     ",
                      leftController: tournament.numberOfTeams!,
                      rightController: tournament.numberOfGroups!,
                    ),
                    SizedBox(height: 17.h),
                    buildRow(
                      leftText: "Tournament Start Date",
                      rightText: "Tournament End Date ",
                      leftController: tournament.startDate!,
                      rightController: tournament.endDate! == "null"
                          ? "No Date"
                          : tournament.endDate!,
                    ),
                    SizedBox(height: 17.h),
                    buildRow(
                      leftText: "Match Duration",
                      rightText: "Tournament Category",
                      leftController: tournament.gameTime!,
                      rightController: tournament.tournamentCategory!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildRow({
    required String leftText,
    required String rightText,
    required String leftController,
    required String rightController,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leftText,
              style: GoogleFonts.inter(
                color: Colors.black54,
                fontSize: 12.0,
              ),
            ),
            Text(
              leftController,
              style: GoogleFonts.inter(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rightText,
              style: GoogleFonts.inter(
                color: Colors.black54,
                fontSize: 12.0,
              ),
            ),
            Text(
              rightController,
              style: GoogleFonts.inter(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
