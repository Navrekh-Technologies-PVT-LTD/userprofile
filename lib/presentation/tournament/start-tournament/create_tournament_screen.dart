import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/core/extension.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/add_banner_logo_container.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/match_duration_widget.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/numbers_of_team_and_groups_widget.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/tournament_category_widget.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/tournament_dates_widget.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/presentation/widgets/common_textfield.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';
import 'package:yoursportz/utils/toast.dart';

@RoutePage()
class CreateTournamentScreen extends StatefulWidget {
  final String phone;
  final String? tournamentId;
  final bool isEdit;
  const CreateTournamentScreen(
      {super.key, required this.phone, this.isEdit = false, this.tournamentId});

  @override
  State<CreateTournamentScreen> createState() => _CreateTournamentScreenState();
}

class _CreateTournamentScreenState extends State<CreateTournamentScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentProvider>(
      builder: (context, tournamentState, _) {
        return Scaffold(
          backgroundColor: TColor.kBGcolors,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonContainer(
                      height: 81.h,
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
                        padding: EdgeInsets.only(left: 21.w, bottom: 10.h),
                        child: Row(
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
                              widget.isEdit
                                  ? "Edit A Tournament"
                                  : "Add A Tournament",
                              style: subHeadingStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tournament Organizer",
                            style: headingStyle,
                          ),
                          SizedBox(height: 15.h),
                          AddBannerLogoContainer(
                              tournamentState: tournamentState,
                              isEdit: widget.isEdit),
                          SizedBox(height: 15.h),
                          Text(
                            "Tournament Name",
                            style: subHeadingStyle.copyWith(
                              fontSize: 12.sp,
                              color: TColor.greyText,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextFieldWidget(
                            hintText: "Enter Tournament Name",
                            controller:
                                tournamentState.tournamentNameController,
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "Organizer Name",
                            style: subHeadingStyle.copyWith(
                              fontSize: 12.sp,
                              color: TColor.greyText,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextFieldWidget(
                            hintText: "Enter Organizer Name",
                            controller: tournamentState.orgNameController,
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "Organizer Contact",
                            style: subHeadingStyle.copyWith(
                              fontSize: 12.sp,
                              color: TColor.greyText,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextFieldWidget(
                            hintText: "Enter Contact Number",
                            textInputType: TextInputType.phone,
                            controller: tournamentState.orgContactController,
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "Location",
                            style: subHeadingStyle.copyWith(
                              fontSize: 12.sp,
                              color: TColor.greyText,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextFieldWidget(
                            hintText: "Enter Location",
                            controller: tournamentState.locationController,
                            onChanged: (query) {
                              tournamentState.onTextChanged(query);
                            },
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "Ground Name(s)",
                            style: subHeadingStyle.copyWith(
                              fontSize: 12.sp,
                              color: TColor.greyText,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 302.w,
                                child: TextFieldWidget(
                                  hintText: "Enter Ground Name",
                                  controller:
                                      tournamentState.groundNameController,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.add_circle_outline,
                                color: TColor.borderColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          NumbersOfTeamAndGroupsWidget(
                              tournamentState: tournamentState),
                          SizedBox(height: 15.h),
                          Text(
                            "Tournament Dates",
                            style: headingStyle.copyWith(
                              fontSize: 14.sp,
                              color: TColor.greyText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          TournamentDatesWidget(
                              tournamentState: tournamentState),
                          SizedBox(height: 15.h),
                          Text(
                            "Match Duration",
                            style: headingStyle.copyWith(
                              fontSize: 14.sp,
                              color: TColor.greyText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          MatchDurationWidget(tournamentState: tournamentState),
                          SizedBox(height: 15.h),
                          Text(
                            "Tournament Category",
                            style: headingStyle.copyWith(
                              fontSize: 14.sp,
                              color: TColor.greyText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          TournamentCategoryWidget(
                              tournamentState: tournamentState),
                          SizedBox(height: 15.h),
                          Text(
                            "Add more details",
                            style: headingStyle.copyWith(
                              fontSize: 14.sp,
                              color: TColor.greyText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          TextFieldWidget(
                            hintText:
                                "Add more details like entry fee,prize money, awards, rules etc...",
                            controller:
                                tournamentState.addMoreDetailsController,
                          ),
                          SizedBox(height: 15.h),
                          CommonContainer(
                            height: 40.h,
                            onTap: tournamentState.tournamentStates ==
                                        TournamentState.loading ||
                                    tournamentState.isLoadingCreateTournament
                                ? null
                                : () {
                                    if (tournamentState.tournamentNameController
                                        .text.isEmpty) {
                                      showToast("Please add Tournament Name",
                                          Colors.red);
                                    } else if (tournamentState
                                        .orgNameController.text.isEmpty) {
                                      showToast("Please add Organizer Name",
                                          Colors.red);
                                    } else if (tournamentState
                                        .orgContactController.text.isEmpty) {
                                      showToast("Please add Organizer Contact",
                                          Colors.red);
                                    } else if (tournamentState
                                        .locationController.text.isEmpty) {
                                      showToast(
                                          "Please add Location", Colors.red);
                                    } else if (tournamentState
                                        .groundNameController.text.isEmpty) {
                                      showToast(
                                          "Please add Ground Name", Colors.red);
                                    } else if (tournamentState.endDate ==
                                        "End date") {
                                      showToast("Please select a End date",
                                          Colors.red);
                                    } else if (tournamentState.startDate ==
                                        "Start date") {
                                      showToast("Please select a Start Date",
                                          Colors.red);
                                    }

                                    /// Hide Logo and Banner Image Validation Here
                                    // else if (tournamentState.imagePath == "null") {
                                    //   showToast(
                                    //       "Please add a banner image", Colors.red);
                                    // } else if (tournamentState.bannerImagePath ==
                                    //     "null") {
                                    //   showToast(
                                    //       "Please add a logo image", Colors.red);
                                    // }
                                    else {
                                      widget.isEdit
                                          ? tournamentState
                                              .updateTournamentData(
                                                  widget.tournamentId!, context)
                                          : tournamentState.createTournament(
                                              context,
                                              widget.phone,
                                            );
                                    }
                                  },
                            width: MediaQuery.sizeOf(context).width,
                            color: const Color(0xff413566),
                            borderRadius: BorderRadius.circular(10.r),
                            child: Center(
                              child: tournamentState.tournamentStates ==
                                          TournamentState.loading ||
                                      tournamentState.isLoadingCreateTournament
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      !widget.isEdit
                                          ? "Create Tournament"
                                          : "Save changes",
                                      style: headingStyle.copyWith(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: 80.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (tournamentState.places.isNotEmpty)
                Positioned(
                  left: 0.w,
                  right: 0.w,
                  top: 170.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      height: 300.h,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(tournamentState.places[index]),
                            onTap: () {
                              tournamentState.locationController.text =
                                  tournamentState.places[index];
                              setState(() {
                                tournamentState.places = [];
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
