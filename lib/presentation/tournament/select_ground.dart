// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../gen/locale_keys.g.dart';
import 'create_team.dart';
import 'package:http/http.dart' as http;
import 'toss_create-match.dart';

class SelectGround extends StatefulWidget {
  const SelectGround({super.key, required this.phone});

  final String phone;

  @override
  State<SelectGround> createState() => _SelectGroundState();
}

class _SelectGroundState extends State<SelectGround> {
  final locationController = TextEditingController();
  final nameController = TextEditingController();
  var gameTime;
  var firstHalf = "First half";
  var players2play;
  var date = "Select date";
  var dateValid = true;
  DateTime selectedDate = DateTime.now();
  final dateFormat = DateFormat('dd-MMM-yyyy');
  TimeOfDay selectedTime = TimeOfDay.now();
  Map ground = {};
  final locationFocus = FocusNode();
  final groundFocus = FocusNode();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = dateFormat.format(picked);
        dateValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(tr(LocaleKeys.start_a_match)),
        //"Start a match",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 68),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr(LocaleKeys.location),
                      //"*Location",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500)),
                  InputText(
                      locationController: locationController,
                      focus: locationFocus,
                      hint: tr(LocaleKeys.enter_your_location),
                      //"Enter your location",
                      keyboard: TextInputType.text),
                  Text(tr(LocaleKeys.ground),
                      //"*Ground",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500)),
                  InputText(
                      locationController: nameController,
                      focus: groundFocus,
                      hint: tr(
                          LocaleKeys.enter_ground_name), //"Enter ground name",
                      keyboard: TextInputType.text),
                  Text(tr(LocaleKeys.date),
                      //"*Date",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500)),
                  GestureDetector(
                      onTap: () => {selectDate(context)},
                      child: Date(text: date, icon: Icons.date_range)),
                  Row(
                    children: [
                      Expanded(
                        child: Text(tr(LocaleKeys.game_time),
                            //"*Game Time",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        child: Text(tr(LocaleKeys.first_half),
                            // "*First Half",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        width: 0,
                                        color: const Color(0xff7A7A7A))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 4, 16, 4),
                                  child: DropdownButton<String>(
                                    hint: Text(tr(LocaleKeys.game_time)),
                                    //"Game time"
                                    value: gameTime,
                                    underline: const SizedBox(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        gameTime = value!;
                                        if (gameTime == "30 minutes") {
                                          firstHalf = "15 minutes";
                                        } else if (gameTime == "60 minutes") {
                                          firstHalf = "30 minutes";
                                        } else if (gameTime == "90 minutes") {
                                          firstHalf = "45 minutes";
                                        }
                                      });
                                    },
                                    items: <String>[
                                      // tr(LocaleKeys.thirty_minutes),
                                      // tr(LocaleKeys.sixty_minutes),
                                      // tr(LocaleKeys.ninty_minutes),
                                      '30 minutes',
                                      '60 minutes',
                                      '90 minutes'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ))),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        width: 0,
                                        color: const Color(0xff7A7A7A))),
                                child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(firstHalf,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: firstHalf ==
                                                    tr(LocaleKeys.first_half)
                                                // color: firstHalf == "First half"
                                                ? Colors.grey
                                                : null))))),
                      ),
                    ],
                  ),
                  Text(tr(LocaleKeys.players_to_play),
                      //"*Players to Play",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500)),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        width: 0,
                                        color: const Color(0xff7A7A7A))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 4, 16, 4),
                                  child: DropdownButton<String>(
                                    hint: Text(tr(
                                        LocaleKeys.select_number_of_players)),
                                    //"*Select number of players"
                                    value: players2play,
                                    underline: const SizedBox(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        players2play = value!;
                                      });
                                    },
                                    items: <String>[
                                      // tr(LocaleKeys.five_players),
                                      // tr(LocaleKeys.eight_players),
                                      // tr(LocaleKeys.eleven_players),
                                      '5 Players',
                                      '8 Players',
                                      '11 Players'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ))),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              const Spacer(),
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(tr(LocaleKeys.schedule_match),
                                //"Schedule Match",
                                style: const TextStyle(
                                    color: Color(0xff554585),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          locationController.text =
                              locationController.text.trim();
                          nameController.text = nameController.text.trim();
                          if (locationController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    tr(LocaleKeys.please_enter_location),
                                    //"Please enter location",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red));
                            locationFocus.requestFocus();
                          } else if (nameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    tr(LocaleKeys.please_enter_ground_name),
                                    //"Please enter ground name",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red));
                            groundFocus.requestFocus();
                          } else if (date == "Select date") {
                            selectDate(context);
                          } else if (gameTime == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    tr(LocaleKeys.please_select_game_time),
                                    //"Please select game time",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red));
                          } else if (players2play == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    tr(LocaleKeys
                                        .please_select_number_of_players_to_play),
                                    //"Please select number of players to play",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red));
                          } else {
                            ground['location'] = locationController.text;
                            ground['name'] = nameController.text;
                            ground['date'] = date;
                            ground['gameTime'] = gameTime;
                            ground['firstHalf'] = firstHalf;
                            ground['players'] = players2play.toString();
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartMatch(
                                        phone: widget.phone, ground: ground)));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: const Color(0xff554585)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(tr(LocaleKeys.next),
                              //"Next",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
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

class Date extends StatefulWidget {
  const Date({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 0, color: const Color(0xff7A7A7A))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(widget.text,
                    style: TextStyle(
                        fontSize: 17,
                        color: widget.text[0].startsWith(RegExp(r'\d'))
                            ? null
                            : Colors.grey)),
                const Spacer(),
                Icon(widget.icon)
              ],
            ),
          )),
    );
  }
}

class InputText extends StatelessWidget {
  const InputText(
      {super.key,
      required this.locationController,
      this.focus,
      required this.hint,
      required this.keyboard});

  final TextEditingController locationController;
  final FocusNode? focus;
  final String hint;
  final TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 0, color: const Color(0xff7A7A7A))),
        child: TextField(
          controller: locationController,
          focusNode: focus,
          keyboardType: keyboard,
          inputFormatters: [
            keyboard == TextInputType.number
                ? LengthLimitingTextInputFormatter(2)
                : LengthLimitingTextInputFormatter(30)
          ],
          decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: hint,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              contentPadding: const EdgeInsets.all(16)),
        ),
      ),
    );
  }
}

class StartMatch extends StatefulWidget {
  const StartMatch(
      {super.key,
      required this.phone,
      required this.ground,
      this.team,
      this.imageUrl,
      this.team2,
      this.imageUrl2});

  final String phone;
  final Map ground;
  final String? team;
  final String? imageUrl;
  final String? team2;
  final String? imageUrl2;

