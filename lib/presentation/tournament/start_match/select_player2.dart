import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/core/constants.dart';
import 'package:yoursportz/presentation/widgets/custom_btn.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';
import 'package:yoursportz/utils/toast.dart';

import 'select_player2_opp.dart';

class SelectPlayer2 extends StatefulWidget {
  const SelectPlayer2({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  State<SelectPlayer2> createState() => _SelectPlayer2State();
}

class _SelectPlayer2State extends State<SelectPlayer2> {
  final Dio _dio = Dio();

  Future<void> updatePlayerPositions() async {
    try {
      // Fetch the current players to keep unchanged data
      // final players = await fetchPlayers(widget.selectedHomeTeam?['teamId']);
      //
      // // Prepare the players data with updated positions
      // final updatedPlayers = players.map((player) {
      //   final playerId = player['id']!;
      //   if (_changedPositions.containsKey(playerId)) {
      //     return {
      //       'name': player['name']!,
      //       'phone': player['phone']!,
      //       'city': player['city']!,
      //       'position': _changedPositions[playerId]!,
      //       'dp': player['dp']!,
      //       '_id': player['id']!,
      //     };
      //   }
      //   return player;
      // }).toList();

      // Call the API to update player positions
      final response = await _dio.post(
        'https://yoursportzbackend.azurewebsites.net/api/team/update-team-players',
        data: {
          'teamId': context.read<StartMatchVM>().homeTeam?.teamId,
          'players': (context.read<StartMatchVM>().homeTeam?.players ?? [])
              .map((e) => e.toJson())
              .toList(),
        },
      );

      if (response.statusCode == 200) {
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
                text: context.watch<StartMatchVM>().homeTeam?.name,
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
              itemCount: (context.watch<StartMatchVM>().homeTeam?.players ?? []).length,
              itemBuilder: (context, index) {
                final player = (context.watch<StartMatchVM>().homeTeam?.players ?? [])[index];

                bool isSelected =
                    context.watch<StartMatchVM>().homeSelectedPlayerIdList.contains(player.id);

                return GridItem(
                  name: player.name ?? "",
                  city: player.city ?? "",
                  position: player.position ?? "",
                  imageUrl: player.dp,
                  positions: footballPlayerPositionList,
                  onSelected: (value) {
                    context.read<StartMatchVM>().onSelectHomePlayer(player.id ?? "");
                  },
                  isSelected: isSelected,
                  onPositionChanged: (newPosition) {
                    context.read<StartMatchVM>().onChangeHomeTeamPlayerPosition(
                        playerId: player.id ?? "", position: newPosition);
                  },
                );
              },
            ),
          ),
          customButtonForTournament(
            title: "Next",
            onTap: () async {
              if (!context.read<StartMatchVM>().checkHomeTeamSelectedPlayerHaveGoalKeeper()) {
                showToast('You must select at least one goalkeeper.', Colors.red);
                return;
              }

              if (context.read<StartMatchVM>().homeSelectedPlayerIdList.length !=
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
                  builder: (context) => SelectPlayer2opp(phone: widget.phone),
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

class GridItem extends StatefulWidget {
  final String name;
  final String city;
  final String position;
  final String? imageUrl; // Allow null for imageUrl
  final List<String> positions;
  final ValueChanged<String> onPositionChanged; // Callback to notify changes
  final ValueChanged<bool> onSelected; // Callback to notify changes
  final bool isSelected;

  GridItem({
    required this.name,
    required this.city,
    required this.position,
    this.imageUrl, // Make imageUrl optional
    required this.positions,
    required this.onPositionChanged, // Initialize callback
    required this.onSelected, // Initialize callback
    required this.isSelected,
  });

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isChecked = false;
  late String selectedPosition; // Initialize position

  @override
  void initState() {
    super.initState();
    selectedPosition = widget.position; // Set initial position from API
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      margin: EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 17,
                  child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            widget.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: Image.asset(
                            'assets/images/dp.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                h(11),
                Text(
                  widget.name,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 12),
                ),
                h(1),
                Row(
                  children: [
                    SvgPicture.asset("assets/images/location.svg"),
                    w(3),
                    Text(
                      widget.city,
                      style: GoogleFonts.inter(fontSize: 10),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: DropdownButton<String>(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 0),
                        isExpanded: false,
                        value: selectedPosition,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPosition = newValue!;
                          });
                          widget.onPositionChanged(selectedPosition);
                        },
                        items: widget.positions.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: GoogleFonts.inter()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(6),
            constraints: const BoxConstraints(maxHeight: 26, maxWidth: 26),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.onSelected(!widget.isSelected);
              },
              icon: Icon(
                (widget.isSelected ? Icons.check_box : Icons.check_box_outline_blank),
                color: TColor.msgbck,
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
