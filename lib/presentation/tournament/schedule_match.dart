import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';

class Schedule_match extends StatefulWidget {
  final TournamentData tournament;
  final String phone;
  const Schedule_match(
      {super.key, required this.tournament, required this.phone});

  @override
  State<Schedule_match> createState() => _Schedule_matchState();
}

class _Schedule_matchState extends State<Schedule_match> {
  String? _selectedValueGroup;
  List<String> _dropdownItems = [];
  List<dynamic> _selectedGroupTeams = [];
  Map<String, dynamic>? _selectedHomeTeam;
  Map<String, dynamic>? _selectedOpponentTeam;
  final TextEditingController _timeSlotController = TextEditingController();
  final TextEditingController _dateSlotController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeDropdownItems();
  }

  void _initializeDropdownItems() {
    final groupCount = widget.tournament.groupedTeams!.length;
    _dropdownItems = List.generate(
        groupCount, (index) => 'Group ${String.fromCharCode(65 + index)}');
  }

  void _pickHomeTeam() {
    if (_selectedGroupTeams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a group first')),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: _selectedGroupTeams.map((team) {
            return ListTile(
              leading: Image.network(
                team['logo'] ?? '',
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
                      text: team['name'],
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
                      text: team['city'],
                      style: GoogleFonts.inter(),
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedHomeTeam = team;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _pickOpponentTeam() {
    if (_selectedGroupTeams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a group first')),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: _selectedGroupTeams
              .where((team) => team != _selectedHomeTeam)
              .map((team) {
            return ListTile(
              leading: Image.network(
                team['logo'] ?? '',
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
                      text: team['name'],
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
                      text: team['city'],
                      style: GoogleFonts.inter(),
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedOpponentTeam = team;
                });
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
        _timeSlotController.text = pickedTime.format(context);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 100),
      lastDate: DateTime(currentDate.year + 100),
    );
    if (selectedDate != null && selectedDate != currentDate) {
      String formattedDate = "${selectedDate.toLocal()}".split(' ')[0];

      setState(() {
        _dateSlotController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'Schedule A Match',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        titleSpacing:
            -8, // This removes the space between the title and the leading icon
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/images/start_match_bg.png"),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0, left: 8),
                  child: Row(
                    children: [
                      Image.asset("assets/images/start_match_tourlogo.png"),
                      const SizedBox(
                        width: 9,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.tournament.tournamentName!,
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            "${widget.tournament.city}",
                            style: GoogleFonts.inter(
                                fontSize: 13, color: Colors.white),
                          ),
                          Text(
                            "${widget.tournament.startDate}-${widget.tournament.endDate}",
                            style: GoogleFonts.inter(
                                fontSize: 13, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Group',
                    style: GoogleFonts.inter(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFF7A7A7A), width: 1.2),
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedValueGroup,
                        hint: Text(
                          'Choose an option',
                          style: GoogleFonts.inter(),
                        ),
                        items: _dropdownItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValueGroup = newValue;
                            _selectedGroupTeams =
                                widget.tournament.groupedTeams![
                                    _dropdownItems.indexOf(newValue!)];
                          });
                        },
                        isExpanded: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Time Slot',
                    style: GoogleFonts.inter(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFF7A7A7A), width: 1.2),
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    child: TextField(
                      controller: _timeSlotController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Type here',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: Icon(Icons.access_time_rounded),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      onTap: () => _selectTimeSlot(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date',
                    style: GoogleFonts.inter(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFF7A7A7A), width: 1.2),
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    child: TextField(
                      controller: _dateSlotController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Enter date',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: Icon(Icons.date_range),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      onTap: () => _selectDate(context),
                    ),
                  ),

                  const SizedBox(height: 20.0), // Spacing between icon and text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _pickHomeTeam,
                        child: Container(
                          height: 103.0,
                          width: 152,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF7A7A7A), width: 1.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _selectedHomeTeam != null
                                  ? Column(
                                      children: [
                                        Image.network(
                                          _selectedHomeTeam!['logo'] ?? '',
                                          height: 40,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            "assets/images/app_icon.png",
                                            height: 40,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          _selectedHomeTeam!['name'],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        const Icon(
                                          Icons.add_circle_outline,
                                          size: 40.0,
                                          color: Color(0xFF7A7A7A),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          'Pick Home Team',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickOpponentTeam,
                        child: Container(
                          height: 103.0,
                          width: 152,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF7A7A7A), width: 1.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _selectedOpponentTeam != null
                                  ? Column(
                                      children: [
                                        Image.network(
                                          _selectedOpponentTeam!['logo'] ?? '',
                                          height: 40,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            "assets/images/app_icon.png",
                                            height: 40,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          _selectedOpponentTeam!['name'],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        const Icon(
                                          Icons.add_circle_outline,
                                          size: 40.0,
                                          color: Color(0xFF7A7A7A),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          'Pick Opponent Team',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_selectedHomeTeam != null && _selectedOpponentTeam != null) {
                scheduleMatchRequest(
                  context: context,
                  tournamentId: widget.tournament.tournamentId!,
                  groupName: _selectedValueGroup!,
                  time: _timeSlotController.text,
                  phone: widget.phone,
                  date: _dateSlotController.text,
                  opponentTeam: _selectedOpponentTeam.toString(),
                  homeTeam: _selectedHomeTeam.toString(),
                );
                // print('Opponent Team from function: $_selectedOpponentTeam');
                // print('opponent team ${_selectedOpponentTeam.toString()}');
              } else {
                // Handle the case where one or both teams are not selected
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Please select both home and opponent teams')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              backgroundColor: const Color(0xff554585),
              padding: const EdgeInsets.symmetric(vertical: 13.0),
            ),
            child: Text(
              "Schedule Match",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Api function of Schedule a match

  Future<void> scheduleMatchRequest({
    required BuildContext context, // Add BuildContext parameter
    required String tournamentId,
    required String groupName,
    required String time,
    required String phone,
    required String date,
    required String homeTeam,
    required String opponentTeam,
  }) async {
    const url =
        'https://yoursportzbackend.azurewebsites.net/api/tournament/create-match'; // Replace with your API URL

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'tournamentId': tournamentId,
      'groupName': groupName,
      'time': time,
      'phone': phone,
      'date': date,
      'opponentTeam': opponentTeam,
      'homeTeam': homeTeam,
    });

    // Show the snackbar when the API call starts
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.blue,
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Scheduling match...'),
          ],
        ),
        duration: Duration(
            minutes: 1), // Set a long duration so it stays until dismissed
      ),
    );

    print('this is going in body $body');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      // Dismiss the snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 201) {
        print('Request successful: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Match scheduled successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to schedule match: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Dismiss the snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
