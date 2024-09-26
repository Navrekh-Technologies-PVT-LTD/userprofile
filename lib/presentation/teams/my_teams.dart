// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:yoursportz/utils/color.dart';

import '../../gen/locale_keys.g.dart';
import '../chat/chat screen/chat_screen.dart';
import '../tournament/create_team.dart';
import 'team_details.dart';

class MyTeams extends StatefulWidget {
  const MyTeams({super.key, required this.phone});

  final String phone;

  @override
  State<MyTeams> createState() => _MyTeamsState();
}

class _MyTeamsState extends State<MyTeams> {
  var filterText = "";
  List<Map<String, dynamic>> teams = [];
  var isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final body =
          jsonEncode(<String, dynamic>{'phone': widget.phone, 'count': 0});
      final response = await http.post(
          Uri.parse(
              "https://yoursportzbackend.azurewebsites.net/api/team/get-my-teams"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      if (response.statusCode == 200) {
        print('new url ${response.body}');
        final jsonData = json.decode(response.body);
        setState(() {
          teams = jsonData.cast<Map<String, dynamic>>();
        });
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
        title: Text(LocaleKeys.my_teams.tr()),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: teams.isNotEmpty || isLoading
          ? Column(
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          prefixIcon: const Icon(Icons.search),
                          hintText: LocaleKeys.type_team_name.tr(),
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.normal)),
                    ),
                  ),
                ),
                isLoading
                    ? const Expanded(
                        child: Center(child: CircularProgressIndicator()))
                    : Expanded(
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
                                return Team(team: team);
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                      )
              ],
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.no_team_created.tr(),
                    style: TextStyle(fontSize: 17)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 32),
                  child: Text(LocaleKeys.no_team_owned.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => CreateTeam(
                                phone: widget.phone,
                                ground: const {},
                                source: "home"))));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color(0xff554585)),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(LocaleKeys.create_team.tr(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            )),
    );
  }
}

class Team extends StatefulWidget {
  const Team({
    super.key,
    required this.team,
  });

  final Map<String, dynamic> team;

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  String? chatId;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TeamDetails(
                    phone: widget.team['phone'],
                    teamId: widget.team['teamId'],
                    teamLogo: widget.team['logo'],
                    teamName: widget.team['name'],
                    city: widget.team['city'])));
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
                    widget.team['logo'],
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
                    widget.team['name'],
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.team['city'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  await fetchChatId(widget.team['teamId']);
                  if (chatId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          teamLogo: widget.team['logo'],
                          teamName: widget.team['name'],
                          chatId: chatId!,
                          phone: widget.team['phone'],
                        ),
                      ),
                    );
                  } else {
                    // Handle the case where chatId is still null
                    print('Error: chatId is null');
                  }
                },
                child: Container(
                  height: 35,
                  width: 75,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/chatIcon.svg',
                        height: 20,
                        width: 23,
                      ),
                      const Text(
                        'Chat',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          )),
    );
  }

  Future<void> fetchChatId(String teamId) async {
    final response = await http.post(
      Uri.parse(
          'https://yoursportzbackend.azurewebsites.net/api/chat/get-by-team-id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"teamId": teamId}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('response ------ ${response.body}');
      chatId = data['chatId'];
    } else {
      throw Exception('Failed to load chat ID');
    }
  }
}
