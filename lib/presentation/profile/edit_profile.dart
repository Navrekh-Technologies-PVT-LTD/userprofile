// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:yoursportz/providers/common/common_provider.dart';

import '../../gen/locale_keys.g.dart';

class EditProfile extends StatefulWidget {
  const EditProfile(
      {super.key,
      required this.phone,
      required this.userDetails,
      required this.updateUserDetails});

  final String phone;
  final Map<String, dynamic> userDetails;
  final Function(Map<String, dynamic>) updateUserDetails;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Map<String, dynamic> updatedUserDetails = {};
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final heightController = TextEditingController();
  var nameValid = true;
  var cityValid = true;
  var positionValid = true;
  var dobValid = true;
  var countryValid = true;
  var footValid = true;
  var heightValid = true;
  var dateOfBirth = "Select Birth Date";
  var playerPosition;
  var country;
  var foot;
  DateTime selectedDate = DateTime.now();
  final dateFormat = DateFormat('dd-MMM-yyyy');
  var isLoading = false;

  Future<void> selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime lastDate = DateTime(
      currentDate.year - 8,
      currentDate.month,
      currentDate.day,
    );
    final DateTime initialDate =
        selectedDate.isBefore(lastDate) ? selectedDate : lastDate;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1970),
        lastDate: lastDate);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOfBirth = dateFormat.format(picked);
        dobValid = true;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      updatedUserDetails = widget.userDetails;
      nameController.text = updatedUserDetails['name'];
      cityController.text = updatedUserDetails['city'];
      playerPosition = updatedUserDetails['position'].length == 0
          ? null
          : updatedUserDetails['position'];
      dateOfBirth = updatedUserDetails['dob'];
      country = updatedUserDetails['country'].length == 0
          ? null
          : updatedUserDetails['country'];
      foot = updatedUserDetails['foot'].length == 0
          ? null
          : updatedUserDetails['foot'];
      heightController.text = updatedUserDetails['height'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommonProvider>(
      builder: (context, commonState, _) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: Text(LocaleKeys.edit_profile.tr()),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LocaleKeys.team_name.tr(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextField(
                                  controller: nameController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30)
                                  ],
                                  onChanged: (value) {
                                    if (value.length >= 3) {
                                      setState(() {
                                        nameValid = true;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: LocaleKeys.enter_name.tr(),
                                      hintStyle: const TextStyle(
                                          fontWeight: FontWeight.normal),
                                      errorText: nameValid
                                          ? null
                                          : LocaleKeys
                                              .cant_be_less_than_3_characters
                                              .tr()),
                                ),
                                const SizedBox(height: 24),
                                Text(LocaleKeys.city.tr(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextField(
                                  controller: cityController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30)
                                  ],
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        cityValid = true;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: LocaleKeys.enter_city_name.tr(),
                                      hintStyle: const TextStyle(
                                          fontWeight: FontWeight.normal),
                                      errorText: cityValid
                                          ? null
                                          : LocaleKeys.invalid_city.tr()),
                                ),
                                const SizedBox(height: 24),
                                Text(LocaleKeys.player_position.tr(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButton<String>(
                                        hint: Text(LocaleKeys
                                            .select_player_position
                                            .tr()),
                                        value: playerPosition,
                                        onChanged: (String? value) {
                                          setState(() {
                                            playerPosition = value;
                                            positionValid = true;
                                          });
                                        },
                                        underline: Container(
                                            height: 1, color: Colors.black54),
                                        items: <String>[
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
                                          // LocaleKeys.goalkeeper.tr(),
                                          // LocaleKeys.right_back.tr(),
                                          // LocaleKeys.center_back.tr(),
                                          // LocaleKeys.left_back.tr(),
                                          // LocaleKeys.right_midfielder.tr(),
                                          // LocaleKeys.center_midfielder.tr(),
                                          // LocaleKeys.left_midfielder.tr(),
                                          // LocaleKeys.right_winger.tr(),
                                          // LocaleKeys.center_forward.tr(),
                                          // LocaleKeys.left_winger.tr(),
                                          // LocaleKeys.center_player.tr()
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal)));
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                !positionValid
                                    ? Text(
                                        LocaleKeys
                                            .please_select_player_position_first
                                            .tr(),
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.red))
                                    : const SizedBox(),
                                const SizedBox(height: 24),
                                Text(LocaleKeys.date_of_birth.tr(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                GestureDetector(
                                  onTap: () {
                                    selectDate(context);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 12, 0, 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(dateOfBirth,
                                                style: TextStyle(
                                                    color: dateOfBirth ==
                                                            "Select Birth Date"
                                                        ? Colors.grey[600]
                                                        : null,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(height: 0, color: Colors.black54),
                                !dobValid
                                    ? Text(
                                        LocaleKeys
                                            .please_select_date_of_birth_first
                                            .tr(),
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.red))
                                    : const SizedBox(),
                                const SizedBox(height: 24),
                                Text(LocaleKeys.country.tr(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButton<String>(
                                        hint: Text(
                                            LocaleKeys.select_country.tr()),
                                        value: country,
                                        onChanged: (String? value) {
                                          setState(() {
                                            country = value;
                                            countryValid = true;
                                          });
                                        },
                                        underline: Container(
                                            height: 1, color: Colors.black54),
                                        items: commonState.countryThreeLetter
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                !countryValid
                                    ? Text(
                                        LocaleKeys.please_select_country_first
                                            .tr(),
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.red))
                                    : const SizedBox(),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          LocaleKeys.preferred_foot.tr(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(
                                      child: Text(LocaleKeys.height.tr(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButton<String>(
                                        hint: Text(LocaleKeys.select_foot.tr()),
                                        value: foot,
                                        onChanged: (String? value) {
                                          setState(() {
                                            foot = value;
                                            footValid = true;
                                          });
                                        },
                                        underline: Container(height: 0),
                                        items: <String>['RIGHT', 'LEFT']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: heightController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(3)
                                        ],
                                        onChanged: (value) {
                                          if (int.parse(value) >= 120 &&
                                              int.parse(value) <= 250) {
                                            setState(() {
                                              heightValid = true;
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: LocaleKeys.cm.tr(),
                                            hintStyle: const TextStyle(
                                                fontWeight: FontWeight.normal)),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 0, color: Colors.black54),
                                !footValid
                                    ? Text(
                                        LocaleKeys
                                            .please_select_preferred_foot_first
                                            .tr(),
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.red))
                                    : const SizedBox(),
                                !heightValid
                                    ? Row(
                                        children: [
                                          const Spacer(),
                                          Text(
                                              LocaleKeys
                                                  .please_enter_valid_height_first
                                                  .tr(),
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.red)),
                                        ],
                                      )
                                    : const SizedBox(),
                              ]),
                        ),
                      ),
                      Column(
                        children: [
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (nameController.text.length < 3) {
                                      setState(() {
                                        nameValid = false;
                                      });
                                    } else if (cityController.text.isEmpty) {
                                      setState(() {
                                        cityValid = false;
                                      });
                                    } else if (playerPosition == null) {
                                      setState(() {
                                        positionValid = false;
                                      });
                                    } else if (dateOfBirth ==
                                        "Select Birth Date") {
                                      setState(() {
                                        dobValid = false;
                                      });
                                    } else if (country == null) {
                                      setState(() {
                                        countryValid = false;
                                      });
                                    } else if (foot == null) {
                                      setState(() {
                                        footValid = false;
                                      });
                                    } else if (heightController.text.isEmpty ||
                                        int.parse(heightController.text) <
                                            120 ||
                                        int.parse(heightController.text) >
                                            250) {
                                      setState(() {
                                        heightValid = false;
                                      });
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      final body = jsonEncode(<String, dynamic>{
                                        'phone': widget.phone,
                                        'name': nameController.text,
                                        'dob': dateOfBirth,
                                        'city': cityController.text,
                                        'position': playerPosition,
                                        'country': country,
                                        'foot': foot,
                                        'height': heightController.text
                                      });
                                      final response = await http.put(
                                          Uri.parse(
                                              "https://yoursportzbackend.azurewebsites.net/api/auth/update/"),
                                          headers: <String, String>{
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                          },
                                          body: body);
                                      final Map<String, dynamic> responseData =
                                          jsonDecode(response.body);
                                      if (responseData['message'] ==
                                          "success") {
                                        updatedUserDetails['name'] =
                                            nameController.text;
                                        updatedUserDetails['city'] =
                                            cityController.text;
                                        updatedUserDetails['position'] =
                                            playerPosition;
                                        updatedUserDetails['dob'] = dateOfBirth;
                                        updatedUserDetails['country'] = country;
                                        updatedUserDetails['foot'] = foot;
                                        updatedUserDetails['height'] =
                                            heightController.text;
                                        widget.updateUserDetails(
                                            updatedUserDetails);
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Row(
                                            children: [
                                              Text(
                                                  LocaleKeys
                                                      .profile_updated_successfully
                                                      .tr(),
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              const SizedBox(width: 8),
                                              const Icon(Icons.done_all,
                                                  color: Colors.white)
                                            ],
                                          ),
                                          backgroundColor: Colors.green,
                                        ));
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              LocaleKeys.server_error.tr(),
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          backgroundColor: Colors.red,
                                        ));
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
                                            child:
                                                const CircularProgressIndicator(
                                                    color: Colors.white),
                                          ))
                                      : Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                              LocaleKeys.save_changes.tr(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
