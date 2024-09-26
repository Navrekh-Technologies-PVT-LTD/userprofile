// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/utils/color.dart';

import '../teams/team_details.dart';

class MyTourTeams extends StatefulWidget {
  const MyTourTeams({super.key, required this.tournamentId});

  final String tournamentId;

  @override
  State<MyTourTeams> createState() => _MyTourTeamsState();
}

class _MyTourTeamsState extends State<MyTourTeams> {
  var filterText = "";
  List<Map<String, dynamic>> teams = [];
  var isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final body = jsonEncode(
          <String, dynamic>{'tournamentId': widget.tournamentId, 'count': 0});
      final response = await http.post(
          Uri.parse(
              "https://yoursportzbackend.azurewebsites.net/api/tournament/get-teams"),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : teams.isNotEmpty
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
                              fillColor:
                                  const Color.fromARGB(255, 240, 240, 245),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(16, 0, 16, 0),
                              prefixIcon: const Icon(Icons.search),
                              hintText: LocaleKeys.type_team_name.tr(),
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                        ),
                      ),
                    ),
                    Expanded(
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
                  ],
                )),
    );
  }
}

class Team extends StatelessWidget {
  const Team({
    super.key,
    required this.team,
  });

  final Map<String, dynamic> team;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TeamDetails(
                    phone: team['phone'],
                    teamId: team['teamId'],
                    teamLogo: team['logo'],
                    teamName: team['name'],
                    city: team['city'])));
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
              const Spacer(),
              GestureDetector(
                onTap: () {
                  print('this is what going --- ${team['logo']}');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ChatScreen(
                  //           teamLogo: team['logo'],
                  //           teamName: team['name'], chatId: '', phone: team['phone'],
                  //           // teamId: team['teamId'],
                  //         )));
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
              SizedBox(width: 20),
            ],
          )),
    );
  }
}
