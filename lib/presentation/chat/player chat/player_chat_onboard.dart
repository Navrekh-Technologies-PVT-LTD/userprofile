import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yoursportz/utils/color.dart';

import 'all_player_model.dart';
import 'player_to_player_chat.dart';

class PlayerChatOnboard extends StatefulWidget {
  final String phone;
  const PlayerChatOnboard({super.key, required this.phone});

  @override
  _PlayerChatOnboardState createState() => _PlayerChatOnboardState();
}

class _PlayerChatOnboardState extends State<PlayerChatOnboard> {
  List<AllPlayerModel> allPlayers = [];
  List<RecentPlayer> chatPlayers = [];
  List<AllPlayerModel> filteredPlayers = [];
  String searchQuery = "";
  final String placeholderImage = 'https://via.placeholder.com/150';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChatPlayers();
    fetchAllPlayers();
  }

  Future<void> fetchAllPlayers() async {
    final response = await http.get(
        Uri.parse('https://yoursportzbackend.azurewebsites.net/api/user/all'));

    if (response.statusCode == 200) {
      final List<dynamic> playerJson = json.decode(response.body);
      setState(() {
        allPlayers =
            playerJson.map((json) => AllPlayerModel.fromJson(json)).toList();
        filteredPlayers = allPlayers;
      });
    } else {
      throw Exception('Failed to load players');
    }
  }

  /// function to fetch the recent chat with players
  Future<void> fetchChatPlayers() async {
    final response = await http.post(
      Uri.parse(
          'https://yoursportzbackend.azurewebsites.net/api/chat/get-player-chats'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'phone': widget.phone}),
    );
    if (response.statusCode == 200) {
      print('player chat response ${response.body}');
      final List<dynamic> playerJson = json.decode(response.body);
      setState(() {
        chatPlayers =
            playerJson.map((json) => RecentPlayer.fromJson(json)).toList();
        filteredPlayers = allPlayers;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load chat players');
    }
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      if (searchQuery.isEmpty) {
        filteredPlayers = allPlayers;
      } else {
        filteredPlayers = allPlayers
            .where((player) =>
                player.name.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  /// Function to start player to player chat
  Future<void> fetchChatDetails(String phone1, String phone2) async {
    const url =
        'https://yoursportzbackend.azurewebsites.net/api/chat/create-player-to-player-chat'; // Replace with your actual API endpoint
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'phone1': phone1,
      'phone2': phone2,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        print(response.statusCode);
        final data = jsonDecode(response.body);

        // Extract the user details
        final members = data['members'];
        for (var member in members) {
          final userName1 = member['name'];
          final userDp1 = member['dp'];
          final chatId1 = data['chatId'];
          print('User Name: $userName1');
          print('User DP: $userDp1');

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayerToPlayerChat(
                      userName: userName1,
                      userDp: userDp1,
                      chatId: chatId1,
                      myPhone: widget.phone)));
          break;
        }
      } else if (response.statusCode == 403) {
        print(response.statusCode);
        final data = jsonDecode(response.body);
        print('response of alredy user ${response.body}');
        // Extract the user details
        final members = data['members'];
        for (var member in members) {
          final userName1 = member['name'];
          final userDp1 = member['dp'];
          final chatId1 = data['chatId'];
          print('User already  Name: $userName1');
          print('User DP: $userDp1');

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayerToPlayerChat(
                      userName: userName1,
                      userDp: userDp1,
                      chatId: chatId1,
                      myPhone: widget.phone)));
          break;
        }
      } else {
        print(
            'Failed to load chat details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 130,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: ((context) => BeginMatch()
            //
            //         )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Message",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 240, 245),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 0.5,
                          color: const Color(0xff7A7A7A),
                        ),
                      ),
                      child: TextField(
                        onChanged: updateSearchQuery,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xff7A7A7A),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 7),
                          hintText: "Search message",
                          hintStyle: TextStyle(
                            color: Color(0xff7A7A7A),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: searchQuery.isEmpty
                ? _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: chatPlayers.length,
                        itemBuilder: (context, index) {
                          final player = chatPlayers[index];
                          final member = player.members.firstWhere(
                            (member) => member.phone != widget.phone,
                            orElse: () => Member(
                                phone: 'N/A',
                                name: 'Unknown',
                                dp: placeholderImage),
                          );
                          //if (member == null) return const SizedBox.shrink();
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  member.dp.isEmpty
                                      ? placeholderImage
                                      : member.dp,
                                ),
                              ),
                              title: Text(
                                member.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(player.lastMessage.isEmpty
                                  ? 'hello'
                                  : player.lastMessage),
                              trailing: Text(player.lastMessageDate.isEmpty
                                  ? '02-8-24'
                                  : player.lastMessageDate),
                              onTap: () {
                                print('tap on home');

                                /// we go to chat screen from here this is on home
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerToPlayerChat(
                                      userName: member.name,
                                      userDp: member.dp,
                                      myPhone: widget.phone,
                                      chatId: chatPlayers[index].chatId,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredPlayers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                filteredPlayers[index].dp.isEmpty
                                    ? placeholderImage
                                    : filteredPlayers[index].dp,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              filteredPlayers[index].name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                fetchChatDetails(
                                  filteredPlayers[index].phone,
                                  widget.phone,
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.center,
                                height: 35,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: TColor.textfield,
                                    border:
                                        Border.all(color: TColor.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text("Message"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