  @override
  State<StartMatch> createState() => _StartMatchState();
}

  class _StartMatchState extends State<StartMatch> {
  var teamsSelected = false;
  var isLoading = false;
  List<Map<String, dynamic>> addedPlayersTeam1 = [];
  List<Map<String, dynamic>> addedPlayersTeam2 = [];
  String buttonString = "Select Players";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.team2 != null) {
        setState(() {
          isLoading = true;
        });
        final body1 = jsonEncode(<String, dynamic>{'team_name': widget.team});
        final body2 = jsonEncode(<String, dynamic>{'team_name': widget.team2});
        final response1 = await http.post(
            Uri.parse(
                "https://yoursportzbackend.azurewebsites.net/api/team/get_all_players/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body1);
        if (response1.statusCode == 200) {
          final jsonData = json.decode(response1.body);
          setState(() {
            addedPlayersTeam1 = jsonData.cast<Map<String, dynamic>>();
          });
        }
        final response2 = await http.post(
            Uri.parse(
                "https://yoursportzbackend.azurewebsites.net/api/team/get_all_players/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body2);
        if (response2.statusCode == 200) {
          final jsonData = json.decode(response2.body);
          addedPlayersTeam2 = jsonData.cast<Map<String, dynamic>>();
          setState(() {
            final totalPlayers = int.parse(widget.ground['players'][0]) < 5
                ? widget.ground['players'].toString().substring(0, 2)
                : widget.ground['players'][0];
            final homeTeamPlayers = addedPlayersTeam1.length.toString();
            final opponentTeamPlayers = addedPlayersTeam2.length.toString();
            if (totalPlayers == homeTeamPlayers &&
                totalPlayers == opponentTeamPlayers) {
              buttonString = "Select Match Officials";
            }
          });
        }
        setState(() {
          isLoading = false;
          teamsSelected = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(tr(LocaleKeys.select_teams)),
        //"Select Teams"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.team == null
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectTeam(
                                    phone: widget.phone,
                                    ground: widget.ground,
                                    selection: "home")));
                      },
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(32)),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.add,
                                    color: Colors.green, size: 30),
                              )),
                          const SizedBox(height: 8),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(tr(LocaleKeys.select_home_team),
                                    //"Select Home Team",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectTeam(
                                    phone: widget.phone,
                                    ground: widget.ground,
                                    selection: "home")));
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                  child: Image.network(
                                widget.imageUrl!,
                                height: 36,
                                width: 36,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(32),
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    'assets/images/app_logo.png',
                                    height: 36,
                                    width: 36,
                                  );
                                },
                              ))),
                          const SizedBox(height: 8),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(widget.team!,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                    ),
              isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(82),
                      child: CircularProgressIndicator(),
                    )
                  : teamsSelected
                      ? Padding(
                          padding: const EdgeInsets.all(76),
                          child: Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () async {
                                  final totalPlayers =
                                      int.parse(widget.ground['players'][0]) < 5
                                          ? widget.ground['players']
                                              .toString()
                                              .substring(0, 2)
                                          : widget.ground['players'][0];
                                  final homeTeamPlayers =
                                      addedPlayersTeam1.length.toString();
                                  final opponentTeamPlayers =
                                      addedPlayersTeam2.length.toString();
                                  if (totalPlayers == homeTeamPlayers &&
                                      totalPlayers == opponentTeamPlayers) {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MatchOfficials(
                                                team1: widget.team!,
                                                team2: widget.team2!,
                                                team1players: addedPlayersTeam1,
                                                team2players: addedPlayersTeam2,
                                                team1substitutePlayers: const [],
                                                team2substitutePlayers: const [],
                                                team1Logo: widget.imageUrl!,
                                                team2Logo: widget.imageUrl2!,
                                                ground: widget.ground)));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChoosePlayers(
                                                team1: widget.team!,
                                                team2: widget.team2!,
                                                team1players: addedPlayersTeam1,
                                                team2players: addedPlayersTeam2,
                                                team1Logo: widget.imageUrl!,
                                                team2Logo: widget.imageUrl2!,
                                                totalPlayers: totalPlayers,
                                                ground: widget.ground)));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    backgroundColor: const Color(0xff554585)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(buttonString,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )),
                            ],
                          ),
                        )
                      : const SizedBox(height: 200),
              widget.team2 == null
                  ? GestureDetector(
                      onTap: () {
                        if (widget.team == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              tr(LocaleKeys.please_select_home_team_first),
                              // "Please select \"Home Team\" first",
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.orange,
                            duration: Duration(seconds: 3),
                          ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectTeam(
                                      phone: widget.phone,
                                      ground: widget.ground,
                                      selection: "opponent",
                                      homeTeam: widget.team,
                                      homeImageUrl: widget.imageUrl)));
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(32)),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.add,
                                    color: Colors.green, size: 30),
                              )),
                          const SizedBox(height: 8),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(tr(LocaleKeys.select_opponent_team),
                                    //"Select Opponent Team",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectTeam(
                                    phone: widget.phone,
                                    ground: widget.ground,
                                    selection: "opponent",
                                    homeTeam: widget.team,
                                    homeImageUrl: widget.imageUrl)));
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                  child: Image.network(
                                widget.imageUrl2!,
                                height: 36,
                                width: 36,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(32),
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    'assets/images/app_logo.png',
                                    height: 36,
                                    width: 36,
                                  );
                                },
                              ))),
                          const SizedBox(height: 8),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(widget.team2!,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
/// here its ihjdiwed
class ChoosePlayers extends StatefulWidget {
  const ChoosePlayers(
      {super.key,
      required this.team1,
      required this.team2,
      required this.team1players,
      required this.team2players,
      required this.totalPlayers,
      required this.team1Logo,
      required this.team2Logo,
      required this.ground});

  final String team1;
  final String team2;
  final List<Map<String, dynamic>> team1players;
  final List<Map<String, dynamic>> team2players;
  final String totalPlayers;
  final String team1Logo;
  final String team2Logo;
  final Map ground;

  @override
  State<ChoosePlayers> createState() => _ChoosePlayersState();
}

class _ChoosePlayersState extends State<ChoosePlayers> {
  late List<Map<String, dynamic>> firstTeamPlayers;
  late List<Map<String, dynamic>> secondTeamPlayers;
  var firstTeamSubstitutePlayers = <Map<String, dynamic>>[];
  var secondTeamSubstitutePlayers = <Map<String, dynamic>>[];
  var playersSelected = 0;
  var firstTeamPlayerSelection = false;
  var firstTeamGoalKeeper = false;
  var secondTeamGoalKeeper = false;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    firstTeamPlayers = List<Map<String, dynamic>>.from(widget.team1players);
    secondTeamPlayers = List<Map<String, dynamic>>.from(widget.team2players);
    for (var player in firstTeamPlayers) {
      player['selected'] = false;
    }
    for (var player in secondTeamPlayers) {
      player['selected'] = false;
    }
    super.initState();
  }

  void navigate2secondTeam() {
    setState(() {
      firstTeamPlayerSelection = true;
      playersSelected = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 240),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                tr(LocaleKeys.select_players_for_,
                    namedArgs: {'playerName': widget.totalPlayers}),
                //"Select ${widget.totalPlayers} Players for:",
                style: const TextStyle(fontSize: 18)),
            Text(firstTeamPlayerSelection ? widget.team2 : widget.team1,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: controller,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: firstTeamPlayerSelection
                    ? secondTeamPlayers.length
                    : firstTeamPlayers.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (!firstTeamPlayerSelection) {
                        if (firstTeamGoalKeeper &&
                            firstTeamPlayers[index]['position'] ==
                                "Goalkeeper" &&
                            !firstTeamPlayers[index]['selected']) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  tr(LocaleKeys
                                      .cannot_choose_multiple_goalkeepers),
                                  // "Can't choose multiple Goalkeepers",
                                  style: const TextStyle(color: Colors.white)),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3)));
                          return;
                        }
                      } else {
                        if (secondTeamGoalKeeper &&
                            secondTeamPlayers[index]['position'] ==
                                "Goalkeeper" &&
                            !secondTeamPlayers[index]['selected']) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  tr(LocaleKeys
                                      .cannot_choose_multiple_goalkeepers),
                                  //"Can't choose multiple Goalkeepers",
                                  style: const TextStyle(color: Colors.white)),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3)));
                          return;
                        }
                      }
                      if (firstTeamPlayerSelection
                          ? secondTeamPlayers[index]['selected'] ||
                              playersSelected < int.parse(widget.totalPlayers)
                          : firstTeamPlayers[index]['selected'] ||
                              playersSelected <
                                  int.parse(widget.totalPlayers)) {
                        setState(() {
                          firstTeamPlayerSelection
                              ? secondTeamPlayers[index]['selected'] =
                                  !secondTeamPlayers[index]['selected']
                              : firstTeamPlayers[index]['selected'] =
                                  !firstTeamPlayers[index]['selected'];
                          if (firstTeamPlayerSelection
                              ? secondTeamPlayers[index]['selected']
                              : firstTeamPlayers[index]['selected']) {
                            playersSelected++;
                            if (!firstTeamPlayerSelection) {
                              if (firstTeamPlayers[index]['position'] ==
                                  "Goalkeeper") firstTeamGoalKeeper = true;
                            } else {
                              if (secondTeamPlayers[index]['position'] ==
                                  "Goalkeeper") secondTeamGoalKeeper = true;
                            }
                          } else {
                            if (!firstTeamPlayerSelection) {
                              if (firstTeamPlayers[index]['position'] ==
                                  "Goalkeeper") firstTeamGoalKeeper = false;
                            } else {
                              if (secondTeamPlayers[index]['position'] ==
                                  "Goalkeeper") secondTeamGoalKeeper = false;
                            }

                            playersSelected--;
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(tr(LocaleKeys.cant_add_more_players),
                              //"Can't add more players",
                              style: const TextStyle(color: Colors.white)),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.orange,
                        ));
                      }
                    },
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: Image.network(
                                    firstTeamPlayerSelection
                                        ? secondTeamPlayers[index]['dp'] ?? ""
                                        : firstTeamPlayers[index]['dp'] ?? "",
                                    height: 50,
                                    width: 50,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(
                                        'assets/images/dp.png',
                                        height: 50,
                                        width: 50,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const Spacer(),
                              firstTeamPlayerSelection
                                  ? (secondTeamPlayers[index]['selected']
                                      ? const Icon(Icons.check_box,
                                          color: Color(0xff554585))
                                      : const Icon(
                                          Icons.check_box_outline_blank,
                                          color: Color(0xff554585)))
                                  : (firstTeamPlayers[index]['selected']
                                      ? const Icon(Icons.check_box,
                                          color: Color(0xff554585))
                                      : const Icon(
                                          Icons.check_box_outline_blank,
                                          color: Color(0xff554585))),
                              const SizedBox(width: 16)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                            child: Text(
                              firstTeamPlayerSelection
                                  ? secondTeamPlayers[index]['name']
                                  : firstTeamPlayers[index]['name'],
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Row(
                              children: [
                                const Icon(Icons.location_pin,
                                    size: 13, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  firstTeamPlayerSelection
                                      ? secondTeamPlayers[index]['city']
                                      : firstTeamPlayers[index]['city'],
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButton<String>(
                                    hint: Text(tr(LocaleKeys.player_position)),
                                    //"Player Position"),
                                    value: firstTeamPlayerSelection
                                        ? secondTeamPlayers[index]['position']
                                        : firstTeamPlayers[index]['position'],
                                    onChanged: (String? value) {
                                      setState(() {
                                        if (!firstTeamPlayerSelection) {
                                          if (firstTeamPlayers[index]
                                                      ['position'] ==
                                                  "Goalkeeper" &&
                                              value != "Goalkeeper") {
                                            firstTeamGoalKeeper = false;
                                          }
                                          if (!firstTeamGoalKeeper ||
                                              value != "Goalkeeper") {
                                            if (value == "Goalkeeper") {
                                              firstTeamGoalKeeper = true;
                                            }
                                            firstTeamPlayers[index]
                                                ['position'] = value;
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        tr(LocaleKeys
                                                            .cannot_choose_multiple_goalkeepers),
                                                        //"Can't choose multiple Goalkeepers",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    backgroundColor: Colors.red,
                                                    duration:
                                                        Duration(seconds: 3)));
                                          }
                                        } else {
                                          if (secondTeamPlayers[index]
                                                      ['position'] ==
                                                  "Goalkeeper" &&
                                              value != "Goalkeeper") {
                                            secondTeamGoalKeeper = false;
                                          }
                                          if (!secondTeamGoalKeeper ||
                                              value != "Goalkeeper") {
                                            if (value == "Goalkeeper") {
                                              secondTeamGoalKeeper = true;
                                            }
                                            secondTeamPlayers[index]
                                                ['position'] = value;
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        tr(LocaleKeys
                                                            .cannot_choose_multiple_goalkeepers),
                                                        //"Can't choose multiple Goalkeepers",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    backgroundColor: Colors.red,
                                                    duration:
                                                        Duration(seconds: 3)));
                                          }
                                        }
                                      });
                                    },
                                    items: <String>[
                                      //   LocaleKeys.goalkeeper.tr(),
                                      //   LocaleKeys.right_back.tr(),
                                      //   LocaleKeys.center_back.tr(),
                                      //   LocaleKeys.left_back.tr(),
                                      //   LocaleKeys.right_midfielder.tr(),
                                      //   LocaleKeys.center_midfielder.tr(),
                                      //   LocaleKeys.left_midfielder.tr(),
                                      //   LocaleKeys.right_winger.tr(),
                                      //   LocaleKeys.center_forward.tr(),
                                      //   LocaleKeys.left_winger.tr(),
                                      //   LocaleKeys.center_player.tr()
                                      'Goalkeeper',
                                      'Right Back',
                                      'Center Back',
                                      'Left Back',
                                      'Right Midfielder',
                                      'Center Midfielder',
                                      'Left Midfielder',
                                      'Right Winger',
                                      'Center Forward',
                                      'Left Winger',
                                      'Center Player'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style:
                                                const TextStyle(fontSize: 13)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            playersSelected == int.parse(widget.totalPlayers)
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (!firstTeamPlayerSelection) {
                                if (!firstTeamGoalKeeper) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Goalkeeper is mandatory and not selected yet",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3)));
                                  return;
                                }
                                firstTeamSubstitutePlayers = [];
                                for (var player in firstTeamPlayers) {
                                  if (!player['selected']) {
                                    firstTeamSubstitutePlayers
                                        .add(Map<String, dynamic>.from(player));
                                  }
                                }
                                final totalSubstitutePLayers =
                                    widget.totalPlayers == '11' ? 3 : 2;
                                var substitutePlayersSelected = 0;
                                if (totalSubstitutePLayers <=
                                    firstTeamSubstitutePlayers.length) {
                                  showDialog(
                                      context: context,
                                      builder: ((context) => Center(
                                            child: Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        StateSetter setState) {
                                                  return Column(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 24, 0, 16),
                                                      child: Text(
                                                          tr(LocaleKeys
                                                              .select_substitute_players),
                                                          // "Select $totalSubstitutePLayers Substitute Players",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        child: GridView.builder(
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                          ),
                                                          itemCount:
                                                              firstTeamSubstitutePlayers
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            final player =
                                                                firstTeamSubstitutePlayers[
                                                                    index];
                                                            return GestureDetector(
                                                              onTap: () {
                                                                if (firstTeamSubstitutePlayers[
                                                                            index]
                                                                        [
                                                                        'selected'] ||
                                                                    substitutePlayersSelected <
                                                                        totalSubstitutePLayers) {
                                                                  setState(() {
                                                                    firstTeamSubstitutePlayers[
                                                                            index]
                                                                        [
                                                                        'selected'] = !firstTeamSubstitutePlayers[
                                                                            index]
                                                                        [
                                                                        'selected'];
                                                                    if (firstTeamSubstitutePlayers[
                                                                            index]
                                                                        [
                                                                        'selected']) {
                                                                      substitutePlayersSelected++;
                                                                    } else {
                                                                      substitutePlayersSelected--;
                                                                    }
                                                                  });
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                              child: Card(
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          radius:
                                                                              35,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          child:
                                                                              ClipOval(
                                                                            child:
                                                                                Image.network(
                                                                              firstTeamSubstitutePlayers[index]['dp'],
                                                                              height: 50,
                                                                              width: 50,
                                                                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                                                if (loadingProgress == null) {
                                                                                  return child;
                                                                                }
                                                                                return Center(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(32),
                                                                                    child: CircularProgressIndicator(
                                                                                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                                return Image.asset(
                                                                                  'assets/images/dp.png',
                                                                                  height: 50,
                                                                                  width: 50,
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const Spacer(),
                                                                        (firstTeamSubstitutePlayers[index]['selected']
                                                                            ? const Icon(Icons.check_box,
                                                                                color: Color(0xff554585))
                                                                            : const Icon(Icons.check_box_outline_blank, color: Color(0xff554585))),
                                                                        const SizedBox(
                                                                            width:
                                                                                16)
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          12,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        firstTeamSubstitutePlayers[index]['name'].length <=
                                                                                12
                                                                            ? firstTeamSubstitutePlayers[index][
                                                                                'name']
                                                                            : firstTeamSubstitutePlayers[index]['name'].toString().substring(0,
                                                                                12),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Icon(
                                                                              Icons.location_pin,
                                                                              size: 13,
                                                                              color: Colors.grey),
                                                                          const SizedBox(
                                                                              width: 4),
                                                                          Text(
                                                                            firstTeamSubstitutePlayers[index]['city'].length <= 10
                                                                                ? firstTeamSubstitutePlayers[index]['city']
                                                                                : firstTeamSubstitutePlayers[index]['city'].toString().substring(0, 10),
                                                                            style:
                                                                                const TextStyle(fontSize: 13, color: Colors.grey),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const Spacer(),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              8),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Icon(
                                                                              Icons.play_arrow,
                                                                              size: 15),
                                                                          Text(
                                                                            player['position'],
                                                                            style:
                                                                                const TextStyle(fontSize: 12),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    substitutePlayersSelected ==
                                                            totalSubstitutePLayers
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      navigate2secondTeam();
                                                                      controller
                                                                          .animateTo(
                                                                        0,
                                                                        duration:
                                                                            const Duration(milliseconds: 500),
                                                                        curve: Curves
                                                                            .easeInOut,
                                                                      );
                                                                    },
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                            backgroundColor:
                                                                                const Color(0xff554585)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          12),
                                                                      child: Text(
                                                                          tr(LocaleKeys
                                                                              .done),
                                                                          // "Done",
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : const SizedBox()
                                                  ]);
                                                })),
                                          )));
                                } else {
                                  setState(() {
                                    firstTeamPlayerSelection = true;
                                    playersSelected = 0;
                                  });
                                  controller.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              } else {
                                if (!secondTeamGoalKeeper) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Goalkeeper is mandatory and not selected yet",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3)));
                                  return;
                                }
                                secondTeamSubstitutePlayers = [];
                                for (var player in secondTeamPlayers) {
                                  if (!player['selected']) {
                                    secondTeamSubstitutePlayers
                                        .add(Map<String, dynamic>.from(player));
                                  }
                                }
                                final totalSubstitutePLayers =
                                    widget.totalPlayers == '11' ? 3 : 2;
                                var substitutePlayersSelected = 0;
                                if (totalSubstitutePLayers <=
                                    secondTeamSubstitutePlayers.length) {
                                  showDialog(
                                      context: context,
                                      builder: ((context) => Center(
                                            child: Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        StateSetter setState) {
                                                  return Column(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 24, 0, 16),
                                                      child: Text(
                                                          "Select $totalSubstitutePLayers Substitute Players",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        child: GridView.builder(
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                          ),
                                                          itemCount:
                                                              secondTeamSubstitutePlayers
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            final player =
                                                                secondTeamSubstitutePlayers[
                                                                    index];
                                                            return GestureDetector(
                                                              onTap: () {
                                                                if (secondTeamSubstitutePlayers[
                                                                            index]
                                                                        [
                                                                        'selected'] ||
                                                                    substitutePlayersSelected <
                                                                        totalSubstitutePLayers) {
                                                                  setState(() {
                                                                    secondTeamSubstitutePlayers[
                                                                            index]
                                                                        [
                                                                        'selected'] = !secondTeamSubstitutePlayers[
                                                                            index]
                                                                        [
                                                                        'selected'];
                                                                    if (secondTeamSubstitutePlayers[
                                                                            index]
                                                                        [
                                                                        'selected']) {
                                                                      substitutePlayersSelected++;
                                                                    } else {
                                                                      substitutePlayersSelected--;
                                                                    }
                                                                  });
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                              child: Card(
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          radius:
                                                                              35,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          child:
                                                                              ClipOval(
                                                                            child:
                                                                                Image.network(
                                                                              secondTeamSubstitutePlayers[index]['dp'],
                                                                              height: 50,
                                                                              width: 50,
                                                                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                                                if (loadingProgress == null) {
                                                                                  return child;
                                                                                }
                                                                                return Center(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(32),
                                                                                    child: CircularProgressIndicator(
                                                                                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                                return Image.asset(
                                                                                  'assets/images/dp.png',
                                                                                  height: 50,
                                                                                  width: 50,
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const Spacer(),
                                                                        (secondTeamSubstitutePlayers[index]['selected']
                                                                            ? const Icon(Icons.check_box,
                                                                                color: Color(0xff554585))
                                                                            : const Icon(Icons.check_box_outline_blank, color: Color(0xff554585))),
                                                                        const SizedBox(
                                                                            width:
                                                                                16)
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          12,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        secondTeamSubstitutePlayers[index]['name'].length <=
                                                                                12
                                                                            ? secondTeamSubstitutePlayers[index][
                                                                                'name']
                                                                            : secondTeamSubstitutePlayers[index]['name'].toString().substring(0,
                                                                                12),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Icon(
                                                                              Icons.location_pin,
                                                                              size: 13,
                                                                              color: Colors.grey),
                                                                          const SizedBox(
                                                                              width: 4),
                                                                          Text(
                                                                            secondTeamSubstitutePlayers[index]['city'].length <= 10
                                                                                ? secondTeamSubstitutePlayers[index]['city']
                                                                                : secondTeamSubstitutePlayers[index]['city'].toString().substring(0, 10),
                                                                            style:
                                                                                const TextStyle(fontSize: 13, color: Colors.grey),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              1),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Icon(
                                                                              Icons.play_arrow,
                                                                              size: 15),
                                                                          Text(
                                                                            player['position'],
                                                                            style:
                                                                                const TextStyle(fontSize: 12),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    substitutePlayersSelected ==
                                                            totalSubstitutePLayers
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pop(
                                                                          context);
                                                                      firstTeamPlayers.removeWhere((player) =>
                                                                          player[
                                                                              'selected'] ==
                                                                          false);
                                                                      secondTeamPlayers.removeWhere((player) =>
                                                                          player[
                                                                              'selected'] ==
                                                                          false);
                                                                      firstTeamSubstitutePlayers.removeWhere((player) =>
                                                                          player[
                                                                              'selected'] ==
                                                                          false);
                                                                      secondTeamSubstitutePlayers.removeWhere((player) =>
                                                                          player[
                                                                              'selected'] ==
                                                                          false);
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) => MatchOfficials(
                                                                                team1: widget.team1,
                                                                                team2: widget.team2,
                                                                                team1players: firstTeamPlayers,
                                                                                team2players: secondTeamPlayers,
                                                                                team1substitutePlayers: firstTeamSubstitutePlayers,
                                                                                team2substitutePlayers: secondTeamSubstitutePlayers,
                                                                                team1Logo: widget.team1Logo,
                                                                                team2Logo: widget.team2Logo,
                                                                                ground: widget.ground),
                                                                          ));
                                                                    },
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                            backgroundColor:
                                                                                const Color(0xff554585)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          12),
                                                                      child: Text(
                                                                          tr(LocaleKeys
                                                                              .select_match_officials),
                                                                          //"Select Match Officials",
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : const SizedBox()
                                                  ]);
                                                })),
                                          )));
                                } else {
                                  firstTeamPlayers.removeWhere(
                                      (player) => player['selected'] == false);
                                  secondTeamPlayers.removeWhere(
                                      (player) => player['selected'] == false);
                                  firstTeamSubstitutePlayers.removeWhere(
                                      (player) => player['selected'] == false);
                                  secondTeamSubstitutePlayers.removeWhere(
                                      (player) => player['selected'] == false);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MatchOfficials(
                                              team1: widget.team1,
                                              team2: widget.team2,
                                              team1players: firstTeamPlayers,
                                              team2players: secondTeamPlayers,
                                              team1substitutePlayers:
                                                  firstTeamSubstitutePlayers,
                                              team2substitutePlayers:
                                                  secondTeamSubstitutePlayers,
                                              team1Logo: widget.team1Logo,
                                              team2Logo: widget.team2Logo,
                                              ground: widget.ground)));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: const Color(0xff554585)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(tr(LocaleKeys.next),
                                  //"Next",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class MatchOfficials extends StatefulWidget {
  const MatchOfficials(
      {super.key,
      required this.team1,
      required this.team2,
      required this.team1players,
      required this.team2players,
      required this.team1substitutePlayers,
      required this.team2substitutePlayers,
      required this.team1Logo,
      required this.team2Logo,
      required this.ground});

  final String team1;
  final String team2;
  final List<Map<String, dynamic>> team1players;
  final List<Map<String, dynamic>> team2players;
  final List<Map<String, dynamic>> team1substitutePlayers;
  final List<Map<String, dynamic>> team2substitutePlayers;
  final String team1Logo;
  final String team2Logo;
  final Map ground;

  @override
  State<MatchOfficials> createState() => _MatchOfficialsState();
}

class _MatchOfficialsState extends State<MatchOfficials> {
  List<Map<String, dynamic>> scorer = List.filled(2, {'phone': 'null'});
  List<Map<String, dynamic>> streamer = List.filled(4, {'phone': 'null'});
  List<Map<String, dynamic>> referee = List.filled(2, {'phone': 'null'});
  List<Map<String, dynamic>> linesman = List.filled(4, {'phone': 'null'});
  List<Map<String, dynamic>> users = [];
  var userLoading = true;
  var scorerSelection = false;
  List selectedOfficials = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final response = await http.get(Uri.parse(
          'https://yoursportzbackend.azurewebsites.net/api/user/all/'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          users = jsonData.cast<Map<String, dynamic>>();
          userLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 235, 240),
        appBar: AppBar(
          title: Text(tr(LocaleKeys.match_officials)),
          //"Match Officials"),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        body: userLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(tr(LocaleKeys.select_scorer),
                                          //"Select Scorer",
                                          style: const TextStyle(fontSize: 20)),
                                      Text(
                                          tr(LocaleKeys
                                              .minimum_one_scorer_should_be_selected),
                                          // "*Minimum one scorer should be selected.",
                                          style: const TextStyle(
                                              color: Colors.grey))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Scorer(
                                          scorer: scorer,
                                          users: users,
                                          index: 0,
                                          setScorer: (int i) {
                                            setState(() {
                                              scorer[0] = users[i];
                                              scorerSelection = true;
                                            });
                                          },
                                          selectedOfficials: selectedOfficials,
                                          official: "Scorer"),
                                      Scorer(
                                          scorer: scorer,
                                          users: users,
                                          index: 1,
                                          setScorer: (int i) {
                                            setState(() {
                                              scorer[1] = users[i];
                                              scorerSelection = true;
                                            });
                                          },
                                          selectedOfficials: selectedOfficials,
                                          official: "Scorer")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child:
                                      Text(tr(LocaleKeys.select_live_streamers),
                                          //"Select Live Streamers",
                                          style: const TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Streamer(
                                              streamer: streamer,
                                              users: users,
                                              index: 0,
                                              setStreamer: (int i) {
                                                setState(() {
                                                  streamer[0] = users[i];
                                                });
                                              },
                                              selectedOfficials:
                                                  selectedOfficials,
                                              official: "Streamer"),
                                          Streamer(
                                              streamer: streamer,
                                              users: users,
                                              index: 1,
                                              setStreamer: (int i) {
                                                setState(() {
                                                  streamer[1] = users[i];
                                                });
                                              },
                                              selectedOfficials:
                                                  selectedOfficials,
                                              official: "Streamer")
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Streamer(
                                              streamer: streamer,
                                              users: users,
                                              index: 2,
                                              setStreamer: (int i) {
                                                setState(() {
                                                  streamer[2] = users[i];
                                                });
                                              },
                                              selectedOfficials:
                                                  selectedOfficials,
                                              official: "Streamer"),
                                          Streamer(
                                              streamer: streamer,
                                              users: users,
                                              index: 3,
                                              setStreamer: (int i) {
                                                setState(() {
                                                  streamer[3] = users[i];
                                                });
                                              },
                                              selectedOfficials:
                                                  selectedOfficials,
                                              official: "Streamer")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(tr(LocaleKeys.select_referee),
                                      //"Select Referee",
                                      style: const TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Referee(
                                          referee: referee,
                                          users: users,
                                          index: 0,
                                          setReferee: (int i) {
                                            setState(() {
                                              referee[0] = users[i];
                                            });
                                          },
                                          selectedOfficials: selectedOfficials,
                                          official: "Referee"),
                                      Referee(
                                          referee: referee,
                                          users: users,
                                          index: 1,
                                          setReferee: (int i) {
                                            setState(() {
                                              referee[1] = users[i];
                                            });
                                          },
                                          selectedOfficials: selectedOfficials,
                                          official: "Referee")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(tr(LocaleKeys.select_linesman),
                                      //"Select Linesman",
                                      style: const TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Linesman(
                                              linesman: linesman,
                                              users: users,
                                              index: 0,
                                              setLinesman: (int i) {
                                                setState(() {
                                                  linesman[0] = users[i];
                                                });
                                              },
                                              selectedOfficials:
                                                  selectedOfficials,
                                              official: "Linesman"),
                                          Linesman(
                                              linesman: linesman,
                                              users: users,
                                              index: 1,
                                              setLinesman: (int i) {
                                                setState(() {
                                                  linesman[1] = users[i];
                                                });
                                              },
                                              selectedOfficials:
                                                  selectedOfficials,
                                              official: "Linesman")
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Linesman(
                                              linesman: linesman,
                                              users: users,
                                              index: 2,
                                              setLinesman: (int i) {
                                                setState(() {
                                                  linesman[2] = users[i];
                                                });
                                              },
                                              selectedOfficials:
                                                  selectedOfficials,
                                              official: "Linesman"),
                                          Linesman(
                                              linesman: linesman,
                                              users: users,
                                              index: 3,
                                              setLinesman: (int i) {
                                                setState(() {
                                                  linesman[3] = users[i];
                                                });
                                              },
                                              selectedOfficials:
                                                  selectedOfficials,
                                              official: "Linesman")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Spacer(),
                      SubmitMatchOfficials(
                          widget: widget,
                          scorer: scorer,
                          streamer: streamer,
                          referee: referee,
                          linesman: linesman,
                          canProceed: scorerSelection),
                    ],
                  )
                ],
              ));
  }
}

class Linesman extends StatefulWidget {
  const Linesman(
      {super.key,
      required this.linesman,
      required this.users,
      required this.index,
      required this.setLinesman,
      required this.selectedOfficials,
      required this.official});

  final List<Map<String, dynamic>> linesman;
  final List<Map<String, dynamic>> users;
  final int index;
  final Function(int) setLinesman;
  final List selectedOfficials;
  final String official;

  @override
  State<Linesman> createState() => _LinesmanState();
}

class _LinesmanState extends State<Linesman> {
  var userSelected = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                            child: Text(
                                userSelected
                                    ? widget.linesman[widget.index]['name']
                                                .length <=
                                            10
                                        ? widget.linesman[widget.index]['name']
                                        : widget.linesman[widget.index]['name']
                                            .toString()
                                            .substring(0, 10)
                                    : tr(LocaleKeys.linesman),
                                // "Linesman",
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_pin,
                                  size: 12, color: Colors.grey),
                              Text(
                                  userSelected
                                      ? widget.linesman[widget.index]['city']
                                                  .length <=
                                              10
                                          ? widget.linesman[widget.index]
                                              ['city']
                                          : widget.linesman[widget.index]
                                                  ['city']
                                              .toString()
                                              .substring(0, 10)
                                      : tr(LocaleKeys.city),
                                  //"City",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          )
                        ]),
                    const Spacer(),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.network(
                          userSelected
                              ? widget.linesman[widget.index]['dp']
                              : "",
                          height: 35,
                          width: 35,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
                              'assets/images/linesman_icon.png',
                              height: 35,
                              width: 35,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String filterText = '';
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      backgroundColor: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                  tr(LocaleKeys.select_official,
                                                      args: [widget.official]),
                                                  // "Select ${widget.official}",
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                            ),
                                            TextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  filterText = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32)),
                                                  filled: true,
                                                  fillColor: Colors.grey[200],
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 0, 16, 0),
                                                  prefixIcon:
                                                      const Icon(Icons.search),
                                                  hintText: tr(LocaleKeys
                                                      .search_for_the_user),
                                                  // "Search for the user",
                                                  hintStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ),
                                            const SizedBox(height: 8),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: widget.users.length,
                                                itemBuilder: (context, index) {
                                                  final user =
                                                      widget.users[index];
                                                  return user['name']
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(filterText
                                                                  .toLowerCase()) &&
                                                          !widget
                                                              .selectedOfficials
                                                              .contains(
                                                                  user['phone'])
                                                      ? User(
                                                          dp: user['dp'],
                                                          name: user['name'],
                                                          phone: user['phone'],
                                                          city: user['city'],
                                                          index: index,
                                                          select: (int i) {
                                                            widget
                                                                .selectedOfficials
                                                                .add(user[
                                                                    'phone']);
                                                            if (userSelected) {
                                                              widget
                                                                  .selectedOfficials
                                                                  .remove(widget
                                                                              .linesman[
                                                                          widget
                                                                              .index]
                                                                      [
                                                                      'phone']);
                                                            }
                                                            widget
                                                                .setLinesman(i);
                                                            setState(() {
                                                              userSelected =
                                                                  true;
                                                            });
                                                          })
                                                      : const SizedBox();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(4)),
                            minimumSize:
                                WidgetStateProperty.all<Size>(const Size(0, 0)),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 135, 120, 180)),
                          ),
                          child: Text(
                              userSelected
                                  ? "Change Linesman"
                                  : tr(LocaleKeys.select_linesman),
                              //"Select Linesman",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class Referee extends StatefulWidget {
  const Referee(
      {super.key,
      required this.referee,
      required this.users,
      required this.index,
      required this.setReferee,
      required this.selectedOfficials,
      required this.official});

  final List<Map<String, dynamic>> referee;
  final List<Map<String, dynamic>> users;
  final int index;
  final Function(int) setReferee;
  final List selectedOfficials;
  final String official;

  @override
  State<Referee> createState() => _RefereeState();
}

