// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class TournamentRulesScreen extends StatefulWidget {
  const TournamentRulesScreen({
    super.key,
    required this.phone,
    required this.tournamentId,
    required this.numberofteams,
  });

  final String phone;
  final String tournamentId;
  final String numberofteams;

  @override
  State<TournamentRulesScreen> createState() => _TournamentRulesScreenState();
}

class _TournamentRulesScreenState extends State<TournamentRulesScreen> {
  var extraTime = false;
  var penaltyKicks = false;
  var goldenGoal = false;
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: GestureDetector(
          onTap: () {
            print("fwsfgwfgfgqa--${widget.tournamentId}");
            print("number of teams --${widget.numberofteams}");
          },
          child: Text(
            'Match Rules',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        titleSpacing:
            -8, // This removes the space between the title and the leading icon
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 65),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Choose rules for the match",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF575757),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          extraTime = !extraTime;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 1.0, // Border width
                          ),
                          color: extraTime
                              ? const Color.fromARGB(255, 107, 89, 161)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                Icon(
                                    extraTime
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: extraTime
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 107, 89, 161)),
                              ],
                            ),
                            Icon(Icons.timer,
                                size: 100,
                                color: extraTime
                                    ? Colors.white
                                    : const Color.fromARGB(255, 107, 89, 161)),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Extra Time',
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: extraTime
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 107, 89, 161),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          penaltyKicks = !penaltyKicks;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 1.0, // Border width
                          ),
                          color: penaltyKicks
                              ? const Color.fromARGB(255, 107, 89, 161)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                Icon(
                                    penaltyKicks
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: penaltyKicks
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 107, 89, 161)),
                              ],
                            ),
                            Icon(Icons.sports_gymnastics,
                                size: 100,
                                color: penaltyKicks
                                    ? Colors.white
                                    : const Color.fromARGB(255, 107, 89, 161)),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Penalty Kicks',
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: penaltyKicks
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 107, 89, 161),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          goldenGoal = !goldenGoal;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 1.0, // Border width
                          ),
                          color: goldenGoal
                              ? const Color.fromARGB(255, 107, 89, 161)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                Icon(
                                    goldenGoal
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: goldenGoal
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 107, 89, 161)),
                              ],
                            ),
                            Icon(Icons.sports_soccer,
                                size: 100,
                                color: goldenGoal
                                    ? Colors.white
                                    : const Color.fromARGB(255, 107, 89, 161)),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Golden Goal',
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: goldenGoal
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 107, 89, 161),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const Spacer(),
              Container(
                color: const Color.fromARGB(255, 235, 235, 245),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final body = jsonEncode(<String, dynamic>{
                              'tournamentId': widget.tournamentId,
                              'tournamentRulesScreen': {
                                'extraTime': extraTime,
                                'penaltyKicks': penaltyKicks,
                                'goldenGoal': goldenGoal
                              }
                            });
                            final response = await http.post(
                                Uri.parse(
                                    "https://yoursportzbackend.azurewebsites.net/api/tournament/add-rules/"),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: body);
                            final Map<String, dynamic> responseData =
                                jsonDecode(response.body);
                            if (responseData['message'] == "success") {
                              setState(() {
                                isLoading = true;
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) => AddTeams(
                              //               phone: widget.phone,
                              //               tournamentId: widget.tournamentId,
                              //               numberofteams: widget.numberofteams,
                              //             ))));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Row(
                                        children: [
                                          Text(
                                              "Tournament Rules Added Successfully",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          SizedBox(width: 8),
                                          Icon(Icons.done_all,
                                              color: Colors.white)
                                        ],
                                      ),
                                      backgroundColor: Colors.green));
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Server Error. Failed to add rules !!!",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3)));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: const Color(0xff554585)),
                          child: isLoading
                              ? Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Transform.scale(
                                    scale: 0.5,
                                    child: const CircularProgressIndicator(
                                        color: Colors.white),
                                  ))
                              : const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text("Done",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
