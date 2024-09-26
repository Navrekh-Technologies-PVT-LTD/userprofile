import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/profile/my_profile_awards_fragment.dart';
import 'package:yoursportz/presentation/profile/my_profile_gallery_fragment.dart';
import 'package:yoursportz/presentation/profile/my_profile_highlights_fragment.dart';
import 'package:yoursportz/presentation/profile/my_profile_matches_fragment.dart';
import 'package:yoursportz/presentation/profile/my_profile_stats_fragment.dart';
import 'package:yoursportz/presentation/profile/my_profile_teams_fragment.dart';
import 'package:yoursportz/presentation/widgets/user_profile_item.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';
import 'package:yoursportz/utils/color.dart';

class UserProfileScreen extends StatefulWidget {
  final String phone;
  const UserProfileScreen({required this.phone, super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int selectedItem = 0;

  Map<String, dynamic>? _fetchedData; // Store fetched data

  void _fetchData() async {
    _fetchedData = await AppBaseProvider().getMyProfileStats(widget.phone);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myProfileBackground,
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 21.h, // Set a fixed height for the ListView portion
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: UserProfileItem(
                      title: "Matches",
                      isSelected: selectedItem == 0 ? true : false,
                      onTap: () {
                        setState(() {
                          selectedItem = 0;
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: UserProfileItem(
                      title: "Stats",
                      isSelected: selectedItem == 1 ? true : false,
                      onTap: () {
                        setState(() {
                          selectedItem = 1;
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: UserProfileItem(
                      title: "Highlights",
                      isSelected: selectedItem == 2 ? true : false,
                      onTap: () {
                        setState(() {
                          selectedItem = 2;
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: UserProfileItem(
                      title: "Awards",
                      isSelected: selectedItem == 3 ? true : false,
                      onTap: () {
                        setState(() {
                          selectedItem = 3;
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: UserProfileItem(
                      title: "Teams",
                      isSelected: selectedItem == 4 ? true : false,
                      onTap: () {
                        setState(() {
                          selectedItem = 4;
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: UserProfileItem(
                      title: "Gallery",
                      isSelected: selectedItem == 5 ? true : false,
                      onTap: () {
                        setState(() {
                          selectedItem = 5;
                        });
                      },
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          _fetchedData != null
              ? Expanded(
                  child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: IndexedStack(
                    index: selectedItem,
                    children: [
                      MyProfileMatchesFragment(
                        data: _fetchedData!,
                      ),
                      MyProfileStatsFragment(
                        data: _fetchedData!,
                      ),
                      const MyProfileHighlightsFragment(),
                      const MyProfileAwardsFragment(),
                      MyProfileTeamsFragment(
                        data: _fetchedData!,
                      ),
                      const MyProfileGalleryFragment(),
                    ],
                  ),
                ))
              : const Expanded(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
        ],
      ),
    );
  }
}
