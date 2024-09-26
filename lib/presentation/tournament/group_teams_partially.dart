import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';

class GroupTeamsPartially extends StatefulWidget {
  const GroupTeamsPartially(
      {super.key,
      required this.phone,
      required this.tournamentId,
      required this.teams,
      required this.numberOfTeams,
      required this.numberOfGroups});

  final String phone;
  final String tournamentId;
  final List<TeamModel> teams;
  final String numberOfTeams;
  final String numberOfGroups;

  @override
  State<GroupTeamsPartially> createState() => _GroupTeamsPartiallyState();
}

class _GroupTeamsPartiallyState extends State<GroupTeamsPartially> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 240, 245),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: Text(
            'Group Teams',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.white,
          titleSpacing: -8, // This removes the space between the title and the leading icon
        ),
        body: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF7A7A7A), width: 1.2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    ///text
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Type team name',
                      hintStyle: GoogleFonts.inter(color: const Color(0xFF7A7A7A)),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF7A7A7A)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
