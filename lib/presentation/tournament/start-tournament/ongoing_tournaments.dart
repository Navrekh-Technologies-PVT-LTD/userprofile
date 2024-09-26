// ignore_for_file: avoid_unnecessary_containers

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/core/extension.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/search_tournament_widget.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/tournament_card_widget.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/routing/app_router.gr.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/text_styles.dart';

@RoutePage()
class OngoingTournamentScreen extends StatefulWidget {
  const OngoingTournamentScreen({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  State<OngoingTournamentScreen> createState() =>
      _OngoingTournamentScreenState();
}

class _OngoingTournamentScreenState extends State<OngoingTournamentScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<TournamentProvider>(context, listen: false)
          .getTournamentsList(widget.phone);
    });
    super.initState();
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
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.navigateTo(
                            CreateTournamentRoute(phone: widget.phone));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: const Color(0xff554585)),
                      child: const Text(
                        "Create Tournament",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonContainer(
                height: tournamentState.allTournaments.isEmpty ? 81.h : 130.h,
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
                            "Tournaments",
                            style: subHeadingStyle,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      tournamentState.allTournaments.isEmpty
                          ? const SizedBox.shrink()
                          : SearchTournamentWidget(
                              tournamentState: tournamentState,
                            ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child:
                    tournamentState.tournamentStates == TournamentState.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : tournamentState.allTournaments.isEmpty
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "No Tournaments",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "You don't have any ongoing or upcoming tournament. To start a tournament, please create one.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                children: [
                                  SizedBox(height: 20.h),
                                  Text(
                                    "Tournaments Around You",
                                    style: subHeadingStyle,
                                  ),
                                  SizedBox(height: 15.h),
                                  ...List.generate(
                                    tournamentState.allTournaments.length,
                                    (index) {
                                      final data =
                                          tournamentState.allTournaments[index];
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: TournamentCardWidget(data: data),
                                      );
                                    },
                                  ),
                                ],
                              ),
              )
            ],
          ),
        );
      },
    );
  }
}
