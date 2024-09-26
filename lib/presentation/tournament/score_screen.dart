// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/domain/tournament/player_model.dart';
import 'package:yoursportz/presentation/widgets/custom_dialog.dart';
import 'package:yoursportz/presentation/widgets/custom_dropdonwbutton.dart';
import 'package:yoursportz/presentation/widgets/custom_score_bar_widget.dart';
import 'package:yoursportz/presentation/widgets/custom_textfeild.dart';
import 'package:yoursportz/providers/common/common_provider.dart';

import 'final_score_screen.dart';
import 'penalty_shootout_screen.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  String? timePickerText = "14:44";
  TextEditingController goldenGoal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CommonProvider>(
      builder: (context, commonState, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFE8E8E8),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Match Name"),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Image.asset(
                "assets/images/drawer.png",
                height: 10.h,
                width: 10.w,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const StaticsScreen()));
                  },
                  icon: const Icon(Icons.more_vert))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                top: 5.h,
                right: 10.sp,
              ),
              child: Column(
                children: [
                  CustomScoreBarWedget(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    // padding: const EdgeInsets.all(5),
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                title: 'Decisive Showdown',
                                Content: SizedBox(
                                  height: 175.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const CustomDropdownButton(
                                        hint: "Penalty Shootout",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 35.h,
                                        width: double.infinity,
                                        child: TextFieldCustom(
                                          borderSide: true,
                                          controller: goldenGoal,
                                          hintText: 'Golden Goal',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 35.h,
                                        width: double.infinity,
                                        child: TextFieldCustom(
                                          borderSide: true,
                                          controller: goldenGoal,
                                          hintText: 'Add Extra Time',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 35.h,
                                        width: double.infinity,
                                        child: TextFieldCustom(
                                          borderSide: true,
                                          controller: goldenGoal,
                                          hintText: 'End The Match',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonDialog1(
                                          ButtonName: 'Cancel',
                                          color: const Color(0xFFE0DEDE)),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          showAlertDialog(
                                              context: context,
                                              title: 'Penalty Shootout',
                                              Content: SizedBox(
                                                height: 58.h,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        'Select Players for Shootout',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )),
                                                    const CustomDropdownButton(
                                                      hint:
                                                          "3 Players Shootout",
                                                      itemList: StaticVariable
                                                          .PlayerNamelist,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    CustomButtonDialog1(
                                                        ButtonName: 'Cancel',
                                                        color: const Color(
                                                            0xFFE0DEDE)),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: CustomButtonDialog1(
                                                          ButtonName: 'Done',
                                                          color: const Color(
                                                              0xFF007AFF)),
                                                    ),
                                                  ],
                                                )
                                              ]);
                                        },
                                        child: CustomButtonDialog1(
                                            ButtonName: 'Next',
                                            color: const Color(0xFF007AFF)),
                                      ),
                                    ],
                                  )
                                ]);
                          },
                          child: Container(
                            height: 100.h,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xFF007AFF), width: 2),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  // Set shadow color with 25% opacity
                                  offset: Offset(0, 2),
                                  // Set the offset
                                  blurRadius: 4,
                                  // Set the blur radius
                                  spreadRadius: 0, // Set the spread radius
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/images/teama.jpg"),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Team A",
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Image.asset(
                                      "assets/images/ball.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 100.h,
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Image.asset("assets/images/teamb.png"),
                              Text("Team B",
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const SizedBox(
                        height: 160,
                        width: double.infinity,
                      ),
                      Container(
                        height: 110.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFBFCCDB),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/feildfulldesign.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          height: 30.h,
                          width: 200.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xffb3c73dc),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                // Set shadow color with 25% opacity
                                offset: Offset(0, 2),
                                // Set the offset
                                blurRadius: 4,
                                // Set the blur radius
                                spreadRadius: 0, // Set the spread radius
                              ),
                            ],
                          ),
                          child: Text("Match Details",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    height: 40.h,
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                            buttonText: 'Ball Possession 0%', isActive: true),
                        CustomButton(
                            buttonText: 'Ball Possession 0%', isActive: false),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Card(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                title: 'Goal',
                                Content: SizedBox(
                                  height: 230.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final timePickerText1 =
                                              await commonState
                                                  .selectTime(context);
                                          print(timePickerText1);
                                          setState(() {
                                            timePickerText = timePickerText1;
                                          });
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 150.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Time',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              Container(
                                                height: 10.h,
                                                width: 1.w,
                                                color: Colors.black,
                                              ),
                                              Text('$timePickerText',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Goal Scorer',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Goal Scorer",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Assist By',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Assist By",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Goal Area',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Goal Area",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonDialog(
                                          ButtonName: 'Missed',
                                          color: const Color(0xFFF9EAEA)),
                                      CustomButtonDialog(
                                          ButtonName: 'Saved',
                                          color: const Color(0xFFE0DEDE)),
                                      CustomButtonDialog(
                                          ButtonName: 'Goal',
                                          color: const Color(0xFFE0DEDE)),
                                    ],
                                  )
                                ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/goal.png',
                                height: 80.h,
                                width: 90.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                title: 'Yellow Card',
                                Content: SizedBox(
                                  height: 160.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final timePickerText1 =
                                              await commonState
                                                  .selectTime(context);
                                          print(timePickerText1);
                                          setState(() {
                                            timePickerText = timePickerText1;
                                          });
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 150.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Time',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              Container(
                                                height: 10.h,
                                                width: 1.w,
                                                color: Colors.black,
                                              ),
                                              Text('$timePickerText',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Player',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Player",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Referee',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Referee",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonDialog1(
                                          ButtonName: 'Cancel',
                                          color: const Color(0xFFE0DEDE)),
                                      CustomButtonDialog1(
                                          ButtonName: 'Done',
                                          color: const Color(0xFF007AFF)),
                                    ],
                                  )
                                ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/yellowcard.png',
                                height: 80.h,
                                width: 90.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                title: 'Red Card',
                                Content: SizedBox(
                                  height: 160.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final timePickerText1 =
                                              await commonState
                                                  .selectTime(context);
                                          print(timePickerText1);
                                          setState(() {
                                            timePickerText = timePickerText1;
                                          });
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 150.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Time',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              Container(
                                                height: 10.h,
                                                width: 1.w,
                                                color: Colors.black,
                                              ),
                                              Text('$timePickerText',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Player',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Player",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Referee',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Referee",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonDialog1(
                                          ButtonName: 'Cancel',
                                          color: const Color(0xFFE0DEDE)),
                                      CustomButtonDialog1(
                                          ButtonName: 'Done',
                                          color: const Color(0xFF007AFF)),
                                    ],
                                  )
                                ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/redcard.png',
                                height: 80.h,
                                width: 90.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Card(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                title: 'Foul',
                                Content: SizedBox(
                                  height: 160.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final timePickerText1 =
                                              await commonState
                                                  .selectTime(context);
                                          print(timePickerText1);
                                          setState(() {
                                            timePickerText = timePickerText1;
                                          });
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 150.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Time',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              Container(
                                                height: 10.h,
                                                width: 1.w,
                                                color: Colors.black,
                                              ),
                                              Text('$timePickerText',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Player',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Player",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Referee',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Referee",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonDialog1(
                                          ButtonName: 'Cancel',
                                          color: const Color(0xFFE0DEDE)),
                                      CustomButtonDialog1(
                                          ButtonName: 'Done',
                                          color: const Color(0xFF007AFF)),
                                    ],
                                  )
                                ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/foul.png',
                                height: 80.h,
                                width: 90.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                title: 'Throw-In',
                                Content: SizedBox(
                                  height: 300.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final timePickerText1 =
                                              await commonState
                                                  .selectTime(context);
                                          print(timePickerText1);
                                          setState(() {
                                            timePickerText = timePickerText1;
                                          });
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 150.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Time',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              Container(
                                                height: 10.h,
                                                width: 1.w,
                                                color: Colors.black,
                                              ),
                                              Text('$timePickerText',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Who is serving the ball...',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 70.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 50.h,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF007AFF),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/teama.jpg",
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text("Team A",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            textStyle:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Image.asset(
                                                        "assets/images/ball.png",
                                                        height: 10,
                                                        width: 10,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/teamb.png",
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  Text("Team B",
                                                      style: GoogleFonts.roboto(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Player',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Player",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Who is serving the ball...',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 70.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 50.h,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF007AFF),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/teama.jpg",
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text("Team A",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            textStyle:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Image.asset(
                                                        "assets/images/ball.png",
                                                        height: 10,
                                                        width: 10,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/teamb.png",
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  Text("Team B",
                                                      style: GoogleFonts.roboto(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonDialog1(
                                          ButtonName: 'Cancel',
                                          color: const Color(0xFFE0DEDE)),
                                      CustomButtonDialog1(
                                          ButtonName: 'Done',
                                          color: const Color(0xFF007AFF)),
                                    ],
                                  )
                                ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/trowin.png',
                                height: 80.h,
                                width: 90.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                title: 'Off Side',
                                Content: SizedBox(
                                  height: 160.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final timePickerText1 =
                                              await commonState
                                                  .selectTime(context);
                                          print(timePickerText1);
                                          setState(() {
                                            timePickerText = timePickerText1;
                                          });
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 150.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Time',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              Container(
                                                height: 10.h,
                                                width: 1.w,
                                                color: Colors.black,
                                              ),
                                              Text('$timePickerText',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Player',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Player",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Referee',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Referee",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonDialog1(
                                          ButtonName: 'Cancel',
                                          color: const Color(0xFFE0DEDE)),
                                      CustomButtonDialog1(
                                          ButtonName: 'Done',
                                          color: const Color(0xFF007AFF)),
                                    ],
                                  )
                                ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/offside.png',
                                height: 80.h,
                                width: 90.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Card(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                title: 'Substitute',
                                Content: SizedBox(
                                  height: 160.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final timePickerText1 =
                                              await commonState
                                                  .selectTime(context);
                                          print(timePickerText1);
                                          setState(() {
                                            timePickerText = timePickerText1;
                                          });
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 150.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Time',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              Container(
                                                height: 10.h,
                                                width: 1.w,
                                                color: Colors.black,
                                              ),
                                              Text('$timePickerText',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Player',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Player",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Referee',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Referee",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonDialog1(
                                          ButtonName: 'Cancel',
                                          color: const Color(0xFFE0DEDE)),
                                      CustomButtonDialog1(
                                          ButtonName: 'Done',
                                          color: const Color(0xFF007AFF)),
                                    ],
                                  )
                                ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/substitution.png',
                                height: 80.h,
                                width: 90.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                title: 'Corner Kick',
                                Content: SizedBox(
                                  height: 160.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final timePickerText1 =
                                              await commonState
                                                  .selectTime(context);
                                          print(timePickerText1);
                                          setState(() {
                                            timePickerText = timePickerText1;
                                          });
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 150.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Time',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              Container(
                                                height: 10.h,
                                                width: 1.w,
                                                color: Colors.black,
                                              ),
                                              Text('$timePickerText',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Player',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Player",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Referee',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Referee",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonDialog1(
                                          ButtonName: 'Cancel',
                                          color: const Color(0xFFE0DEDE)),
                                      CustomButtonDialog1(
                                          ButtonName: 'Done',
                                          color: const Color(0xFF007AFF)),
                                    ],
                                  )
                                ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/kornarkick.png',
                                height: 80.h,
                                width: 90.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                title: 'Penalty',
                                Content: SizedBox(
                                  height: 160.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final timePickerText1 =
                                              await commonState
                                                  .selectTime(context);
                                          print(timePickerText1);
                                          setState(() {
                                            timePickerText = timePickerText1;
                                          });
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 150.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Time',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              Container(
                                                height: 10.h,
                                                width: 1.w,
                                                color: Colors.black,
                                              ),
                                              Text('$timePickerText',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Player',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Player",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select Referee',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const CustomDropdownButton(
                                        hint: "Select Referee",
                                        itemList: StaticVariable.PlayerNamelist,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonDialog1(
                                          ButtonName: 'Cancel',
                                          color: const Color(0xFFE0DEDE)),
                                      CustomButtonDialog1(
                                          ButtonName: 'Done',
                                          color: const Color(0xFF007AFF)),
                                    ],
                                  )
                                ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/pelantykick.png',
                                height: 80.h,
                                width: 90.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 55.h,
                  )
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            height: 50.h,
            padding: EdgeInsets.only(top: 5.h),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PenaltyShootoutScreen()));
                  },
                  child: CustomButtonSmall(
                      ButtonName: 'Undo', color: const Color(0xFF007AFF)),
                ),
                CustomButtonSmall(
                    ButtonName: 'Pause', color: const Color(0xFF413566)),
                CustomButtonSmall(
                    ButtonName: 'End', color: const Color(0xFFBE2929)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget CutomWidget(
      {required String number1, required String number2, String? cardNmae}) {
    return Container(
      height: 24.h,
      width: 150.w,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cardNmae == "1"
              ? Container(
                  height: 15.h,
                  width: 40.w,
                  color: Colors.red,
                )
              : cardNmae == "2"
                  ? Container(
                      height: 15.h,
                      width: 40.w,
                      color: Colors.yellow,
                    )
                  : SizedBox(
                      child: Text("$cardNmae",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
          Row(
            children: [
              Text(
                number1,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                height: 12.h,
                width: 2.w,
                color: Colors.black,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(number1,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget CustomButton({required String buttonText, required bool isActive}) {
    return Container(
      height: 32.h,
      width: 159.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isActive == true ? const Color(0xFF007AFF) : null,
          borderRadius: BorderRadius.circular(5)),
      child: Text(buttonText,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 16,
              color: isActive == true ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget CustomButtonSmall({required String ButtonName, required Color color}) {
    return Container(
      width: 102.w,
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Text(ButtonName,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget CustomButtonDialog(
      {required String ButtonName, required Color color}) {
    return Container(
      width: 65.w,
      height: 35.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        border: ButtonName == "Missed"
            ? Border.all(color: const Color(0xFFBE2929), width: 1)
            : null,
      ),
      child: Text(ButtonName,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 16,
              color: ButtonName == "Missed"
                  ? const Color(0xFFBE2929)
                  : const Color(0xFF575757),
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget CustomButtonDialog1(
      {required String ButtonName, required Color color}) {
    return Container(
      height: 40.h,
      width: 100.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        border: ButtonName == "Cancel"
            ? Border.all(color: Colors.black.withOpacity(0.4), width: 1)
            : null,
      ),
      child: Text(ButtonName,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 16,
              color: ButtonName == "Done"
                  ? Colors.white
                  : ButtonName == "Next"
                      ? Colors.white
                      : const Color(0xFF575757),
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