class _RefereeState extends State<Referee> {
  var userSelected = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                            child: Text(
                                userSelected
                                    ? widget.referee[widget.index]['name']
                                                .length <=
                                            10
                                        ? widget.referee[widget.index]['name']
                                        : widget.referee[widget.index]['name']
                                            .toString()
                                            .substring(0, 10)
                                    : tr(LocaleKeys.referee),
                                //"Referee",
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_pin,
                                  size: 12, color: Colors.grey),
                              Text(
                                  userSelected
                                      ? widget.referee[widget.index]['city']
                                                  .length <=
                                              10
                                          ? widget.referee[widget.index]['city']
                                          : widget.referee[widget.index]['city']
                                              .toString()
                                              .substring(0, 10)
                                      : tr(LocaleKeys.city),
                                  // "City",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          )
                        ]),
                    const Spacer(),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.network(
                          userSelected
                              ? widget.referee[widget.index]['dp']
                              : "",
                          height: 35,
                          width: 35,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
                              'assets/images/referee_icon.png',
                              height: 35,
                              width: 35,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String filterText = '';
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      backgroundColor: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                  tr(LocaleKeys.select_official,
                                                      args: [widget.official]),
                                                  //"Select ${widget.official}",
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                            ),
                                            TextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  filterText = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32)),
                                                  filled: true,
                                                  fillColor: Colors.grey[200],
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 0, 16, 0),
                                                  prefixIcon:
                                                      const Icon(Icons.search),
                                                  hintText: tr(LocaleKeys
                                                      .search_for_the_user),
                                                  // "Search for the user",
                                                  hintStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ),
                                            const SizedBox(height: 8),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: widget.users.length,
                                                itemBuilder: (context, index) {
                                                  final user =
                                                      widget.users[index];
                                                  return user['name']
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(filterText
                                                                  .toLowerCase()) &&
                                                          !widget
                                                              .selectedOfficials
                                                              .contains(
                                                                  user['phone'])
                                                      ? User(
                                                          dp: user['dp'],
                                                          name: user['name'],
                                                          phone: user['phone'],
                                                          city: user['city'],
                                                          index: index,
                                                          select: (int i) {
                                                            widget
                                                                .selectedOfficials
                                                                .add(user[
                                                                    'phone']);
                                                            if (userSelected) {
                                                              widget
                                                                  .selectedOfficials
                                                                  .remove(widget
                                                                              .referee[
                                                                          widget
                                                                              .index]
                                                                      [
                                                                      'phone']);
                                                            }
                                                            widget
                                                                .setReferee(i);
                                                            setState(() {
                                                              userSelected =
                                                                  true;
                                                            });
                                                          })
                                                      : const SizedBox();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(4)),
                            minimumSize:
                                WidgetStateProperty.all<Size>(const Size(0, 0)),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 135, 120, 180)),
                          ),
                          child: Text(
                              userSelected
                                  ? tr(LocaleKeys.change_referee)
                                  //"Change Referee"
                                  : tr(LocaleKeys.select_referee),
                              //"Select Referee",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class Streamer extends StatefulWidget {
  const Streamer(
      {super.key,
      required this.streamer,
      required this.users,
      required this.index,
      required this.setStreamer,
      required this.selectedOfficials,
      required this.official});

  final List<Map<String, dynamic>> streamer;
  final List<Map<String, dynamic>> users;
  final int index;
  final Function(int) setStreamer;
  final List selectedOfficials;
  final String official;

  @override
  State<Streamer> createState() => _StreamerState();
}

