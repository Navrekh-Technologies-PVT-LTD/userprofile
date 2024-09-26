// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:yoursportz/routing/app_router.gr.dart';

import '../../gen/locale_keys.g.dart';
import 'select_ground.dart';

List<Map<String, dynamic>> selectedPlayers = [];

class AddPlayers extends StatefulWidget {
  const AddPlayers(
      {super.key,
      required this.ground,
      required this.teamName,
      required this.city,
      required this.phone,
      required this.imageUrl,
      required this.source,
      required this.token,
      required this.selfAdd});

  final Map ground;
  final String teamName;
  final String city;
  final String phone;
  final String imageUrl;
  final String source;
  final String token;
  final bool selfAdd;

  @override
  State<AddPlayers> createState() => _AddPlayersState();
}

class _AddPlayersState extends State<AddPlayers> {
  List<Map<String, dynamic>> players = [];
  var filterText = "";
  var userLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      selectedPlayers.clear();
      final response = await http.get(Uri.parse(
          'https://yoursportzbackend.azurewebsites.net/api/user/all/'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          players = jsonData.cast<Map<String, dynamic>>();
          userLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 245),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                    child: Image.network(
                  widget.imageUrl,
                  height: 35,
                  width: 35,
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
                      'assets/images/app_logo.png',
                      height: 35,
                    );
                  },
                ))),
            Text(widget.teamName.length <= 15
                ? widget.teamName
                : widget.teamName.substring(0, 15)),
          ],
        ),
        backgroundColor: Colors.white,
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
                    hintText: LocaleKeys.search_players.tr(),
                    hintStyle: const TextStyle(fontWeight: FontWeight.normal)),
              ),
            ),
          ),
          filterText.isEmpty
              ? Expanded(
                  child: Center(
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                      child: Text(
                        tr(LocaleKeys.create_multiple_players),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => const AddExtraPlayer());
                        },
                        child: Text(tr(LocaleKeys.add_player),
                            style: const TextStyle(color: Colors.white))),
                  ],
                )))
              : userLoading
                  ? const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ListView.builder(
                          itemCount: players.length,
                          itemBuilder: (context, index) {
                            final player = players[index];
                            final willAddSelf = widget.selfAdd
                                ? true
                                : widget.phone != player['phone'];
                            return player['name']
                                        .toString()
                                        .toLowerCase()
                                        .contains(filterText.toLowerCase()) &&
                                    willAddSelf
                                ? Player(
                                    dp: player['dp'],
                                    name: player['name'],
                                    phone: player['phone'],
                                    city: player['city'],
                                    index: index,
                                    remove: (i) {
                                      setState(() {
                                        players.removeAt(i);
                                      });
                                    })
                                : const SizedBox();
                          },
                        ),
                      ),
                    ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Share.share(tr(LocaleKeys.download_app_message));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => InvitePlayers(
                      //             teamName: widget.teamName,
                      //             city: widget.city,
                      //             phone: widget.phone,
                      //             imageUrl: widget.imageUrl,
                      //             token: widget.token)));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(tr(LocaleKeys.invite_players),
                          style: const TextStyle(
                              color: Color(0xff554585),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedPlayers.length < 5) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(tr(LocaleKeys.add_atleast_5_players),
                              style: const TextStyle(color: Colors.white)),
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.orange,
                        ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SelectedPlayers(
                                    ground: widget.ground,
                                    teamName: widget.teamName,
                                    city: widget.city,
                                    phone: widget.phone,
                                    imageUrl: widget.imageUrl,
                                    source: widget.source))));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color(0xff554585)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(tr(LocaleKeys.done),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AddExtraPlayer extends StatefulWidget {
  const AddExtraPlayer({
    super.key,
  });

  @override
  State<AddExtraPlayer> createState() => _AddExtraPlayerState();
}

class _AddExtraPlayerState extends State<AddExtraPlayer> {
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final userController = TextEditingController();
  var nameValid = true;
  var cityValid = true;
  var userValid = true;
  var isLoading = false;
  var usernameTaken = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(tr(LocaleKeys.add_player),
                  style: const TextStyle(fontSize: 20)),
            ),
            InputText(
                controller: nameController,
                icon: Icons.person,
                hint: tr(LocaleKeys.player_name),
                min: 3,
                max: 30,
                error: tr(LocaleKeys.cant_be_less_than_3_characters),
                valid: nameValid,
                updateValid: (bool isValid) {
                  setState(() {
                    nameValid = isValid;
                  });
                }),
            InputText(
                controller: cityController,
                icon: Icons.location_city,
                hint: tr(LocaleKeys.city),
                min: 1,
                max: 20,
                error: tr(LocaleKeys.cant_be_empty),
                valid: cityValid,
                updateValid: (bool isValid) {
                  setState(() {
                    cityValid = isValid;
                  });
                }),
            InputText(
                controller: userController,
                icon: Icons.person_2_outlined,
                hint: tr(LocaleKeys.username),
                min: 3,
                max: 10,
                error: tr(LocaleKeys.cant_be_less_than_3_characters),
                valid: userValid,
                updateValid: (bool isValid) {
                  setState(() {
                    userValid = isValid;
                  });
                }),
            usernameTaken
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Text(tr(LocaleKeys.username_already_taken),
                            style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          usernameTaken = false;
                        });
                        nameController.text = nameController.text.trim();
                        cityController.text = cityController.text.trim();
                        userController.text = userController.text.trim();
                        userController.text =
                            userController.text.replaceAll(" ", "");
                        if (nameController.text.length < 3) {
                          setState(() {
                            nameValid = false;
                          });
                        } else if (cityController.text.isEmpty) {
                          setState(() {
                            cityValid = false;
                          });
                        } else if (userController.text.length < 3) {
                          setState(() {
                            userValid = false;
                          });
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          final body = jsonEncode(
                              <String, dynamic>{'userId': userController.text});
                          final response = await http.post(
                              Uri.parse(
                                  "https://yoursportzbackend.azurewebsites.net/api/auth/check-user/"),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: body);
                          final Map<String, dynamic> responseData =
                              jsonDecode(response.body);
                          if (responseData['message'] == "success") {
                            final body = jsonEncode(<String, dynamic>{
                              'phone': userController.text,
                              'name': nameController.text,
                              'city': cityController.text,
                            });
                            final response = await http.put(
                                Uri.parse(
                                    "https://yoursportzbackend.azurewebsites.net/api/auth/save/"),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: body);
                            final Map<String, dynamic> responseData =
                                jsonDecode(response.body);
                            if (responseData['message'] == "success") {
                              setState(() {
                                isLoading = false;
                              });
                              selectedPlayers.add({
                                'dp': "",
                                'phone': userController.text,
                                'name': nameController.text,
                                'city': cityController.text,
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    tr(LocaleKeys.player_added_successfully),
                                    style:
                                        const TextStyle(color: Colors.white)),
                                backgroundColor: Colors.green,
                              ));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            setState(() {
                              isLoading = false;
                              usernameTaken = true;
                            });
                          }
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
                          : Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(tr(LocaleKeys.done),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        )));
  }
}

