import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/profile/my_profile_stats_fragment.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/presentation/widgets/my_profile_stats_card.dart';
import 'package:yoursportz/presentation/widgets/player_performance_appbar_widget.dart';
import 'package:yoursportz/presentation/widgets/player_performance_item.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';
import 'package:yoursportz/utils/color.dart';

class ShowMyPerformanceScreen extends StatefulWidget {
  final String phone;
  const ShowMyPerformanceScreen({required this.phone, super.key});

  @override
  State<ShowMyPerformanceScreen> createState() =>
      _ShowMyPerformanceScreenState();
}

class _ShowMyPerformanceScreenState extends State<ShowMyPerformanceScreen> {
  int selectedItem = 0;
  Map<String, dynamic>? _fetchedData; // Store fetched data

  @override
  Widget build(BuildContext context) {
    return Consumer<AppBaseProvider>(builder: (context, appBaseState, _) {
      return Scaffold(
        backgroundColor: myProfileBackground,
        appBar: AppBar(
          leadingWidth: 0,
          elevation: 6,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0,
          toolbarHeight: 300,
          backgroundColor: Colors.white,
          title: PlayerPerformaceAppBarWidget(phone: widget.phone),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: CommonContainer(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      left: 7, right: 7, top: 6, bottom: 6),
                  border: Border.all(color: TColor.borderColor, width: 0.33),
                  borderRadius: BorderRadius.circular(24),
                  child: Row(
                    children: [
                      Flexible(
                        child: PlayerPerformanceItem(
                          title: "Overall",
                          isSelected: selectedItem == 0 ? true : false,
                          onTap: () {
                            setState(() {
                              selectedItem = 0;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: PlayerPerformanceItem(
                          title: "Practice Match",
                          isSelected: selectedItem == 1 ? true : false,
                          onTap: () {
                            setState(() {
                              selectedItem = 1;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: PlayerPerformanceItem(
                          title: "Tournament",
                          isSelected: selectedItem == 2 ? true : false,
                          onTap: () {
                            setState(() {
                              selectedItem = 2;
                            });
                          },
                        ),
                      ),
                    ],
                  )),
            ),
            Expanded(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: _fetchedData != null
                  ? GridView.count(
                      crossAxisCount: 3,
                      children: [
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["Matches"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["MatchCount"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["MatchCount"] ??
                                      0,
                          statsTitle: "Matches",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["Goals"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["Goals"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["Goals"] ??
                                      0,
                          statsTitle: "Goals",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["GoldenGoals"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["GoldenGoals"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["GoldenGoals"] ??
                                      0,
                          statsTitle: "Golden Goals",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["ShotsOnGoal"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["ShotsOnGoal"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["ShotsOnGoal"] ??
                                      0,
                          statsTitle: "Shots On Target",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["ShotsOffGoal"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["ShotsOffGoal"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["ShotsOffGoal"] ??
                                      0,
                          statsTitle: "Shots Off Target",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["offside"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["offside"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["offside"] ??
                                      0,
                          statsTitle: "Offsides",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["red_card"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["red_card"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["red_card"] ??
                                      0,
                          statsTitle: "Red Cards",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["foul"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]?["foul"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["foul"] ??
                                      0,
                          statsTitle: "Fouls",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["Penalties"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["Penalties"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["Penalties"] ??
                                      0,
                          statsTitle: "Penalties",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["throw_in"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["throw_in"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["throw_in"] ??
                                      0,
                          statsTitle: "Throw-Ins",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["FreeKicks"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["FreeKicks"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["FreeKicks"] ??
                                      0,
                          statsTitle: "Freekicks",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["yellow_card"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["yellow_card"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["yellow_card"] ??
                                      0,
                          statsTitle: "Yellow Cards",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["CornerKicks"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["CornerKicks"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["CornerKicks"] ??
                                      0,
                          statsTitle: "Corners",
                        ),
                        MyProfileStatsCard(
                          statsTotal: selectedItem == 0
                              ? _fetchedData?["Overall"]?["Subtitutions"] ?? 0
                              : selectedItem == 1
                                  ? _fetchedData?["Practicematches"]
                                          ?["Subtitutions"] ??
                                      0
                                  : _fetchedData?["tournamentsDetails"]
                                          ?["Subtitutions"] ??
                                      0,
                          statsTitle: "Substitution",
                        ),
                      ],
                    )
                  : FutureBuilder(
                      future: AppBaseProvider()
                          .getMyProfileStats(appBaseState.userDetails["phone"]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasData) {
                          _fetchedData = snapshot.data; // Store fetched data
                          return GridView.count(
                            crossAxisCount: 3,
                            children: [
                              MyProfileStatsCard(
                                statsTotal:
                                    snapshot.data?["Overall"]?["Matches"] ?? 0,
                                statsTitle: "Matches",
                              ),
                              MyProfileStatsCard(
                                statsTotal:
                                    snapshot.data?["Overall"]?["Goals"] ?? 0,
                                statsTitle: "Goals",
                              ),
                              MyProfileStatsCard(
                                statsTotal: snapshot.data?["Overall"]
                                        ?["GoldenGoals"] ??
                                    0,
                                statsTitle: "GoldenGoals",
                              ),
                              MyProfileStatsCard(
                                statsTotal: snapshot.data?["Overall"]
                                        ?["ShotsOnGoal"] ??
                                    0,
                                statsTitle: "Shots On Target",
                              ),
                              MyProfileStatsCard(
                                statsTotal: snapshot.data?["Overall"]
                                        ?["ShotsOffGoal"] ??
                                    0,
                                statsTitle: "Shots Off Target",
                              ),
                              MyProfileStatsCard(
                                statsTotal:
                                    snapshot.data?["Overall"]?["offside"] ?? 0,
                                statsTitle: "Offsides",
                              ),
                              MyProfileStatsCard(
                                statsTotal:
                                    snapshot.data?["Overall"]?["red_card"] ?? 0,
                                statsTitle: "Red Cards",
                              ),
                              MyProfileStatsCard(
                                statsTotal:
                                    snapshot.data?["Overall"]?["foul"] ?? 0,
                                statsTitle: "Fouls",
                              ),
                              MyProfileStatsCard(
                                statsTotal: snapshot.data?["Overall"]
                                        ?["Subtitutions"] ??
                                    0,
                                statsTitle: "Subtitutions",
                              ),
                              MyProfileStatsCard(
                                statsTotal: snapshot.data?["Overall"]
                                        ?["Penalties"] ??
                                    0,
                                statsTitle: "Penalties",
                              ),
                              MyProfileStatsCard(
                                statsTotal:
                                    snapshot.data?["Overall"]?["throw_in"] ?? 0,
                                statsTitle: "Throw-Ins",
                              ),
                              MyProfileStatsCard(
                                statsTotal: snapshot.data?["Overall"]
                                        ?["FreeKicks"] ??
                                    0,
                                statsTitle: "Freekicks",
                              ),
                              MyProfileStatsCard(
                                statsTotal: snapshot.data?["Overall"]
                                        ?["yellow_card"] ??
                                    0,
                                statsTitle: "Yellow Cards",
                              ),
                              MyProfileStatsCard(
                                statsTotal: snapshot.data?["Overall"]
                                        ?["CornerKicks"] ??
                                    0,
                                statsTitle: "Corners",
                              ),
                            ],
                          );
                        }

                        return const Center(child: Text('Error fetching data'));
                      },
                    ),
            ))
          ],
        ),
      );
    });
  }
}