class _StreamerState extends State<Streamer> {
  var userSelected = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                            child: Text(
                                userSelected
                                    ? widget.streamer[widget.index]['name']
                                                .length <=
                                            10
                                        ? widget.streamer[widget.index]['name']
                                        : widget.streamer[widget.index]['name']
                                            .toString()
                                            .substring(0, 10)
                                    : tr(LocaleKeys.streamer),
                                //"Streamer",
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_pin,
                                  size: 12, color: Colors.grey),
                              Text(
                                  userSelected
                                      ? widget.streamer[widget.index]['city']
                                                  .length <=
                                              10
                                          ? widget.streamer[widget.index]
                                              ['city']
                                          : widget.streamer[widget.index]
                                                  ['city']
                                              .toString()
                                              .substring(0, 10)
                                      : tr(LocaleKeys.city),
                                  //"City",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          )
                        ]),
                    const Spacer(),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.network(
                          userSelected
                              ? widget.streamer[widget.index]['dp']
                              : "",
                          height: 35,
                          width: 35,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
                              'assets/images/streamer_icon.png',
                              height: 35,
                              width: 35,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String filterText = '';
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      backgroundColor: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                  tr(LocaleKeys.select_official,
                                                      args: [widget.official]),
                                                  //"Select ${widget.official}",
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                            ),
                                            TextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  filterText = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32)),
                                                  filled: true,
                                                  fillColor: Colors.grey[200],
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 0, 16, 0),
                                                  prefixIcon:
                                                      const Icon(Icons.search),
                                                  hintText: tr(LocaleKeys
                                                      .search_for_the_user),
                                                  // "Search for the user",
                                                  hintStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ),
                                            const SizedBox(height: 8),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: widget.users.length,
                                                itemBuilder: (context, index) {
                                                  final user =
                                                      widget.users[index];
                                                  return user['name']
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(filterText
                                                                  .toLowerCase()) &&
                                                          !widget
                                                              .selectedOfficials
                                                              .contains(
                                                                  user['phone'])
                                                      ? User(
                                                          dp: user['dp'],
                                                          name: user['name'],
                                                          phone: user['phone'],
                                                          city: user['city'],
                                                          index: index,
                                                          select: (int i) {
                                                            widget
                                                                .selectedOfficials
                                                                .add(user[
                                                                    'phone']);
                                                            if (userSelected) {
                                                              widget
                                                                  .selectedOfficials
                                                                  .remove(widget
                                                                              .streamer[
                                                                          widget
                                                                              .index]
                                                                      [
                                                                      'phone']);
                                                            }
                                                            widget
                                                                .setStreamer(i);
                                                            setState(() {
                                                              userSelected =
                                                                  true;
                                                            });
                                                          })
                                                      : const SizedBox();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(4)),
                            minimumSize:
                                WidgetStateProperty.all<Size>(const Size(0, 0)),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 135, 120, 180)),
                          ),
                          child: Text(
                              userSelected
                                  ? tr(LocaleKeys.change_streamer)
                                  //"Change Streamer"
                                  : tr(LocaleKeys.select_streamer),
                              //"Select Streamer",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class Scorer extends StatefulWidget {
  const Scorer(
      {super.key,
      required this.scorer,
      required this.users,
      required this.index,
      required this.setScorer,
      required this.selectedOfficials,
      required this.official});

  final List<Map<String, dynamic>> scorer;
  final List<Map<String, dynamic>> users;
  final int index;
  final Function(int) setScorer;
  final List selectedOfficials;
  final String official;

  @override
  State<Scorer> createState() => _ScorerState();
}

