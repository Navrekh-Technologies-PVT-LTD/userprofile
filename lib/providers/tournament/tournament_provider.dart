import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/domain/tournament/imp_tournament_repo.dart';
import 'package:yoursportz/domain/tournament/team_entity.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/utils/google_map_api.dart';
import 'package:yoursportz/utils/logger.dart';
import 'package:yoursportz/utils/toast.dart';

enum TournamentState { idle, loading, success }

@injectable
class TournamentProvider extends ChangeNotifier {
  ImpTournamentRepository repo;
  TournamentProvider(this.repo);

  TournamentState tournamentStates = TournamentState.idle;
  TextEditingController tournamentNameController = TextEditingController();
  TextEditingController orgNameController = TextEditingController();
  TextEditingController orgContactController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController groundNameController = TextEditingController();
  TextEditingController addMoreDetailsController = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  final MapController mapController = MapController();
  List<String> places = [];
  bool isLoading = false;
  bool isLoadingCreateTournament = false;
  TournamentData? selectedTournament;
  int selectedPointTableGroupIndex = 0;

  void setSelectedTournament(TournamentData val) {
    selectedTournament = val;
    notifyListeners();
  }

  onInitTournamentDetailsPage() {
    selectedPointTableGroupIndex = 0;
    notifyListeners();
  }

  setSelectedPointTableGroupIndex(int val) {
    selectedPointTableGroupIndex = val;
    notifyListeners();
  }

  void onTextChanged(String query) async {
    if (query.isEmpty) {
      places = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final place = await mapController.getPlaces(query);
      log("Place : $place");
      places = place;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  String startDate = "Start date";
  String endDate = "End date";
  late File imageFile, bannerImageFile;
  var imagePath = "null", bannerImagePath = "null";
  String selectedTournamentCategory = "School";
  final DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
  String gameTime = "20 minutes";
  String firstHalf = "10 minutes";
  List<String> gameTimeList = [
    '20 minutes',
    '30 minutes',
    '40 minutes',
    '60 minutes',
    '90 minutes'
  ];
  List<String> tournamentCatList = [
    "School",
    "College",
    "University",
    "Corporate",
    "Open Tournament",
    "Other"
  ];
  String selectedNumberOfTeam = '4';
  String selectedNumberOfGroup = '1';
  List<String> numberOfTeams = [
    '4',
    '5',
    '6',
    '7',
    '8',
    '10',
    '12',
    '14',
    '16',
    '18',
    '20',
    '22',
    '24',
    '26',
    '28',
    '30'
  ];
  List<String> numberOfGroup = ['1', '2', '3', '4', '5', '6', '7'];

  void selectTournamentCategory(String value) {
    selectedTournamentCategory = value;
    notifyListeners();
  }

  void selectGameTime(String value) {
    gameTime = value;
    notifyListeners();
    if (gameTime == "20 minutes") {
      firstHalf = "10 minutes";
      notifyListeners();
    } else if (gameTime == "30 minutes") {
      firstHalf = "15 minutes";
      notifyListeners();
    } else if (gameTime == "40 minutes") {
      firstHalf = "20 minutes";
      notifyListeners();
    } else if (gameTime == "60 minutes") {
      firstHalf = "30 minutes";
      notifyListeners();
    } else if (gameTime == "90 minutes") {
      firstHalf = "45 minutes";
      notifyListeners();
    }
  }

  void getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final croppedImage = await cropImageFile(pickedFile);
      imageFile = File(croppedImage.path);
      imagePath = croppedImage.path;
      notifyListeners();
    }
  }

