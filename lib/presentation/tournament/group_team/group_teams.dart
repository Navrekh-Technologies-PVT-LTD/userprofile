// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/tournament/start-tournament/widgets/team_card_widget.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';

class GroupTeams extends StatefulWidget {
  const GroupTeams({super.key});

  @override
  State<GroupTeams> createState() => _GroupTeamsState();
}

class _GroupTeamsState extends State<GroupTeams> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<TournamentProvider>().initGroupTeamPage();
      },
    );
  }

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
        titleSpacing: -8,
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
                  context
                      .read<TournamentProvider>()
                      .setSearchTextForGroupTeamPage(value);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(32)),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 240, 240, 245),
                    contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Type team name",
                    hintStyle: const TextStyle(fontWeight: FontWeight.normal)),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  // "Group ${context.watch<TournamentProvider>().currentGroupIndex + 1}",
                  "Group ${String.fromCharCode(65 + context.watch<TournamentProvider>().currentGroupIndex)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: buildUI(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 235, 235, 240),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
              .copyWith(top: 8),
          child: ElevatedButton(
            onPressed: () {
              if (context.read<TournamentProvider>().isLoadingAddGroups) {
                return;
              }
              context.read<TournamentProvider>().onTapSaveGroup(context);
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: const Color(0xff554585)),
            child: context.watch<TournamentProvider>().isLoadingAddGroups
                ? loadingWidgetForBtn()
                : Text(
                    context.watch<TournamentProvider>().isShowNext
                        ? "Next"
                        : "Save Changes",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  buildUI() {
    var teams =
        (context.watch<TournamentProvider>().selectedTournament?.teams ?? []);

    var teamGroups = context.watch<TournamentProvider>().teamGroups;
    var currentGroupTeams = context
        .watch<TournamentProvider>()
        .teamGroups[context.watch<TournamentProvider>().currentGroupIndex];

    String searchText =
        context.watch<TournamentProvider>().searchTextForGroupTeamPage.trim();

    if (searchText.isNotEmpty) {
      teams = teams
          .where((element) => element.name?.contains(searchText) ?? false)
          .toList();
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        ...teams.map(
          (e) {
            bool isShowCard = true;

            for (var element in teamGroups) {
              if (currentGroupTeams != element) {
                for (var el in element) {
                  if (el.id == e.id) {
                    isShowCard = false;
                    break;
                  }
                }
              }
            }
            bool isAdded = false;

            int i =
                currentGroupTeams.indexWhere((element) => element.id == e.id);

            if (i >= 0) {
              isAdded = true;
            }

            return isShowCard
                ? TeamCardWidget(
                    team: e,
                    onTapAdd: () {
                      if (isAdded) {
                        context
                            .read<TournamentProvider>()
                            .onTapRemoveTeamFromGroup(i);
                      } else {
                        context
                            .read<TournamentProvider>()
                            .onTapAddTeamInGroup(e);
                      }
                    },
                    isAdded: isAdded,
                  )
                : Container();
          },
        ),
      ],
    );
  }
}

