import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/presentation/chat/player%20chat/all_player_model.dart';
import 'package:yoursportz/utils/toast.dart';

class StartMatchVM extends ChangeNotifier {
  TeamModel? homeTeam;
  TeamModel? opponentTeam;
  String? timeSlot;
  DateTime? date;
  List<String> homeSelectedPlayerIdList = [];
  List<String> opponentSelectedPlayerIdList = [];

  String? selectedRound;
  String? selectedGroup1;
  String? selectedGroup2;
  int? selectedNumberOfPlayer;
  String? selectedGround;

  onInitStartMatchPage() {
    homeTeam = null;
    opponentTeam = null;
    timeSlot = null;
    date = null;
    selectedRound = null;
    selectedGroup1 = null;
    selectedGroup2 = null;
    selectedNumberOfPlayer = null;
    selectedGround = null;
    // select player page
    homeSelectedPlayerIdList = [];
    opponentSelectedPlayerIdList = [];
    // toss page
    tossResult = "Heads or Tails?";
    callerTeamId = null;
    tossWonTeamId = null;
    winnerDecidedTo = null;
    // create match
    isLoadingCreateMatch = false;
    notifyListeners();
  }

  /// startMatch Page

  void changeHomeTeam(TeamModel? newTeam) {
    homeTeam = newTeam;
    notifyListeners();
  }

  void changeOpponentTeam(TeamModel? newTeam) {
    opponentTeam = newTeam;
    notifyListeners();
  }

  void changeTimeSlot(String? newSlot) {
    timeSlot = newSlot;
    notifyListeners();
  }

  void changeDate(DateTime? newDate) {
    date = newDate;
    notifyListeners();
  }

  void changeSelectedRound(String? val) {
    selectedRound = val;
    notifyListeners();
  }

  void changeSelectedGroup1(String? newValue) {
    selectedGroup1 = newValue;
    notifyListeners();
  }

  void changeSelectedGroup2(String? newValue) {
    selectedGroup2 = newValue;
    notifyListeners();
  }

  void changeSelectedNumberOfPlayer(int? newValue) {
    selectedNumberOfPlayer = newValue;
    notifyListeners();
  }

  void changeSelectedGround(String? newValue) {
    selectedGround = newValue;
    notifyListeners();
  }

  /// Select player page

  onChangeHomeTeamPlayerPosition({required String playerId, required String position}) {
    print("onChangeHomeTeamPlayerPosition => $position");
    int index = homeTeam?.players?.indexWhere((element) => element.id == playerId) ?? -1;
    if (index >= 0) {
      homeTeam?.players?[index].position = position;
    }
    notifyListeners();
  }

  onChangeOpponentTeamPlayerPosition({required String playerId, required String position}) {
    int index = opponentTeam?.players?.indexWhere((element) => element.id == playerId) ?? -1;
    if (index >= 0) {
      opponentTeam?.players?[index].position = position;
    }
    notifyListeners();
  }

  onSelectHomePlayer(String playerId) {
    if (homeSelectedPlayerIdList.contains(playerId)) {
      homeSelectedPlayerIdList.remove(playerId);
    } else {
      homeSelectedPlayerIdList.add(playerId);
    }
    notifyListeners();
  }

  onSelectOpponentPlayer(String playerId) {
    if (opponentSelectedPlayerIdList.contains(playerId)) {
      opponentSelectedPlayerIdList.remove(playerId);
    } else {
      opponentSelectedPlayerIdList.add(playerId);
    }
    notifyListeners();
  }

  checkHomeTeamSelectedPlayerHaveGoalKeeper() {
    List l = (homeTeam?.players ?? [])
        .where((element) =>
            homeSelectedPlayerIdList.contains(element.id) && element.position == "Goalkeeper")
        .toList();
    return l.isNotEmpty;
  }

  checkOpponentTeamSelectedPlayerHaveGoalKeeper() {
    List l = (opponentTeam?.players ?? [])
        .where((element) =>
            opponentSelectedPlayerIdList.contains(element.id) && element.position == "Goalkeeper")
        .toList();
    return l.isNotEmpty;
  }

  /// For Selected Team View Page

  // home team
  List<Player> get getSelectedHomeTeam => (homeTeam?.players ?? [])
      .where((element) => homeSelectedPlayerIdList.contains(element.id))
      .toList();

  List<Player> get getSelectedHomeTeamWithoutGoalkeeper =>
      getSelectedHomeTeam.where((element) => element.position != "Goalkeeper").toList();