class _ScorerState extends State<Scorer> {
  var userSelected = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                            child: Text(
                                userSelected
                                    ? widget.scorer[widget.index]['name']
                                                .length <=
                                            10
                                        ? widget.scorer[widget.index]['name']
                                        : widget.scorer[widget.index]['name']
                                            .toString()
                                            .substring(0, 10)
                                    : tr(LocaleKeys.scorer),
                                //"Scorer",
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_pin,
                                  size: 12, color: Colors.grey),
                              Text(
                                  userSelected
                                      ? widget.scorer[widget.index]['city']
                                                  .length <=
                                              10
                                          ? widget.scorer[widget.index]['city']
                                          : widget.scorer[widget.index]['city']
                                              .toString()
                                              .substring(0, 10)
                                      : tr(LocaleKeys.city),
                                  // "City",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          )
                        ]),
                    const Spacer(),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.network(
                          userSelected ? widget.scorer[widget.index]['dp'] : "",
                          height: 35,
                          width: 35,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
                              'assets/images/scorer_icon.png',
                              height: 35,
                              width: 35,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String filterText = '';
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      backgroundColor: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                  tr(LocaleKeys.select_official,
                                                      args: [widget.official]),
                                                  //"Select ${widget.official}",
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                            ),
                                            TextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  filterText = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32)),
                                                  filled: true,
                                                  fillColor: Colors.grey[200],
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 0, 16, 0),
                                                  prefixIcon:
                                                      const Icon(Icons.search),
                                                  hintText: tr(LocaleKeys
                                                      .search_for_the_user),
                                                  //"Search for the user",
                                                  hintStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ),
                                            const SizedBox(height: 8),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: widget.users.length,
                                                itemBuilder: (context, index) {
                                                  final user =
                                                      widget.users[index];
                                                  return user['name']
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(filterText
                                                                  .toLowerCase()) &&
                                                          !widget
                                                              .selectedOfficials
                                                              .contains(
                                                                  user['phone'])
                                                      ? User(
                                                          dp: user['dp'],
                                                          name: user['name'],
                                                          phone: user['phone'],
                                                          city: user['city'],
                                                          index: index,
                                                          select: (int i) {
                                                            widget
                                                                .selectedOfficials
                                                                .add(user[
                                                                    'phone']);
                                                            if (userSelected) {
                                                              widget
                                                                  .selectedOfficials
                                                                  .remove(widget
                                                                              .scorer[
                                                                          widget
                                                                              .index]
                                                                      [
                                                                      'phone']);
                                                            }
                                                            widget.setScorer(i);
                                                            setState(() {
                                                              userSelected =
                                                                  true;
                                                            });
                                                          })
                                                      : const SizedBox();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(4)),
                            minimumSize:
                                WidgetStateProperty.all<Size>(const Size(0, 0)),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 135, 120, 180)),
                          ),
                          child: Text(
                              userSelected
                                  ? tr(LocaleKeys.change_scorer)
                                  //"Change Scorer"
                                  : tr(LocaleKeys.select_scorer),
                              // "Select Scorer",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class SubmitMatchOfficials extends StatelessWidget {
  const SubmitMatchOfficials(
      {super.key,
      required this.widget,
      required this.scorer,
      required this.streamer,
      required this.referee,
      required this.linesman,
      required this.canProceed});

  final MatchOfficials widget;
  final List<Map<String, dynamic>> scorer;
  final List<Map<String, dynamic>> streamer;
  final List<Map<String, dynamic>> referee;
  final List<Map<String, dynamic>> linesman;
  final bool canProceed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  if (canProceed) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BeginMatch(
                                team1: widget.team1,
                                team2: widget.team2,
                                team1players: widget.team1players,
                                team2players: widget.team2players,
                                team1substitutePlayers:
                                    widget.team1substitutePlayers,
                                team2substitutePlayers:
                                    widget.team2substitutePlayers,
                                team1Logo: widget.team1Logo,
                                team2Logo: widget.team2Logo,
                                scorer: scorer,
                                streamer: streamer,
                                referee: referee,
                                linesman: linesman,
                                ground: widget.ground)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            tr(LocaleKeys.select_atleast_one_scorer_to_proceed),
                            //"Select atleast one scorer to proceed",
                            style: const TextStyle(color: Colors.white)),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red));
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xff554585)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(tr(LocaleKeys.start_match),
                      //"Start Match",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                )),
          ),
        ],
      ),
    );
  }
}