// class GroupTeams2 extends StatefulWidget {
//   GroupTeams2(
//       {super.key,
//       required this.phone,
//       required this.tournamentId,
//       required this.teams,
//       required this.numberOfTeams,
//       required this.numberOfGroups,
//       required this.GroupTeamsapi});
//
//   final String phone;
//   final String tournamentId;
//   final List<Team> teams;
//   final String numberOfTeams;
//   final String numberOfGroups;
//   List<dynamic> GroupTeamsapi;
//
//   @override
//   State<GroupTeams2> createState() => _GroupTeams2State();
// }
//
// class _GroupTeams2State extends State<GroupTeams2> {
//   List<Team> teams = [];
//   List<List<Map<String, dynamic>>> groupedTeams = [[]];
//   List<List<Map<String, dynamic>>> groupedTeamsapidesingn = [[]];
//
//   var currentSelection = 1;
//   var selectedGroup = "Group 1";
//   var filterText = "";
//   late double teamsPerGroup;
//   var isLoading = false;
//
//   @override
//   void initState() {
//     teamsPerGroup =
//         int.parse(widget.numberOfTeams) / int.parse(widget.numberOfGroups);
//     teams = List.from(widget.teams);
//     super.initState();
//
//     if (widget.GroupTeamsapi.isNotEmpty) {
//       groupedTeamsapidesingn = List<List<Map<String, dynamic>>>.from(
//           widget.GroupTeamsapi.map(
//               (group) => List<Map<String, dynamic>>.from(group)));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool hasGroupTeams = widget.GroupTeamsapi.isNotEmpty;
//     print("hasGroupTeams => $hasGroupTeams");
//     print("teamsPerGroup => $teamsPerGroup");
//
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 240, 240, 245),
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(Icons.arrow_back_ios_new_rounded),
//         ),
//         title: Text(
//           'Group Teams',
//           style: GoogleFonts.inter(
//             fontWeight: FontWeight.w500,
//             fontSize: 18,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         titleSpacing: -8,
//       ),
//       body: hasGroupTeams
//           ? ListView.builder(
//               itemCount: groupedTeamsapidesingn.length,
//               itemBuilder: (context, index) {
//                 final group = groupedTeamsapidesingn[index];
//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Text(
//                             "Group ${index + 1}",
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xff554585),
//                             ),
//                           ),
//                         ),
//                         ...group.map((team) {
//                           return Card(
//                             color: Colors.white,
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 4, horizontal: 8),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 radius: 25,
//                                 backgroundColor: Colors.transparent,
//                                 child: team['logo'].isNotEmpty
//                                     ? ClipOval(
//                                         child: Image.network(
//                                           team['logo'],
//                                           height: 50,
//                                           width: 50,
//                                           fit: BoxFit.cover,
//                                           errorBuilder:
//                                               (context, error, stackTrace) {
//                                             return Icon(Icons.groups,
//                                                 color: Colors.grey[600]);
//                                           },
//                                         ),
//                                       )
//                                     : Icon(Icons.groups,
//                                         color: Colors.grey[600]),
//                               ),
//                               title: Text(
//                                 team['name'],
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 107, 89, 161),
//                                   fontSize: 17,
//                                 ),
//                               ),
//                               subtitle: Text(
//                                 team['city'],
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             )
//           : Column(
//               children: [
//                 Container(
//                   height: 70,
//                   decoration: const BoxDecoration(color: Colors.white),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: TextField(
//                       onChanged: (value) {
//                         setState(() {
//                           filterText = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(32)),
//                           filled: true,
//                           fillColor: const Color.fromARGB(255, 240, 240, 245),
//                           contentPadding:
//                               const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                           prefixIcon: const Icon(Icons.search),
//                           hintText: "Type team name",
//                           hintStyle:
//                               const TextStyle(fontWeight: FontWeight.normal)),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Text(selectedGroup,
//                           style: const TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold)),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: groupedTeams[currentSelection - 1].length <
//                             teamsPerGroup
//                         ? const EdgeInsets.fromLTRB(4, 0, 4, 8)
//                         : const EdgeInsets.fromLTRB(4, 0, 4, 65),
//                     child: ListView.builder(
//                       itemCount: teams.length,
//                       itemBuilder: (context, index) {
//                         final team = teams[index];
//                         return team.name
//                                 .toString()
//                                 .toLowerCase()
//                                 .contains(filterText.toLowerCase())
//                             ? TeamCard(
//                                 teamLogo: team.logo!,
//                                 teamName: team.name!,
//                                 city: team.city!,
//                                 addTeam: () {
//                                   if (groupedTeams[currentSelection - 1]
//                                           .length <
//                                       teamsPerGroup.toInt()) {
//                                     setState(() {
//                                       // groupedTeams[currentSelection - 1]
//                                       //     .add(team);
//                                       teams.removeAt(index);
//                                     });
//                                   } else {
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(const SnackBar(
//                                       content: Text("Can't add more teams",
//                                           style:
//                                               TextStyle(color: Colors.white)),
//                                       backgroundColor: Colors.red,
//                                       duration: Duration(seconds: 2),
//                                     ));
//                                   }
//                                 })
//                             : const SizedBox();
//                       },
//                     ),
//                   ),
//                 ),
//                 groupedTeams[currentSelection - 1].length >=
//                         teamsPerGroup.toInt()
//                     ? Container(
//                         color: const Color.fromARGB(255, 240, 240, 245),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     if (currentSelection <
//                                         int.parse(widget.numberOfGroups)) {
//                                       setState(() {
//                                         groupedTeams.add([]);
//                                         selectedGroup =
//                                             "Group ${++currentSelection}";
//                                       });
//                                     } else {
//                                       setState(() {
//                                         isLoading = true;
//                                       });
//                                       final body = jsonEncode(<String, dynamic>{
//                                         'tournamentId': widget.tournamentId,
//                                         'groupedTeams': groupedTeams
//                                       });
//                                       final response = await http.post(
//                                           Uri.parse(
//                                               "https://yoursportzbackend.azurewebsites.net/api/tournament/group-teams/"),
//                                           headers: <String, String>{
//                                             'Content-Type':
//                                                 'application/json; charset=UTF-8',
//                                           },
//                                           body: body);
//                                       final Map<String, dynamic> responseData =
//                                           jsonDecode(response.body);
//                                       if (responseData['message'] ==
//                                           "success") {
//                                         Navigator.pop(context);
//                                         Navigator.pop(context);
//                                         Navigator.pop(context);
//                                         context.navigateTo(
//                                           OngoingTournamentRoute(
//                                               phone: widget.phone),
//                                         );
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(const SnackBar(
//                                                 content: Row(
//                                                   children: [
//                                                     Text(
//                                                         "Teams Grouped Successfully",
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.white)),
//                                                     SizedBox(width: 8),
//                                                     Icon(Icons.done_all,
//                                                         color: Colors.white)
//                                                   ],
//                                                 ),
//                                                 backgroundColor: Colors.green));
//                                       } else {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(const SnackBar(
//                                                 content: Text(
//                                                     "Server Error. Failed to group teams !!!",
//                                                     style: TextStyle(
//                                                         color: Colors.white)),
//                                                 backgroundColor: Colors.red,
//                                                 duration:
//                                                     Duration(seconds: 3)));
//                                       }
//                                       setState(() {
//                                         isLoading = false;
//                                       });
//                                     }
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       backgroundColor: const Color(0xff554585)),
//                                   child: isLoading
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(4),
//                                           child: Transform.scale(
//                                             scale: 0.5,
//                                             child:
//                                                 const CircularProgressIndicator(
//                                                     color: Colors.white),
//                                           ))
//                                       : Padding(
//                                           padding: const EdgeInsets.all(12),
//                                           child: Text(
//                                               currentSelection <
//                                                       int.parse(
//                                                           widget.numberOfGroups)
//                                                   ? 'Next'
//                                                   : 'Save Changes',
//                                               style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.bold)),
//                                         ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : const SizedBox()
//               ],
//             ),
//     );
//   }
// }
//
// class TeamCard extends StatelessWidget {
//   const TeamCard(
//       {super.key,
//       required this.teamLogo,
//       required this.teamName,
//       required this.city,
//       required this.addTeam});
//
//   final String teamLogo;
//   final String teamName;
//   final String city;
//   final Function() addTeam;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Row(
//           children: [
//             CircleAvatar(
//                 radius: 25,
//                 backgroundColor: Colors.transparent,
//                 child: ClipOval(
//                     child: Image.network(
//                   teamLogo,
//                   height: 50,
//                   width: 50,
//                   loadingBuilder: (BuildContext context, Widget child,
//                       ImageChunkEvent? loadingProgress) {
//                     if (loadingProgress == null) {
//                       return child;
//                     }
//                     return Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: CircularProgressIndicator(
//                           value: loadingProgress.expectedTotalBytes != null
//                               ? loadingProgress.cumulativeBytesLoaded /
//                                   loadingProgress.expectedTotalBytes!
//                               : null,
//                         ),
//                       ),
//                     );
//                   },
//                   errorBuilder: (BuildContext context, Object exception,
//                       StackTrace? stackTrace) {
//                     return Image.asset(
//                       'assets/images/app_logo.png',
//                       height: 50,
//                     );
//                   },
//                 ))),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                     teamName.length <= 15
//                         ? teamName
//                         : teamName.substring(0, 15),
//                     style: const TextStyle(
//                         color: Color.fromARGB(255, 107, 89, 161),
//                         fontSize: 17)),
//                 Text(
//                   city.length <= 15 ? city : city.substring(0, 15),
//                   style: const TextStyle(color: Colors.grey),
//                 )
//               ],
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 addTeam();
//               },
//               style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   backgroundColor: const Color(0xff554585)),
//               child: const Text('ADD',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
