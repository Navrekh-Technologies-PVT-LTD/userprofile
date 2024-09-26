import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/core/constants.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/presentation/tournament/start_match/select_player1.dart';
import 'package:yoursportz/presentation/widgets/appbar.dart';
import 'package:yoursportz/presentation/widgets/custom_btn.dart';
import 'package:yoursportz/presentation/widgets/text_filed.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/date_format.dart';
import 'package:yoursportz/utils/size_utils.dart';
import 'package:yoursportz/utils/text_style.dart';
import 'package:yoursportz/utils/toast.dart';
import 'package:yoursportz/utils/validator.dart';

class StartMatch extends StatefulWidget {
  const StartMatch({super.key, required this.tournament, required this.phone});
  final TournamentData tournament;
  final String phone;

  @override
  State<StartMatch> createState() => _StartMatchState();
}

class _StartMatchState extends State<StartMatch> {
  List<String> _dropdownItems = [];
  List<TeamModel> _selectedGroupTeams = [];
  final TextEditingController timeSlotController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  List<String> _dropdownItems2 = [];
  List<TeamModel> _selectedGroupTeams2 = [];

  List<String> _dropdownItemsground = [];

  final List<String> _matchTypeItems = ["League Matches", "Quarter-Finals"];

  @override
  void initState() {
    super.initState();
    _initializeDropdownItems();
    _initializeDropdownItems2();
    _initializeGroundItems();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<StartMatchVM>().onInitStartMatchPage();
      },
    );
  }

  void _initializeDropdownItems() {
    final groupCount = widget.tournament.groupedTeams!.length;
    _dropdownItems =
        List.generate(groupCount, (index) => 'Group ${String.fromCharCode(65 + index)}');
  }

  void _initializeDropdownItems2() {
    final groupCount = widget.tournament.groupedTeams!.length;
    _dropdownItems2 =
        List.generate(groupCount, (index) => 'Group ${String.fromCharCode(65 + index)}');
  }

  void _initializeGroundItems() {
    _dropdownItemsground = List<String>.from(widget.tournament.groundNames ?? []);
  }

  void _pickHomeTeam() {
    if (context.read<StartMatchVM>().selectedRound == "Quarter-Finals" &&
        (_selectedGroupTeams.isEmpty || _selectedGroupTeams2.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both groups first')),
      );
      return;
    } else if (context.read<StartMatchVM>().selectedRound != "Quarter-Finals" &&
        _selectedGroupTeams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a group first')),
      );
      return;
    }
    List<TeamModel> combinedTeams = context.read<StartMatchVM>().selectedRound == "Quarter-Finals"
        ? [..._selectedGroupTeams, ..._selectedGroupTeams2]
        : _selectedGroupTeams;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: combinedTeams
              .where((team) => team.id != context.watch<StartMatchVM>().opponentTeam?.id)
              .map((team) {
            return ListTile(
              leading: Image.network(
                team.logo ?? '',
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset("assets/images/app_icon.png"),
              ),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Team name: ',
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: team.name,
                      style: GoogleFonts.inter(),
                    ),
                  ],
                ),
              ),
              subtitle: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Team city: ',
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: team.city,
                      style: GoogleFonts.inter(),
                    ),
                  ],
                ),
              ),
              onTap: () {
                context.read<StartMatchVM>().changeHomeTeam(team);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _pickOpponentTeam() {
    if (context.read<StartMatchVM>().selectedRound == "Quarter-Finals" &&
        (_selectedGroupTeams.isEmpty || _selectedGroupTeams2.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both groups first')),
      );
      return;
    } else if (context.read<StartMatchVM>().selectedRound != "Quarter-Finals" &&
        _selectedGroupTeams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a group first')),
      );
      return;
    }
    List<TeamModel> combinedTeams = context.read<StartMatchVM>().selectedRound == "Quarter-Finals"
        ? [..._selectedGroupTeams, ..._selectedGroupTeams2]
        : _selectedGroupTeams;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: combinedTeams
              .where((team) => team.id != context.watch<StartMatchVM>().homeTeam?.id)
              .map((team) {
            return ListTile(
              leading: Image.network(
                team.logo ?? '',
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset("assets/images/app_icon.png"),
              ),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Team name: ',
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: team.name,
                      style: GoogleFonts.inter(),
                    ),
                  ],
                ),
              ),
              subtitle: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Team city: ',
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: team.city,
                      style: GoogleFonts.inter(),
                    ),
                  ],
                ),
              ),
              onTap: () {
                context.read<StartMatchVM>().changeOpponentTeam(team);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> _selectTimeSlot(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        timeSlotController.text = pickedTime.format(context);
        context.read<StartMatchVM>().changeTimeSlot(timeSlotController.text);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: context.read<StartMatchVM>().date ?? DateTime.now(),
    );
    if (pickedDate != null) {
      dateController.text = getDateFormat(date: pickedDate);
      context.read<StartMatchVM>().changeDate(pickedDate);
    }
  }

  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.kBGcolors,
      appBar: customAppBarForTournament(context: context, title: "Start a Match"),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/images/start_match_bg.png",
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0, left: 8),
                    child: Row(
                      children: [
                        Image.asset("assets/images/start_match_tourlogo.png"),
                        const SizedBox(width: 9),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.tournament.tournamentName!,
                              style: style20500WhiteInter,
                            ),
                            Text(
                              "${widget.tournament.city}",
                              style: style12500GreyDAInter,
                            ),
                            Text(
                              "${widget.tournament.startDate}-${widget.tournament.endDate}",
                              style: style12500GreyDAInter,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Round',
                      style: style16600BlackSFProDisplay,
                    ),
                    h(5),
                    customDropDownFiled(
                      value: context.watch<StartMatchVM>().selectedRound,
                      hintText: 'Choose a match type',
                      validator: commonValidator(title: "Select Round"),
                      onChanged: (value) {
                        context.read<StartMatchVM>().changeSelectedRound(value);
                      },
                      items: _matchTypeItems
                          .map((e) => customDropDownMenuItem(title: e, value: e))
                          .toList(),
                    ),
                    h(16),
                    Text(
                      'Select Group',
                      style: style16600BlackSFProDisplay,
                    ),
                    h(5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: customDropDownFiled(
                            hintText: 'Choose',
                            value: context.watch<StartMatchVM>().selectedGroup1,
                            validator: commonValidator(title: "Select Group"),
                            onChanged: (value) {
                              context.read<StartMatchVM>().changeSelectedGroup1(value);
                              _selectedGroupTeams =
                                  widget.tournament.groupedTeams![_dropdownItems.indexOf(value!)];
                            },
                            items: _dropdownItems
                                .map((e) => customDropDownMenuItem(title: e, value: e))
                                .toList(),
                          ),
                        ),
                        if (context.watch<StartMatchVM>().selectedRound == "Quarter-Finals") w(8),
                        if (context.watch<StartMatchVM>().selectedRound == "Quarter-Finals")
                          Expanded(
                            child: customDropDownFiled(
                              hintText: 'Choose',
                              value: context.watch<StartMatchVM>().selectedGroup2,
                              validator: commonValidator(title: "Select Group"),
                              onChanged: (value) {
                                context.read<StartMatchVM>().changeSelectedGroup2(value);
                                _selectedGroupTeams2 = widget
                                    .tournament.groupedTeams![_dropdownItems2.indexOf(value!)];
                              },
                              items: _dropdownItems2
                                  .map((e) => customDropDownMenuItem(title: e, value: e))
                                  .toList(),
                            ),
                          ),
                      ],
                    ),
                    // h(16),
                    // Text(
                    //   'Select Ground',
                    //   style: style16600BlackSFProDisplay,
                    // ),
                    // h(5),
                    // customDropDownFiled(
                    //   value: context.watch<StartMatchVM>().selectedGround,
                    //   hintText: 'Choose an option',
                    //   onChanged: (value) {
                    //     context.read<StartMatchVM>().changeSelectedGround(value);
                    //   },
                    //   items: _dropdownItemsground
                    //       .map((e) => customDropDownMenuItem(title: e, value: e))
                    //       .toList(),
                    // ),
                    h(16),
                    Text(
                      'Number Of Players',
                      style: style16600BlackSFProDisplay,
                    ),
                    h(5),
                    customDropDownFiled(
                      value: context.watch<StartMatchVM>().selectedNumberOfPlayer,
                      hintText: 'select number of player',
                      validator: commonValidator(title: "Select Number Of Players"),
                      onChanged: (value) {
                        context.read<StartMatchVM>().changeSelectedNumberOfPlayer(value);
                      },
                      items: numberOfPlayerList
                          .map((e) => customDropDownMenuItem(title: e.toString(), value: e))
                          .toList(),
                    ),
                    h(16),
                    Text(
                      'Date',
                      style: style16600BlackSFProDisplay,
                    ),
                    h(5),
                    customTextFiled(
                      controller: dateController,
                      readOnly: true,
                      hintText: 'select date',
                      onTap: () => _selectDate(context),
                      validator: commonValidator(title: "Date"),
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/date.svg",
                            height: 22,
                            width: 22,
                          ),
                        ],
                      ),
                    ),
                    h(16),
                    Text(
                      'Time Slot',
                      style: style16600BlackSFProDisplay,
                    ),
                    h(5),
                    customTextFiled(
                      controller: timeSlotController,
                      readOnly: true,
                      hintText: 'Select time',
                      onTap: () => _selectTimeSlot(context),
                      validator: commonValidator(title: "Time Slot"),
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/time.svg",
                            height: 22,
                            width: 22,
                          ),
                        ],
                      ),
                    ),
                    h(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        pickTeamContainer(
                          onTap: _pickHomeTeam,
                          title: 'Pick Home Team',
                          selectedTeam: context.watch<StartMatchVM>().homeTeam,
                        ),
                        w(16),
                        pickTeamContainer(
                          onTap: _pickOpponentTeam,
                          title: 'Pick Opponent Team',
                          selectedTeam: context.watch<StartMatchVM>().opponentTeam,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: customButtonForTournament(
        title: "Start Match",
        onTap: () {
          if (key.currentState!.validate()) {
            if (context.read<StartMatchVM>().homeTeam == null ||
                context.read<StartMatchVM>().opponentTeam == null) {
              showToast("Please select both home and opponent teams", Colors.red);
              return;
            }

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SelectPlayerOne(phone: widget.phone)));
          }
        },
        margin: const EdgeInsets.all(16).copyWith(top: 8),
      ),
    );
  }

  pickTeamContainer(
      {required VoidCallback onTap, required String title, required TeamModel? selectedTeam}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 103.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: TColor.borderColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
            color: TColor.white,
          ),
          child: selectedTeam != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      selectedTeam.logo ?? '',
                      height: 40,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/images/app_icon.png",
                        height: 40,
                      ),
                    ),
                    h(16),
                    Text(
                      (selectedTeam.name ?? ""),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: style14500BlackInter,
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 40.0,
                      color: TColor.borderColor,
                    ),
                    h(16),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: style14500BlackInter,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