class User extends StatefulWidget {
  const User(
      {super.key,
      required this.dp,
      required this.name,
      required this.phone,
      required this.city,
      required this.index,
      required this.select});

  final String dp;
  final String name;
  final String phone;
  final String city;
  final int index;
  final Function(int) select;

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Row(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                    child: Image.network(
                  widget.dp,
                  height: 40,
                  width: 40,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
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
                      'assets/images/dp.png',
                      height: 40,
                      width: 40,
                    );
                  },
                ))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold)),
                Text(widget.city,
                    style: const TextStyle(fontSize: 12, color: Colors.grey))
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.select(widget.index);
                  Navigator.pop(context);
                });
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.cyan),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(tr(LocaleKeys.select),
                    //"SELECT",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 8)
          ],
        ));
  }
}

class SelectTeam extends StatefulWidget {
  const SelectTeam(
      {super.key,
      required this.phone,
      required this.ground,
      required this.selection,
      this.homeTeam,
      this.homeImageUrl});

  final String phone;
  final Map ground;
  final String selection;
  final String? homeTeam;
  final String? homeImageUrl;

  @override
  State<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends State<SelectTeam> {
  var filterText = "";
  List<Map<String, dynamic>> teams = [];
  var isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final totalPlayers = int.parse(widget.ground['players'][0]) < 5
          ? widget.ground['players'].toString().substring(0, 2)
          : widget.ground['players'][0];
      final body = jsonEncode(
          <String, dynamic>{'phone': widget.phone, 'count': totalPlayers});
      if (widget.selection == "home") {
        final response = await http.post(
            Uri.parse(
                "https://yoursportzbackend.azurewebsites.net/api/team/get-teams/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body);
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          setState(() {
            teams = jsonData.cast<Map<String, dynamic>>();
          });
        }
      } else {
        final response = await http.post(
            Uri.parse(
                "https://yoursportzbackend.azurewebsites.net/api/team/get-opponent-teams/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body);
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          setState(() {
            teams = jsonData.cast<Map<String, dynamic>>();
          });
        }
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 245),
      appBar: AppBar(
        title: widget.selection == "home"
            ? Text(tr(LocaleKeys.select_home_team))
            //"Select Home Team")
            : Text(tr(LocaleKeys.select_opponent_team)),
        //"Select Opponent Team"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    filterText = value;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(32)),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 240, 240, 245),
                    contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    prefixIcon: const Icon(Icons.search),
                    hintText: tr(LocaleKeys.type_team_name),
                    //"Type team name",
                    hintStyle: const TextStyle(fontWeight: FontWeight.normal)),
              ),
            ),
          ),
          isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : teams.isNotEmpty
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ListView.builder(
                          itemCount: teams.length,
                          itemBuilder: (context, index) {
                            final team = teams[index];
                            if (team['name']
                                .toString()
                                .toLowerCase()
                                .contains(filterText.toLowerCase())) {
                              return widget.selection == "home"
                                  ? Team(
                                      phone: widget.phone,
                                      ground: widget.ground,
                                      team: team,
                                      index: index,
                                      selection: widget.selection)
                                  : Team(
                                      phone: widget.phone,
                                      ground: widget.ground,
                                      team: team,
                                      index: index,
                                      selection: widget.selection,
                                      homeTeam: widget.homeTeam,
                                      homeImageUrl: widget.homeImageUrl,
                                    );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    )
                  : CreateNewTeam(
                      phone: widget.phone,
                      ground: widget.ground,
                    )
        ],
      ),
    );
  }
}

