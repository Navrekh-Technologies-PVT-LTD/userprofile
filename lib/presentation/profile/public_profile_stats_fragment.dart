import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoursportz/presentation/profile/public_profile_last5_player.dart';
import 'package:yoursportz/presentation/profile/public_profile_overall_player.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/presentation/widgets/player_performance_item.dart';
import 'package:yoursportz/presentation/widgets/public_profile_stats_card.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';
import 'package:yoursportz/utils/color.dart';

class PublicProfileStatsFragment extends StatefulWidget {
  final Map<String, dynamic> data;
  const PublicProfileStatsFragment({required this.data, super.key});

  @override
  State<PublicProfileStatsFragment> createState() =>
      _PublicProfileStatsFragmentState();
}

class _PublicProfileStatsFragmentState
    extends State<PublicProfileStatsFragment> {
  int matchTypeSelectedItem = 0;
  int playerTypeSelectedItem = 0;
  // Map<String, dynamic>? _fetchedData; // Store fetched data

  // @override
  // void initState() {
  //   super.initState();
  //   // Fetch data on initial load
  //   _fetchData();
  // }

  // void _fetchData() async {
  //   _fetchedData = await AppBaseProvider().getMyProfileStats(widget.phone);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: CommonContainer(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 7, right: 7, top: 6, bottom: 6),
                border: Border.all(color: TColor.borderColor, width: 0.33),
                borderRadius: BorderRadius.circular(24),
                child: Row(
                  children: [
                    Flexible(
                      child: PlayerPerformanceItem(
                        title: "Last 5 Matches",
                        isSelected: matchTypeSelectedItem == 0 ? true : false,
                        onTap: () {
                          setState(() {
                            matchTypeSelectedItem = 0;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: PlayerPerformanceItem(
                        title: "Overall Matches",
                        isSelected: matchTypeSelectedItem == 1 ? true : false,
                        onTap: () {
                          setState(() {
                            matchTypeSelectedItem = 1;
                          });
                        },
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: CommonContainer(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 7, right: 7, top: 6, bottom: 6),
                border: Border.all(color: TColor.borderColor, width: 0.33),
                borderRadius: BorderRadius.circular(24),
                child: Row(
                  children: [
                    Flexible(
                      child: PlayerPerformanceItem(
                        title: "Player",
                        isSelected: playerTypeSelectedItem == 0 ? true : false,
                        onTap: () {
                          setState(() {
                            playerTypeSelectedItem = 0;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: PlayerPerformanceItem(
                        title: "Goal Keeper",
                        isSelected: playerTypeSelectedItem == 1 ? true : false,
                        onTap: () {
                          setState(() {
                            playerTypeSelectedItem = 1;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: PlayerPerformanceItem(
                        title: "Referee",
                        isSelected: playerTypeSelectedItem == 2 ? true : false,
                        onTap: () {
                          setState(() {
                            playerTypeSelectedItem = 2;
                          });
                        },
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(
            height: 4,
          ),
          Expanded(
            child: IndexedStack(
              index: matchTypeSelectedItem,
              children: [
                //LAST 5 MATCHCES
                IndexedStack(
                  index: playerTypeSelectedItem,
                  children: [
                    PublicProfileLast5Player(data: widget.data),
                    const Center(child: Text("Coming soon for Goal Keeper")),
                    const Center(child: Text("Coming soon for Referee")),
                  ],
                ),
                IndexedStack(
                  index: playerTypeSelectedItem,
                  children: [
                    PublicProfileOverallPlayer(data: widget.data),
                    const Center(child: Text("Coming soon for Goal Keeper")),
                    const Center(child: Text("Coming soon for Referee")),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