class InputText extends StatelessWidget {
  const InputText(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hint,
      required this.min,
      required this.max,
      required this.error,
      required this.valid,
      required this.updateValid});

  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final int min;
  final int max;
  final String error;
  final bool valid;
  final Function(bool) updateValid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextField(
        controller: controller,
        inputFormatters: [LengthLimitingTextInputFormatter(max)],
        onChanged: (value) {
          if (value.length >= min) {
            updateValid(true);
          }
        },
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hint,
            prefixIcon: Icon(icon),
            errorText: valid ? null : error),
      ),
    );
  }
}

class SelectedPlayers extends StatefulWidget {
  const SelectedPlayers(
      {super.key,
      required this.ground,
      required this.teamName,
      required this.city,
      required this.phone,
      required this.imageUrl,
      required this.source});

  final Map ground;
  final String teamName;
  final String city;
  final String phone;
  final String imageUrl;
  final String source;

  @override
  State<SelectedPlayers> createState() => _SelectedPlayersState();
}

class _SelectedPlayersState extends State<SelectedPlayers> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool allPlayersHavePosition = selectedPlayers.every((player) {
      return player['position'] != null && player['position'].isNotEmpty;
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 240),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                    child: Image.network(
                  widget.imageUrl,
                  height: 35,
                  width: 35,
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
                      'assets/images/app_logo.png',
                      height: 35,
                    );
                  },
                ))),
            Text(widget.teamName.length <= 15
                ? widget.teamName
                : widget.teamName.substring(0, 15))
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: selectedPlayers.length,
                itemBuilder: (BuildContext context, int index) {
                  final player = selectedPlayers[index];
                  return Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.network(
                              player['dp'],
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
                                    padding: const EdgeInsets.all(32),
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                                  'assets/images/dp.png',
                                  height: 50,
                                  width: 50,
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text(
                            player['name'],
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
                                player['city'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  hint: Text(tr(LocaleKeys.player_position)),
                                  value: player['position'],
                                  onChanged: (String? value) {
                                    setState(() {
                                      player['position'] = value;
                                    });
                                  },
                                  items: <String>[
                                    // LocaleKeys.goalkeeper.tr(),
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
                                          style: const TextStyle(fontSize: 13)),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {});
                        if (!allPlayersHavePosition) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  tr(LocaleKeys
                                      .please_select_position_for_every_player),
                                  style: const TextStyle(color: Colors.white)),
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.orange));
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });
                        final body = jsonEncode(<String, dynamic>{
                          'team_name': widget.teamName,
                          'players': selectedPlayers
                        });
                        final response = await http.put(
                            Uri.parse(
                                "https://yoursportzbackend.azurewebsites.net/api/team/add_players/"),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: body);
                        final Map<String, dynamic> responseData =
                            jsonDecode(response.body);
                        if (responseData['message'] == "success") {
                          AutoRouter.of(context).pushAndPopUntil(
                            AppBaseRoute(phone: widget.phone),
                            predicate: (route) => false,
                          );
                          if (widget.source == "match") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartMatch(
                                        phone: widget.phone,
                                        ground: widget.ground,
                                        team: widget.teamName,
                                        imageUrl: widget.imageUrl)));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => Center(
                                      child: SingleChildScrollView(
                                        child: Dialog(
                                            surfaceTintColor: Colors.white,
                                            backgroundColor: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(children: [
                                                Image.asset(
                                                    'assets/images/success_team.png',
                                                    height: 70,
                                                    width: 70),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                      tr(LocaleKeys
                                                          .team_created_successfully),
                                                      // "Team Created Successfully",
                                                      style: const TextStyle(
                                                          fontSize: 17)),
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          backgroundColor:
                                                              const Color(
                                                                  0xff554585)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(12, 0, 12, 0),
                                                    child: Text(
                                                        tr(LocaleKeys.done),
                                                        // "Done",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ),
                                              ]),
                                            )),
                                      ),
                                    ));
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
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
                          : Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(tr(LocaleKeys.done),
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
          ],
        ),
      ),
    );
  }
}