class Team extends StatelessWidget {
  const Team(
      {super.key,
      required this.phone,
      required this.ground,
      required this.team,
      required this.index,
      required this.selection,
      this.homeTeam,
      this.homeImageUrl});

  final String phone;
  final Map ground;
  final Map<String, dynamic> team;
  final int index;
  final String selection;
  final String? homeTeam;
  final String? homeImageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
        if (selection == "home") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StartMatch(
                      phone: phone,
                      ground: ground,
                      team: team['name'],
                      imageUrl: team['logo'])));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StartMatch(
                        phone: phone,
                        ground: ground,
                        team: homeTeam,
                        imageUrl: homeImageUrl,
                        team2: team['name'],
                        imageUrl2: team['logo'],
                      )));
        }
      },
      child: Card(
          color: Colors.white,
          child: Row(
            children: [
              CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                      child: Image.network(
                    team['logo'],
                    height: 50,
                    width: 50,
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
                        height: 50,
                      );
                    },
                  ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    team['name'],
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    team['city'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class CreateNewTeam extends StatefulWidget {
  const CreateNewTeam({super.key, required this.phone, required this.ground});

  final String phone;
  final Map ground;

  @override
  State<CreateNewTeam> createState() => _CreateNewTeamState();
}

class _CreateNewTeamState extends State<CreateNewTeam> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(tr(LocaleKeys.why_not_played_yet),
            //"Why haven't you played a match yet?\nCome on, go ahead and start one!",
            style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateTeam(
                          phone: widget.phone,
                          ground: widget.ground,
                          source: "match")));
            },
            child: Text(tr(LocaleKeys.create_your_team),
                //"Create Your Team",
                style: const TextStyle(color: Colors.grey)))
      ]),
    );
  }
}

