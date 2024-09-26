import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoursportz/presentation/profile/my_profile_awards_fragment.dart';
import 'package:yoursportz/presentation/profile/my_profile_gallery_fragment.dart';
import 'package:yoursportz/presentation/profile/my_profile_highlights_fragment.dart';
import 'package:yoursportz/presentation/profile/my_profile_matches_fragment.dart';
import 'package:yoursportz/presentation/profile/public_profile_stats_fragment.dart';
import 'package:yoursportz/presentation/profile/public_profile_teams_fragment.dart';
import 'package:yoursportz/presentation/widgets/public_profile_appbar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:yoursportz/presentation/widgets/user_profile_item.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';
import 'package:yoursportz/utils/color.dart';

@RoutePage()
class ViewPublicProfile extends StatefulWidget {
  final String phone;
  const ViewPublicProfile({required this.phone, super.key});

  @override
  _ViewPublicProfileState createState() => _ViewPublicProfileState();
}

class _ViewPublicProfileState extends State<ViewPublicProfile> {
  int primaryTypeSelectedItem = 0;
  late Future<Map<String, dynamic>> userDetailsFuture;
  Map<String, dynamic>? _fetchedData; // Store fetched data

  @override
  void initState() {
    super.initState();
    userDetailsFuture = getUserDetails(widget.phone);
    _fetchData();
  }

  Future<Map<String, dynamic>> getUserDetails(String phone) async {
    try {
      final body = jsonEncode({'phone': phone});
      final response = await http.post(
        Uri.parse(
            "https://yoursportzbackend.azurewebsites.net/api/auth/get-user/"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  void _fetchData() async {
    try {
      _fetchedData = await AppBaseProvider().getMyProfileStats(widget.phone);
      setState(() {});
    } catch (e) {
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: userDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: Text("Error loading profile")));
        }
        if (!snapshot.hasData) {
          return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: Text("No data available")));
        }

        return Scaffold(
          appBar: AppBar(
            leadingWidth: 0,
            elevation: 6,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            foregroundColor: Colors.white,
            scrolledUnderElevation: 0,
            toolbarHeight: 300,
            backgroundColor: Colors.white,
            title: PublicProfileAppbarWidget(data: snapshot.data!),
          ),
          body: _fetchedData != null
              ? Container(
                  color: myProfileBackground,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      _buildTabBar(),
                      const SizedBox(height: 12),
                      Expanded(
                        child: IndexedStack(
                          index: primaryTypeSelectedItem,
                          children: [
                            MyProfileMatchesFragment(
                              data: _fetchedData!,
                            ),
                            PublicProfileStatsFragment(data: _fetchedData!),
                            const MyProfileHighlightsFragment(),
                            const MyProfileAwardsFragment(),
                            PublicProfileTeamsFragment(data: _fetchedData!),
                            const MyProfileGalleryFragment(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildTabBar() {
    final tabs = [
      "Matches",
      "Stats",
      "Highlights",
      "Awards",
      "Teams",
      "Gallery"
    ];

    return SizedBox(
      height: 21.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: UserProfileItem(
              title: tabs[index],
              isSelected: primaryTypeSelectedItem == index,
              onTap: () {
                setState(() {
                  primaryTypeSelectedItem = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