  Player? get getHomeTeamGoalkeeper =>
      getSelectedHomeTeam.firstWhereOrNull((element) => element.position == "Goalkeeper");

  // opponent team
  List<Player> get getSelectedOpponentTeam => (opponentTeam?.players ?? [])
      .where((element) => opponentSelectedPlayerIdList.contains(element.id))
      .toList();

  Player? get getOpponentTeamGoalkeeper =>
      getSelectedOpponentTeam.firstWhereOrNull((element) => element.position == "Goalkeeper");

  List<Player> get getSelectedOpponentTeamWithoutGoalkeeper =>
      getSelectedOpponentTeam.where((element) => element.position != "Goalkeeper").toList();

  // Toss Page

  String tossResult = "Heads or Tails?";
  String? callerTeamId;
  String? tossWonTeamId;
  String? winnerDecidedTo; // "Kick-Off","Defence"
  bool isFromVirtualToss = false;

  void tossCoin() {
    final random = Random();
    tossResult = random.nextBool() ? "Heads" : "Tails";
    showToast("Toss Flip Successfully... Winner is $tossResult", Colors.green);
    notifyListeners();
  }

  void changeCallerTeamId(String? newValue) {
    callerTeamId = newValue;
    notifyListeners();
  }

  void changeTossWonTeamId(String? newValue) {
    tossWonTeamId = newValue;
    notifyListeners();
  }

  void changeWinnerDecidedTo(String? newValue) {
    winnerDecidedTo = newValue;
    notifyListeners();
  }

  void changeIsFromVirtualToss(bool newValue) {
    isFromVirtualToss = newValue;
    notifyListeners();
  }

  // Create Match

  bool isLoadingCreateMatch = false;

  void changeIsLoadingCreateMatch(bool val) {
    isLoadingCreateMatch = val;
    notifyListeners();
  }

  Future createMatch({required TournamentData selectedTournament, required String phone}) async {
    if (callerTeamId == null) {
      showToast(tr(LocaleKeys.please_select_caller_first), Colors.orange);
      return;
    } else if (tossWonTeamId == null) {
      showToast(tr(LocaleKeys.please_select_team_won_toss), Colors.orange);
      return;
    } else if (winnerDecidedTo == null) {
      showToast(tr(LocaleKeys.please_select_kickoff_or_defence), Colors.orange);
      return;
    }
    changeIsLoadingCreateMatch(true);

    final body = jsonEncode(<String, dynamic>{
      'tournamentId': selectedTournament.tournamentId,
      'groupName': selectedGroup1,
      'time': timeSlot,
      'location': selectedGround,
      'homeTeam': homeTeam?.toJson(),
      'opponentTeam': opponentTeam?.toJson(),
      'phone': phone,
      // 'scorer': [widget.selectedScorer1?.toJson(), widget.selectedScorer2?.toJson()],
      'caller': callerTeamId,
      'tossWon': tossWonTeamId,
    });

    final initialResponse = await http.post(
      Uri.parse("https://yoursportzbackend.azurewebsites.net/api/tournament/create-match"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    changeIsLoadingCreateMatch(false);
    final Map<String, dynamic> responseData = jsonDecode(initialResponse.body);
    if (responseData['message'] == "success") {
      return true;
    } else {
      showToast(tr(LocaleKeys.failed_to_upload_data_to_server), Colors.red);
    }
  }

  // Match Officials

  List<AllPlayerModel> allPlayers = [];
  bool isLoadingFetchAllPlayer = false;

  AllPlayerModel? scorer1;
  AllPlayerModel? scorer2;

  void changeIsLoadingFetchAllPlayer(bool val) {
    isLoadingFetchAllPlayer = val;
    notifyListeners();
  }

  Future<void> fetchAllPlayers() async {
    changeIsLoadingFetchAllPlayer(true);
    final response =
        await http.get(Uri.parse('https://yoursportzbackend.azurewebsites.net/api/user/all'));
    changeIsLoadingFetchAllPlayer(false);
    if (response.statusCode == 200) {
      final List<dynamic> playerJson = json.decode(response.body);
      allPlayers = playerJson.map((json) => AllPlayerModel.fromJson(json)).toList();
    } else {
      showToast("Failed to load players", Colors.red);
    }
  }

  void changeScorer1(AllPlayerModel? newValue) {
    scorer1 = newValue;
    notifyListeners();
  }

  void changeScorer2(AllPlayerModel? newValue) {
    scorer2 = newValue;
    notifyListeners();
  }
}