class BeginMatch extends StatefulWidget {
  const BeginMatch(
      {super.key,
      required this.team1,
      required this.team2,
      required this.team1players,
      required this.team2players,
      required this.team1substitutePlayers,
      required this.team2substitutePlayers,
      required this.team1Logo,
      required this.team2Logo,
      required this.scorer,
      required this.streamer,
      required this.referee,
      required this.linesman,
      required this.ground});

  final String team1;
  final String team2;
  final List<Map<String, dynamic>> team1players;
  final List<Map<String, dynamic>> team2players;
  final List<Map<String, dynamic>> team1substitutePlayers;
  final List<Map<String, dynamic>> team2substitutePlayers;
  final String team1Logo;
  final String team2Logo;
  final List<Map<String, dynamic>> scorer;
  final List<Map<String, dynamic>> streamer;
  final List<Map<String, dynamic>> referee;
  final List<Map<String, dynamic>> linesman;
  final Map ground;

  @override
  State<BeginMatch> createState() => _BeginMatchState();
}

class _BeginMatchState extends State<BeginMatch>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Map<String, dynamic> goalKeeper1;
  late List<Widget> defenders1 = [];
  late List<Widget> midfielders1 = [];
  late List<Widget> centerForwards1 = [];
  late List<Widget> centerPlayers1 = [];
  late Map<String, dynamic> goalKeeper2;
  late List<Widget> defenders2 = [];
  late List<Widget> midfielders2 = [];
  late List<Widget> centerForwards2 = [];
  late List<Widget> centerPlayers2 = [];
  var toss = false;
  var caller = "";
  var tossWon = "";
  var kickOff = "";

  @override
  void initState() {
    for (var item in widget.team1players) {
      if (item['position'] == 'Goalkeeper') {
        goalKeeper1 = item;
      } else if (item['position'] == 'Right Back' ||
          item['position'] == 'Center Back' ||
          item['position'] == 'Left Back') {
        Player player = Player(dp: item['dp'], name: item['name']);
        defenders1.add(player);
      } else if (item['position'] == 'Right Midfielder' ||
          item['position'] == 'Center Midfielder' ||
          item['position'] == 'Left Midfielder') {
        Player player = Player(dp: item['dp'], name: item['name']);
        midfielders1.add(player);
      } else if (item['position'] == 'Right Winger' ||
          item['position'] == 'Center Forward' ||
          item['position'] == 'Left Winger') {
        Player player = Player(dp: item['dp'], name: item['name']);
        centerForwards1.add(player);
      } else if (item['position'] == 'Center Player') {
        Player player = Player(dp: item['dp'], name: item['name']);
        centerPlayers1.add(player);
      }
    }
    for (var item in widget.team2players) {
      if (item['position'] == 'Goalkeeper') {
        goalKeeper2 = item;
      } else if (item['position'] == 'Right Back' ||
          item['position'] == 'Center Back' ||
          item['position'] == 'Left Back') {
        Player player = Player(dp: item['dp'], name: item['name']);
        defenders2.add(player);
      } else if (item['position'] == 'Right Midfielder' ||
          item['position'] == 'Center Midfielder' ||
          item['position'] == 'Left Midfielder') {
        Player player = Player(dp: item['dp'], name: item['name']);
        midfielders2.add(player);
      } else if (item['position'] == 'Right Winger' ||
          item['position'] == 'Center Forward' ||
          item['position'] == 'Left Winger') {
        Player player = Player(dp: item['dp'], name: item['name']);
        centerForwards2.add(player);
      } else if (item['position'] == 'Center Player') {
        Player player = Player(dp: item['dp'], name: item['name']);
        centerPlayers2.add(player);
      }
    }
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
    startTossButtonAnimation();
    super.initState();
  }

  Future<void> startTossButtonAnimation() async {
    await Future.delayed(const Duration(seconds: 2));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(tr(LocaleKeys.begin_match)),
        //"Begin Match"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Player(dp: goalKeeper1['dp'], name: goalKeeper1['name'])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: defenders1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: midfielders1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: centerForwards1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: centerPlayers1,
                  ),
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: centerPlayers2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: centerForwards2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: midfielders2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: defenders2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Player(dp: goalKeeper2['dp'], name: goalKeeper2['name'])
                    ],
                  ),
                ],
              ))
            ]),
          ),
          toss
              ? const SizedBox()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: animation.value,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => Toss(
                                              team1: widget.team1,
                                              team2: widget.team2,
                                              team1players: widget.team1players,
                                              team2players: widget.team2players,
                                              team1substitutePlayers:
                                                  widget.team1substitutePlayers,
                                              team2substitutePlayers:
                                                  widget.team2substitutePlayers,
                                              team1Logo: widget.team1Logo,
                                              team2Logo: widget.team2Logo,
                                              scorer: widget.scorer,
                                              streamer: widget.streamer,
                                              referee: widget.referee,
                                              linesman: widget.linesman,
                                              ground: widget.ground,
                                              setKickoff: (bool tossDone,
                                                  String callerTeam,
                                                  String tossWonTeam,
                                                  String kickOffTeam) {
                                                setState(() {
                                                  toss = tossDone;
                                                  caller = callerTeam;
                                                  tossWon = tossWonTeam;
                                                  kickOff = kickOffTeam;
                                                });
                                              }))));
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(64),
                                    ),
                                    backgroundColor: const Color(0xff554585)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 28, 0, 28),
                                  child: Text(tr(LocaleKeys.toss),
                                      //"Toss",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )
        ],
      ),
    );
  }
}

class Player extends StatelessWidget {
  const Player({super.key, required this.dp, required this.name});

  final String dp;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 15,
            backgroundColor: Colors.transparent,
            child: ClipOval(
                child: Image.network(
              dp,
              height: 30,
              width: 30,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
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
                  'assets/images/dp.png',
                  height: 30,
                  width: 30,
                );
              },
            ))),
        const SizedBox(height: 4),
        Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(150, 100, 100, 100),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                  name.length <= 5 ? "  $name  " : " ${name.substring(0, 5)}..",
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            )),
      ],
    );
  }
}