  void getBannerImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final croppedImage = await cropBannerImageFile(pickedFile);
      bannerImageFile = File(croppedImage.path);
      bannerImagePath = croppedImage.path;
      notifyListeners();
    }
  }

  Future<CroppedFile> cropImageFile(XFile image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Image Cropper',
            toolbarColor: const Color(0xff554585),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
      ],
    );
    return croppedFile!;
  }

  Future<CroppedFile> cropBannerImageFile(XFile image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.ratio3x2],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Image Cropper',
            toolbarColor: const Color(0xff554585),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio3x2,
            lockAspectRatio: true),
      ],
    );
    return croppedFile!;
  }

  void selectNumberOfGroup(String value) {
    selectedNumberOfGroup = value;
    notifyListeners();
  }

  void selectNumberOfTeams(String value) {
    selectedNumberOfTeam = value;
    notifyListeners();
    if (int.parse(selectedNumberOfTeam) < 8) {
      selectedNumberOfGroup = '1';
      notifyListeners();
    } else if (selectedNumberOfTeam == '8' ||
        selectedNumberOfTeam == '10' ||
        selectedNumberOfTeam == '14') {
      selectedNumberOfGroup = '1';
      numberOfGroup = ['1', '2'];
      notifyListeners();
    } else if (selectedNumberOfTeam == '12' || selectedNumberOfTeam == '18') {
      selectedNumberOfGroup = '1';
      numberOfGroup = ['1', '2', '3'];
      notifyListeners();
    } else if (selectedNumberOfTeam == '16') {
      selectedNumberOfGroup = '1';
      numberOfGroup = ['1', '2', '4'];
      notifyListeners();
    } else if (selectedNumberOfTeam == '20') {
      selectedNumberOfGroup = '2';
      numberOfGroup = ['2', '4', '5'];
      notifyListeners();
    } else if (selectedNumberOfTeam == '22' || selectedNumberOfTeam == '26') {
      selectedNumberOfGroup = '2';
      numberOfGroup = ['2'];
      notifyListeners();
    } else if (selectedNumberOfTeam == '24') {
      selectedNumberOfGroup = '2';
      numberOfGroup = ['2', '3', '4', '6'];
      notifyListeners();
    } else if (selectedNumberOfTeam == '28') {
      selectedNumberOfGroup = '2';
      numberOfGroup = ['2', '4', '7'];
      notifyListeners();
    } else if (selectedNumberOfTeam == '30') {
      selectedNumberOfGroup = '2';
      numberOfGroup = ['2', '3', '5', '6'];
      notifyListeners();
    }
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      selectedStartDate = picked;
      startDate = dateFormat.format(picked);
      notifyListeners();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      selectedEndDate = picked;
      endDate = dateFormat.format(picked);
      notifyListeners();
    }
  }

  Future createTournament(BuildContext context, String phone) async {
    isLoadingCreateTournament = true;
    notifyListeners();
    String cleanedImageUrl = "null";
    if (imagePath != "null") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Uploading logo...", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.cyan,
        duration: Duration(seconds: 2),
      ));
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://yoursportzbackend.azurewebsites.net/api/upload/'));
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
      var response = await request.send();
      final imageUrl = await response.stream.bytesToString();
      cleanedImageUrl = imageUrl.replaceAll('"', '');
    }
    String cleanedBannerImageUrl = "null";
    if (cleanedImageUrl != "error") {
      if (bannerImagePath != "null") {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Uploading banner image...", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.cyan,
              duration: Duration(seconds: 3),
            ),
          );
        }

        var request = http.MultipartRequest(
            'POST', Uri.parse('https://yoursportzbackend.azurewebsites.net/api/upload/'));
        request.files.add(await http.MultipartFile.fromPath('file', bannerImagePath));
        var response = await request.send();
        final imageUrl = await response.stream.bytesToString();
        cleanedBannerImageUrl = imageUrl.replaceAll('"', '');
      }
    }
    if (cleanedBannerImageUrl != "error") {
      final body = jsonEncode(<String, dynamic>{
        'phone': getIt<AppPrefs>().phoneNumber.getValue(),
        'logoUrl': cleanedImageUrl,
        'bannerUrl': cleanedBannerImageUrl,
        'tournamentName': tournamentNameController.text,
        'organizerName': orgNameController.text,
        'organizerPhone': orgContactController.text,
        'city': locationController.text,
        'groundNames': [groundNameController.text],
        'numberOfTeams': selectedNumberOfTeam,
        'numberOfGroups': selectedNumberOfGroup,
        'startDate': startDate,
        'endDate': endDate == "End date" ? "null" : endDate,
        'gameTime': gameTime,
        'firstHalf': firstHalf,
        'tournamentCategory': selectedTournamentCategory,
        'additionalDetails': addMoreDetailsController.text,
        'teams': [],
        'tournamentType': "null"
      });
      final response = await http.post(
          Uri.parse("https://yoursportzbackend.azurewebsites.net/api/tournament/create/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['message'] == "success") {
        isLoadingCreateTournament = false;
        getTournamentsList(getIt<AppPrefs>().phoneNumber.getValue());
        notifyListeners();
        if (context.mounted) {
          // context.navigateTo(OngoingTournamentRoute(phone: phone));
          getTournamentsList(phone);
          AutoRouter.of(context).popForced();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Row(
                  children: [
                    Text(
                      "Tournament Created Successfully",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.done_all, color: Colors.white)
                  ],
                ),
                backgroundColor: Colors.green),
          );
          clearAllCreateTournamentData();
        }
      } else {
        isLoadingCreateTournament = false;
        notifyListeners();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Server Error. Failed to create tournament !!!",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  TournamentsEntity? tournamentsEntity;
  List<TournamentData> allTournaments = [];
  Future getTournamentsList(String phoneNumber) async {
    tournamentStates = TournamentState.loading;
    notifyListeners();
    final response = await repo.getTournamentsList(phoneNumber: phoneNumber);

    if (response.statusCode == 200) {
      tournamentsEntity = TournamentsEntity.fromJson(response.data);
      allTournaments = [
        if (tournamentsEntity?.past != null) ...tournamentsEntity!.past!,
        if (tournamentsEntity?.ongoing != null) ...tournamentsEntity!.ongoing!,
        if (tournamentsEntity?.upcoming != null) ...tournamentsEntity!.upcoming!,
      ];
      tournamentStates = TournamentState.success;
      notifyListeners();
    } else {
      showToast("Something went wrong in getting tournaments", Colors.red);
      logger.e("Something went wrong in getting tournaments");
    }
  }

  void clearAllCreateTournamentData() {
    imagePath = "null";
    bannerImagePath = "null";
    tournamentNameController.clear();
    orgNameController.clear();
    orgContactController.clear();
    locationController.clear();
    groundNameController.clear();
    selectedNumberOfTeam = "4";
    selectedNumberOfGroup = "1";
    startDate = "Start date";
    endDate = "End date";
    gameTime = "30 minutes";
    firstHalf = "15 minutes";
    addMoreDetailsController.clear();
    isLoading = false;
    isLoadingCreateTournament = false;
    notifyListeners();
  }

  void updateEditTournamentValue(
      String bannerImage,
      String logoImage,
      String tournamentName,
      String orgName,
      String orgContact,
      String location,
      String groundName,
      String numberOfTeams,
      String numberOfGroup,
      String startDate,
      String endDate,
      String gameTime,
      String halfTime,
      String addMoreDetails) {
    imagePath = bannerImage;
    bannerImagePath = logoImage;
    tournamentNameController.text = tournamentName;
    orgNameController.text = orgName;
    orgContactController.text = orgContact;
    locationController.text = location;
    groundNameController.text = groundName;
    selectedNumberOfTeam = numberOfTeams;
    selectedNumberOfGroup = numberOfGroup;
    this.startDate = startDate;
    this.endDate = endDate;
    this.gameTime = gameTime;
    firstHalf = halfTime;
    addMoreDetailsController.text = addMoreDetails;
    notifyListeners();
  }

  Future updateTournamentData(String tournamentId, BuildContext context) async {
    tournamentStates = TournamentState.loading;
    notifyListeners();

    final response = await repo.updateTournamentData(
      bannerImage: imagePath,
      logoImage: bannerImagePath,
      tournamentName: tournamentNameController.text,
      orgName: orgNameController.text,
      orgContact: orgContactController.text,
      location: locationController.text,
      groundName: groundNameController.text,
      numberOfTeams: selectedNumberOfTeam,
      numberOfGroup: selectedNumberOfGroup,
      startDate: startDate,
      endDate: endDate,
      gameTime: gameTime,
      halfTime: firstHalf,
      addMoreDetails: addMoreDetailsController.text,
      tournamentId: tournamentId,
    );
    if (response.statusCode == 200) {
      clearAllCreateTournamentData();
      tournamentStates = TournamentState.success;
      showToast("Tournament data updated successfully", Colors.green);
      notifyListeners();
      if (context.mounted) {
        // AutoRouter.of(context).push(
        //   OngoingTournamentRoute(
        //     phone: getIt<AppPrefs>().phoneNumber.getValue(),
        //   ),
        // );

        TournamentData updatedData = TournamentData.fromJson(response.data["data"]);

        int index = allTournaments.indexWhere((element) => element.id == updatedData.id);

        if (index >= 0) {
          updatedData.status = allTournaments[index].status;
          allTournaments[index] = updatedData;
        }

        AutoRouter.of(context).popForced(updatedData);
      }
      notifyListeners();
    } else {
      showToast("Something went wrong in updating tournament", Colors.red);
      logger.e("Something went wrong in updating tournament");
    }
  }

  //   Future<void> fetchTournamentChatId(String tournamentId) async {
  //   final response = await http.post(
  //     Uri.parse(
  //         'https://yoursportzbackend.azurewebsites.net/api/chat/get-by-tournament-id'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({"tournamentId": tournamentId}),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     print('response ------ ${response.body}');
  //     tournamentChatId = data['chatId'];
  //   } else {
  //     throw Exception('Failed to load chat ID');
  //   }
  // }
  String filterText = "";
  List<TeamModel> teamList = [];
  List<TeamModel> finalTeamList = [];
  List<TeamModel> selectedTeamList = [];

  void searchTeamFilterText(String value) {
    filterText = value;
    if (value.isEmpty) {
      finalTeamList = teamList;
      notifyListeners();
    } else {
      finalTeamList = teamList.where((team) {
        return team.name!.toLowerCase().contains(filterText.toLowerCase());
      }).toList();
      notifyListeners();
    }
  }

  bool isLoadingGetAllTeam = false;

  setIsLoadingGetAllTeam(bool val) {
    isLoadingGetAllTeam = val;
    notifyListeners();
  }

  Future getAllTeams(List<TeamModel> data) async {
    setIsLoadingGetAllTeam(true);
    selectedTeamList = data.map((e) => e).toList();
    notifyListeners();
    final response =
        await http.get(Uri.parse("https://yoursportzbackend.azurewebsites.net/api/team/all/"));
    setIsLoadingGetAllTeam(false);
    if (response.statusCode == 200) {
      teamList = teamEntityFromJson(response.body);
      finalTeamList = teamEntityFromJson(response.body);
      notifyListeners();
    } else {
      logger.e("Something went wrong in getting teams");
    }
  }

  void addTeamToSelectedTeamList(String numberofteams, TeamModel team) {
    int i = selectedTeamList.indexWhere((element) => element.id == team.id);

    if (i >= 0) {
      selectedTeamList.removeAt(i);
    } else {
      if (selectedTeamList.length >= int.parse(numberofteams)) {
        showToast("Can't add more then $numberofteams", Colors.red);
      } else {
        selectedTeamList.add(team);
      }
    }
    notifyListeners();
  }

  bool isLoadingAddTeams = false;

  setIsLoadingAddTeams(bool val) {
    isLoadingAddTeams = val;
    notifyListeners();
  }

  Future addTeamToTournament(BuildContext context, String tournamentId) async {
    setIsLoadingAddTeams(true);
    final response =
        await repo.addTeamToTournament(tournamentId: tournamentId, teamList: selectedTeamList);
    setIsLoadingAddTeams(false);
    if (response.statusCode == 200) {
      showToast("Teams Save to the tournament successfully", Colors.green);
      if (context.mounted) {
        // AutoRouter.of(context).pushAll([
        //   OngoingTournamentRoute(
        //       phone: getIt<AppPrefs>().phoneNumber.getValue())
        // ]);
        AutoRouter.of(context).popForced();

        // update current tournament
        selectedTournament?.teams = selectedTeamList.map((e) => e).toList();

        // update all list
        int index = allTournaments.indexWhere((element) => element.id == selectedTournament?.id);

        if (index >= 0) {
          allTournaments[index] = selectedTournament!;
        }

        // clear list
        teamList.clear();
        finalTeamList.clear();
        selectedTeamList.clear();
        notifyListeners();
      }
    } else {
      showToast("Something went wrong in add teams", Colors.red);
      logger.e("Something went wrong in add teams");
    }
  }

  /// Group Team Page

  List<List<TeamModel>> teamGroups = [];
  int numberOfGroups = 0;
  int maxTeamPerGroup = 0;
  int currentGroupIndex = 0;
  String searchTextForGroupTeamPage = "";

  initGroupTeamPage() {
    searchTextForGroupTeamPage = "";
    isLoadingAddGroups = false;
    numberOfGroups = int.tryParse(selectedTournament?.numberOfGroups ?? "0") ?? 0;
    if (numberOfGroups > 0) {
      int numberOfTeams = int.tryParse(selectedTournament?.numberOfTeams ?? "0") ?? 0;
      if (numberOfTeams > 0) {
        maxTeamPerGroup = numberOfTeams ~/ numberOfGroups;
      }
    }
    teamGroups = List.generate(numberOfGroups, (index) => <TeamModel>[]).toList();
    currentGroupIndex = 0;
    log("maxTeamPerGroup => $maxTeamPerGroup");
    log("numberOfGroups => $numberOfGroups");
    log("teamGroups => $teamGroups");
    notifyListeners();
  }

  setSearchTextForGroupTeamPage(String val) {
    searchTextForGroupTeamPage = val;
    notifyListeners();
  }

  onTapAddTeamInGroup(TeamModel val) {
    if (teamGroups[currentGroupIndex].length >= maxTeamPerGroup) {
      showToast("You Can Add Max $maxTeamPerGroup Team in Group", Colors.red);
      return;
    }
    teamGroups[currentGroupIndex].add(val);
    notifyListeners();
  }

  onTapRemoveTeamFromGroup(int index) {
    teamGroups[currentGroupIndex].removeAt(index);
    notifyListeners();
  }

  bool isLoadingAddGroups = false;

  setIsLoadingAddGroups(bool val) {
    isLoadingAddGroups = val;
    notifyListeners();
  }

  bool get isShowNext => currentGroupIndex < (numberOfGroups - 1);

  onTapSaveGroup(context) async {
    if (teamGroups[currentGroupIndex].length < maxTeamPerGroup) {
      showToast("Please Select $maxTeamPerGroup Teams", Colors.red);
      return;
    }
    if (currentGroupIndex < (numberOfGroups - 1)) {
      currentGroupIndex++;
      notifyListeners();
      return;
    } else {
      setIsLoadingAddGroups(true);
      final body = jsonEncode(<String, dynamic>{
        'tournamentId': selectedTournament?.tournamentId,
        'groupedTeams': teamGroups
      });
      final response = await http.post(
        Uri.parse("https://yoursportzbackend.azurewebsites.net/api/tournament/group-teams/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['message'] == "success") {
        // update current tournament
        selectedTournament?.groupedTeams = teamGroups;

        // update all list
        int index = allTournaments.indexWhere((element) => element.id == selectedTournament?.id);

        if (index >= 0) {
          allTournaments[index] = selectedTournament!;
        }
        await updatedTournament();
        showToast("Teams Grouped Successfully", Colors.green);
        notifyListeners();
        AutoRouter.of(context).popForced();
        setIsLoadingAddGroups(false);
      } else {
        showToast("Server Error. Failed to group teams !!!", Colors.red);
      }
    }
  }

  Future updatedTournament() async {
    final body = jsonEncode(<String, dynamic>{
      'tournamentId': selectedTournament?.tournamentId,
    });

    final initialResponse = await http.post(
      Uri.parse("https://yoursportzbackend.azurewebsites.net/api/tournament/get-single-tournament"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    final Map<String, dynamic> responseData = jsonDecode(initialResponse.body);
    if (initialResponse.statusCode == 200) {
      TournamentData updatedData = TournamentData.fromJson(responseData);

      // update list screen
      int index = allTournaments.indexWhere((element) => element.id == updatedData.id);

      if (index >= 0) {
        updatedData.status = allTournaments[index].status;
        allTournaments[index] = updatedData;
      }
      // update selected
      selectedTournament = updatedData;
      selectedPointTableGroupIndex = 0;
      notifyListeners();
    } else {
      showToast("Tournament Update Failed", Colors.red);
    }
  }
}
