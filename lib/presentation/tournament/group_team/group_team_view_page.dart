import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/tournament/group_team/group_teams.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/team_card_widget.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';

class GroupTeamViewPage extends StatefulWidget {
  const GroupTeamViewPage({super.key});

  @override
  State<GroupTeamViewPage> createState() => _GroupTeamViewPageState();
}

class _GroupTeamViewPageState extends State<GroupTeamViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 245),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'Group Teams',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        titleSpacing: -8,
      ),
      body: buildUi(),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 235, 235, 240),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
              .copyWith(top: 8),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GroupTeams()));
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: const Color(0xff554585)),
            child: const Text(
              "Re Group Team",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildUi() {
    var groupTeams =
        context.watch<TournamentProvider>().selectedTournament?.groupedTeams ??
            [];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...groupTeams.map(
          (e) {
            int index = groupTeams.indexOf(e);

            if (e.isEmpty) {
              return const SizedBox();
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12)
                        .copyWith(top: 12),
                    child: Text(
                      // "Group ${index + 1}",
                      "Group ${String.fromCharCode(65 + index)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff554585),
                      ),
                    ),
                  ),
                  ...e.map(
                    (team) {
                      return TeamCardWidget(
                        team: team,
                        elevation: 0,
                      );
                    },
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