class Player extends StatefulWidget {
  const Player(
      {super.key,
      required this.dp,
      required this.name,
      required this.phone,
      required this.city,
      required this.index,
      required this.remove});

  final String dp;
  final String name;
  final String phone;
  final String city;
  final int index;
  final Function(int) remove;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Row(
          children: [
            CircleAvatar(
                radius: 35,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                    child: Image.network(
                  widget.dp,
                  height: 50,
                  width: 50,
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
                      height: 50,
                      width: 50,
                    );
                  },
                ))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                Text(widget.city,
                    style: const TextStyle(fontSize: 13, color: Colors.grey))
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedPlayers.add({
                    'dp': widget.dp,
                    'name': widget.name,
                    'phone': widget.phone,
                    'city': widget.city,
                  });
                  widget.remove(widget.index);
                });
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.cyan),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(tr(LocaleKeys.ADD),
                    //"ADD",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 8)
          ],
        ));
  }
}

class InvitePlayers extends StatefulWidget {
  const InvitePlayers(
      {super.key,
      required this.teamName,
      required this.city,
      required this.phone,
      required this.imageUrl,
      required this.token});

  final String teamName;
  final String city;
  final String phone;
  final String imageUrl;
  final String token;

  @override
  State<InvitePlayers> createState() => _InvitePlayersState();
}

class _InvitePlayersState extends State<InvitePlayers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 245),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                    child: Image.network(
                  widget.imageUrl,
                  height: 35,
                  width: 35,
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
                      'assets/images/team.png',
                      height: 35,
                    );
                  },
                ))),
            Text(widget.teamName)
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr(LocaleKeys.share_link_with_players),
                //"Share this link with players",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(widget.token),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    backgroundColor: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(tr(LocaleKeys.copy),
                                      //"Copy",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    backgroundColor: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(tr(LocaleKeys.share),
                                      // "Share",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ])),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text(tr(LocaleKeys.or_scan_qr_code),
                  //"Or Scan the QR Code",
                  style: const TextStyle(fontSize: 20)),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Image.asset('assets/images/qr.jpg', height: 100),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tr(LocaleKeys.team_qr_code),
                                  // "Team QR Code",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tr(LocaleKeys.ask_players_to_scan_qr_code),
                                  // "Ask players to scan this QR Code",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QrCode(
                                                teamName: widget.teamName,
                                                city: widget.city,
                                                phone: widget.phone,
                                                imageUrl: widget.imageUrl)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.blue),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(tr(LocaleKeys.share),
                                        // "Share",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ])),
          ],
        ),
      ),
    );
  }
}

class QrCode extends StatefulWidget {
  const QrCode(
      {super.key,
      required this.teamName,
      required this.city,
      required this.phone,
      required this.imageUrl});

  final String teamName;
  final String city;
  final String phone;
  final String imageUrl;

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                      child: Image.network(
                    widget.imageUrl,
                    height: 100,
                    width: 100,
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
                        'assets/images/team.png',
                        height: 35,
                      );
                    },
                  ))),
              const SizedBox(height: 8),
              Text(widget.teamName,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
              Text(widget.city, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              Image.asset('assets/images/qr.jpg', height: 200),
              const SizedBox(height: 30),
              Text(tr(LocaleKeys.ask_players_to_scan_qr_code_to_add),
                  // "Ask players to scan this QR Code\nto add themselves directly in team name",
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: const Color(0xff554585)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(tr(LocaleKeys.share_this_code),
                                // "Share This Code",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
