import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:yoursportz/domain/tournament/tournament_matches_model.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/presentation/tournament/schedule_match.dart';
import 'package:yoursportz/presentation/tournament/start_match/start_match.dart';

class MatchesData extends StatefulWidget {
  const MatchesData({super.key, required this.tournament, required this.phone});

  final TournamentData tournament;
  final String phone;

  @override
  State<MatchesData> createState() => _MatchesDataState();
}

class _MatchesDataState extends State<MatchesData> {
  var selectedGroup = "Group A";
  var selectedMatchType = "Live";
  bool isLoading = true;
  bool hasError = false;
  List<MatchModel> matches = [];

  @override
  void initState() {
    super.initState();
    fetchMatchDetails(widget.tournament.tournamentId!);
  }

  String baseUrl = 'https://yoursportzbackend.azurewebsites.net/api/tournament/get-matches';
  Future<void> fetchMatchDetails(String tournamentId) async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    // try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{
        'tournamentId': tournamentId,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('Decoded JSON: $jsonResponse');

      if (jsonResponse is List && jsonResponse.isNotEmpty && jsonResponse[0] is List) {
        // final matchList = jsonResponse.expand((element) => element).toList();
        for (var element in jsonResponse) {
          matches = element.map<MatchModel>((data) {
            if (data is Map<String, dynamic>) {
              final date = data['date'] as String?;
              final time = data['time'] as String?;
              final matchDateTime = parseCustomDateTime(date, time);

              return MatchModel.fromJson({
                ...data,
                'dateTime': matchDateTime?.toIso8601String(), // Assuming you add a dateTime field
              });
            } else {
              throw Exception('Unexpected format of match data: $data');
            }
          }).toList();
        }
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        throw Exception('Expected a nested list format but got: $jsonResponse');
      }
    } else {
      throw Exception('Failed to load match details');
    }
    // } catch (e) {
    //   print('Error: $e');
    //   setState(() {
    //     isLoading = false;
    //     hasError = true;
    //   });
    // }
  }

  DateTime? parseCustomDateTime(String? date, String? time) {
    if (date == null || date.isEmpty || time == null || time.isEmpty) {
      print('Error: Date or time is null or empty');
      return null;
    }

    try {
      final dateParts = date.split('-');
      final timeParts = time.split(' ');
      final timePartsColon = timeParts[0].split(':');

      final year = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final day = int.parse(dateParts[2]);
      final hour = int.parse(timePartsColon[0]);
      final minute = int.parse(timePartsColon[1]);
      final amPm = timeParts.length > 1 ? timeParts[1].toUpperCase() : 'AM';

      final adjustedHour = (amPm == 'PM' && hour < 12)
          ? hour + 12
          : (amPm == 'AM' && hour == 12)
              ? 0
              : hour;

      return DateTime(year, month, day, adjustedHour, minute);
    } catch (e) {
      print('Error parsing date/time: $e');
      return null;
    }
  }

  String formatTime12Hour(DateTime dateTime) {
    final hour = dateTime.hour % 12;
    final hourFormatted = hour == 0 ? 12 : hour;
    final minuteFormatted = dateTime.minute.toString().padLeft(2, '0');
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$hourFormatted:$minuteFormatted $amPm';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final filteredMatches = matches.where((match) {
      try {
        final matchDateTime = parseCustomDateTime(match.date, match.time);

        switch (selectedMatchType) {
          case "Live":
            return match.groupName == selectedGroup &&
                matchDateTime!.isBefore(now) &&
                matchDateTime.add(const Duration(hours: 2)).isAfter(now);
          case "Upcoming":
            return match.groupName == selectedGroup && matchDateTime!.isAfter(now);
          case "Past":
            return match.groupName == selectedGroup && matchDateTime!.isBefore(now);
          default:
            return false;
        }
      } catch (e) {
        print('Error parsing date/time: $e');
        return false;
      }
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildMatchTypeSelector(),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.white,
                width: 1.1,
              ),
            ),
            child: Column(
              children: [
                _buildGroupSelector(),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : hasError
                        ? const Center(child: Text('Failed to load matches'))
                        : _buildMatchesList(filteredMatches),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartMatch(
                                tournament: widget.tournament,
                                phone: widget.phone,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            backgroundColor: const Color.fromARGB(255, 235, 235, 245)),
                        child: Text("Start Match",
                            style: GoogleFonts.inter(
                                color: const Color(0xff554585), fontWeight: FontWeight.w500)),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Schedule_match(
                                tournament: widget.tournament,
                                phone: widget.phone,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            backgroundColor: const Color(0xff554585)),
                        child: const Text(
                          "Schedule Match",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchTypeSelector() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ["Live", "Upcoming", "Past"].map((type) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMatchType = type;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedMatchType == type
                              ? const Color.fromARGB(255, 107, 89, 161)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(32.r)),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              type,
                              style: TextStyle(
                                color: selectedMatchType == type
                                    ? Colors.white
                                    : const Color.fromARGB(255, 107, 89, 161),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }

  Widget _buildGroupSelector() {
    // Calculate the number of groups
    int numberOfGroups = widget.tournament.groupedTeams?.length ?? 0;

    // Generate group names dynamically
    List<String> groupNames = List.generate(numberOfGroups, (index) {
      return 'Group ${String.fromCharCode(65 + index)}'; // 'A' is 65 in ASCII
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
        child: Row(
          children: groupNames.map((group) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedGroup = group;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 8.w), // Space between items
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selectedGroup == group
                      ? const Color.fromARGB(255, 107, 89, 161)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: Text(
                  group,
                  style: TextStyle(
                    color: selectedGroup == group
                        ? Colors.white
                        : const Color.fromARGB(255, 107, 89, 161),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMatchesList(List<MatchModel> filteredMatches) {
    if (filteredMatches.isEmpty) {
      return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25.h),
            Text(
              "No Matches Available!",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: const Color(0xFF3C3C3C),
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "You haven’t played or scheduled any match yet.\nStart or Schedule a match to get started",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold, fontSize: 12.sp, color: const Color(0xFF3C3C3C)),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.44,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredMatches.length,
        itemBuilder: (context, index) {
          final match = filteredMatches[index];
          final matchDateTime = parseCustomDateTime(match.date, match.time);
          final formattedDate =
              "${matchDateTime?.day}-${matchDateTime?.month}-${matchDateTime?.year}";
          final formattedTime = matchDateTime != null ? formatTime12Hour(matchDateTime) : 'N/A';

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(26, 70, 68, 68),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 50.r,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  match.teamALogo ?? "",
                                  height: 70.h,
                                  width: 70.h,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
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
                                  errorBuilder: (BuildContext context, Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(
                                      'assets/images/app_logo.png',
                                      height: 70.h,
                                      width: 70.w,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Text(match.teamA ?? ""),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/versus.png',
                              height: 70.h,
                              width: 70.w,
                            ),
                            const Text(" vs "),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 50.r,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  match.teamBLogo ?? "",
                                  height: 70.h,
                                  width: 70.w,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
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
                                  errorBuilder: (BuildContext context, Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(
                                      'assets/images/app_logo.png',
                                      height: 70.h,
                                      width: 70.w,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Text(match.teamB ?? ""),
                          ],
                        ),
                      ]),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: const Color.fromARGB(255, 107, 89, 161)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 4.w),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Match Venue: ${match.location}",
                                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                                  ),
                                  Text(
                                    "Match Date And Time: $formattedDate , $formattedTime",
                                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8), // Adjust the radius as needed
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Share',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 107, 89, 161),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
