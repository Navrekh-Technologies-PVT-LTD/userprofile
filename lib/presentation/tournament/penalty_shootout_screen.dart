// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/presentation/widgets/custom_dialog.dart';

class PenaltyShootoutScreen extends StatefulWidget {
  const PenaltyShootoutScreen({super.key});

  @override
  State<PenaltyShootoutScreen> createState() => _PenaltyShootoutScreenState();
}

class _PenaltyShootoutScreenState extends State<PenaltyShootoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Penalty Shootout"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/images/goal2 2.png"),
                Positioned(
                    top: 10,
                    // left: 0,
                    // right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.h,
                      width: 84.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white70,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "0",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            height: 2.h,
                            width: 10.w,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          const Text("0",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
                Positioned(
                  bottom: 00,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Team A (Name)',
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
                  InkWell(
                    onTap: () {
                      showAlertDialog(
                          context: context,
                          title: 'Select Goal Keeper',
                          Content: SizedBox(
                            height: 38.h,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Text('Select Goal Keeper',
                                //     style: GoogleFonts.roboto(
                                //       textStyle: const TextStyle(
                                //         fontSize: 16,
                                //         color: Colors.black,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     )),
                                // CustomDropdownButton(
                                //   hint: "Select Goal Keeper",
                                //   itemList: StaticVariable.PlayerNamelist,
                                // ),
                              ],
                            ),
                          ),
                          actions: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButtonDialog1(
                                    ButtonName: 'Cancel',
                                    color: const Color(0xFFE0DEDE)),
                                InkWell(
                                  onTap: () {},
                                  child: CustomButtonDialog1(
                                      ButtonName: 'Done',
                                      color: const Color(0xFF007AFF)),
                                ),
                              ],
                            )
                          ]);
                    },
                    child: Container(
                      height: 85.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF007AFF))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/handgolop.png",
                            height: 40,
                          ),
                          Text('  Select Goal Keeper',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF575757),
                                  fontWeight: FontWeight.normal,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          showAlertDialog(
                              context: context,
                              title: 'Select Player',
                              Content: SizedBox(
                                height: 38.h,
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Text('Select Goal Keeper',
                                    //     style: GoogleFonts.roboto(
                                    //       textStyle: const TextStyle(
                                    //         fontSize: 16,
                                    //         color: Colors.black,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     )),
                                    // CustomDropdownButton(
                                    //   hint: "Select Player",
                                    //   itemList: StaticVariable.PlayerNamelist,
                                    // ),
                                  ],
                                ),
                              ),
                              actions: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Container(
                          height: 85.h,
                          width: 102.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0xFF007AFF))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/player.png",
                                height: 40,
                              ),
                              Text('Select Player',
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF575757),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 85.h,
                        width: 102.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF007AFF))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/player.png",
                              height: 40,
                            ),
                            Text('Select Player',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF575757),
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 85.h,
                        width: 102.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF007AFF))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/player.png",
                              height: 40,
                            ),
                            Text('Select Player',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF575757),
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text('Team B (Name)',
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
                    height: 85.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF007AFF))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/handgolop.png",
                          height: 40,
                        ),
                        Text('  Select Goal Keeper',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF575757),
                                fontWeight: FontWeight.normal,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 85.h,
                        width: 102.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF007AFF))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/player.png",
                              height: 40,
                            ),
                            Text('Select Player',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF575757),
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 85.h,
                        width: 102.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF007AFF))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/player.png",
                              height: 40,
                            ),
                            Text('Select Player',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF575757),
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 85.h,
                        width: 102.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF007AFF))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/player.png",
                              height: 40,
                            ),
                            Text('Select Player',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF575757),
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
