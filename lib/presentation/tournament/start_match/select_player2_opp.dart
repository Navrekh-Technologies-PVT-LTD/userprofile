import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/core/constants.dart';
import 'package:yoursportz/presentation/tournament/start_match/selected_team_view.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/toast.dart';

import '../../widgets/custom_btn.dart';
import 'select_player2.dart';

class SelectPlayer2opp extends StatefulWidget {
  const SelectPlayer2opp({
    super.key,
    required this.phone,
  });
  final String phone;

  @override
  State<SelectPlayer2opp> createState() => _SelectPlayer2oppState();
}

class _SelectPlayer2oppState extends State<SelectPlayer2opp> {
  final Dio _dio = Dio();

  Future<void> updatePlayerPositions() async {
    try {
      final response = await _dio.post(
        'https://yoursportzbackend.azurewebsites.net/api/team/update-team-players',
        data: {
          'teamId': context.read<StartMatchVM>().opponentTeam?.teamId,
          'players': (context.read<StartMatchVM>().opponentTeam?.players ?? [])
              .map((e) => e.toJson())
              .toList(),
        },
      );

      if (response.statusCode == 200) {
        // Handle successful update
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Player positions updated successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to update player positions');
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating player positions: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.kBGcolors,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Select players for : ',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: context.watch<StartMatchVM>().opponentTeam?.name,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        titleSpacing: -8,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 153,
              ),
              itemCount: (context.watch<StartMatchVM>().opponentTeam?.players ?? []).length,
              itemBuilder: (context, index) {
                final player = (context.watch<StartMatchVM>().opponentTeam?.players ?? [])[index];

                bool isSelected = context
                    .watch<StartMatchVM>()
                    .opponentSelectedPlayerIdList
                    .contains(player.id ?? "");

                return GridItem(
                  name: player.name ?? "",
                  city: player.city ?? "",
                  position: player.position ?? "",
                  imageUrl: player.dp,
                  positions: footballPlayerPositionList,
                  isSelected: isSelected,
                  onSelected: (value) {
                    context.read<StartMatchVM>().onSelectOpponentPlayer(player.id ?? "");
                  },
                  onPositionChanged: (newPosition) {
                    context.read<StartMatchVM>().onChangeOpponentTeamPlayerPosition(
                        playerId: player.id ?? "", position: newPosition);
                  },
                );
              },
            ),
          ),
          customButtonForTournament(
            title: "Next",
            onTap: () async {
              if (!context.read<StartMatchVM>().checkOpponentTeamSelectedPlayerHaveGoalKeeper()) {
                showToast('You must select at least one goalkeeper.', Colors.red);
                return;
              }
              if (context.read<StartMatchVM>().opponentSelectedPlayerIdList.length !=
                  (context.read<StartMatchVM>().selectedNumberOfPlayer ?? 0)) {
                showToast(
                    'You must select ${context.read<StartMatchVM>().selectedNumberOfPlayer} Players.',
                    Colors.red);
                return;
              }
              // Update player positions
              updatePlayerPositions();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectedTeamViewPage(phone: widget.phone),
                ),
              );
            },
            margin: const EdgeInsets.all(16).copyWith(top: 8),
          ),
        ],
      ),
    );
  }
}
