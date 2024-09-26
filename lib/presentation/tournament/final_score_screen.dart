import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StaticsScreen extends StatefulWidget {
  const StaticsScreen({super.key});

  @override
  State<StaticsScreen> createState() => _StaticsScreenState();
}

class _StaticsScreenState extends State<StaticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Final Score"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/setting.png",
              height: 20,
            ),
          )
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
                // CustomScoreBarWedget(),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 180.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/scorebanner.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/hanover.png",
                              height: 80.h,
                              width: 80.w,
                            ),
                            Text("Team Tiger",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text("Jr. Naymer 10",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            Text("Hulk Sero 18",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text("3-5",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                                left: 10, top: 1, bottom: 1, right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white)),
                            child: Text("90:00",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Image.asset(
                            "assets/images/finalscoreicon.png",
                            height: 20.h,
                            width: 20.w,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/teamb.png",
                              height: 80.h,
                              width: 80.w,
                            ),
                            Text("Team Lion",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text("Jr. Messi 11",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 420.h,
                    ),
                    Container(
                      height: 390.h,
                      padding: EdgeInsets.all(10.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          customProccess(
                              color: const Color(0xFF3C73DC),
                              value: 50,
                              title: 'Ball Possession',
                              firstnumber: '20%',
                              secondnumber: '40%',
                              bgcolor: Colors.black),
                          SizedBox(
                            height: 10.h,
                          ),
                          customProccess(
                              color: const Color(0xFF3C73DC),
                              value: 50,
                              title: 'Goal Attempts',
                              firstnumber: '6',
                              secondnumber: '4',
                              bgcolor: Colors.black),
                          SizedBox(
                            height: 10.h,
                          ),
                          customProccess(
                              color: const Color(0xFF3C73DC),
                              value: 100,
                              title: 'Shots on Goal',
                              firstnumber: '0',
                              secondnumber: '4',
                              bgcolor: Colors.black,
                              leftRigt: "R"),
                          SizedBox(
                            height: 10.h,
                          ),
                          customProccess(
                              color: Colors.black,
                              value: 40,
                              title: 'Shots off Goal',
                              firstnumber: '3',
                              secondnumber: '6',
                              bgcolor: const Color(0xFF3C73DC)),
                          SizedBox(
                            height: 10.h,
                          ),
                          customProccess(
                              color: const Color(0xFF3C73DC),
                              value: 50,
                              title: 'Blocked Shots',
                              firstnumber: '2',
                              secondnumber: '1',
                              bgcolor: Colors.black),
                          SizedBox(
                            height: 10.h,
                          ),
                          customProccess(
                              color: const Color(0xFF3C73DC),
                              value: 50,
                              title: 'Free Kicks',
                              firstnumber: '2',
                              secondnumber: '1',
                              bgcolor: Colors.black),
                          SizedBox(
                            height: 10.h,
                          ),
                          customProccess(
                              color: const Color(0xFF3C73DC),
                              value: 100,
                              title: 'Corners',
                              firstnumber: '2',
                              secondnumber: '1',
                              bgcolor: Colors.black,
                              leftRigt: "L"),
                          SizedBox(
                            height: 10.h,
                          ),
                          customProccess(
                              color: const Color(0xFF3C73DC),
                              value: 50,
                              title: 'Offsides',
                              firstnumber: '2',
                              secondnumber: '1',
                              bgcolor: Colors.black),
                          SizedBox(
                            height: 10.h,
                          ),
                          customProccess(
                              color: const Color(0xFF3C73DC),
                              value: 50,
                              title: 'Throw-in',
                              firstnumber: '15',
                              secondnumber: '21',
                              bgcolor: Colors.black),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
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
                          child: Text("Match Stats",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ))
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget customProccess(
      {required Color color,
      required Color bgcolor,
      required double value,
      required String title,
      required String firstnumber,
      required String secondnumber,
      String? leftRigt}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(firstnumber,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Text(title,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Text(secondnumber,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        custromprocessbar(
            color: color, color1: bgcolor, value: value, LeftRight: leftRigt),
      ],
    );
  }

  Widget custromprocessbar(
      {required Color color,
      required Color color1,
      required double value,
      String? LeftRight}) {
    return Stack(
      alignment: LeftRight == "L"
          ? Alignment.centerLeft
          : LeftRight == "R"
              ? Alignment.centerRight
              : Alignment.center,
      children: [
        Container(
          height: 1.h,
          width: double.infinity,
          color: Colors.black,
        ),
        SizedBox(
          width: 200.w,
          child: FAProgressBar(
            size: 10,
            currentValue: value,
            displayTextStyle: TextStyle(
                color: color1 == const Color(0xFF3C73DC)
                    ? Colors.black
                    : const Color(0xFF3C73DC)),
            displayText: '',
            progressColor: color,
            backgroundColor: color1,
          ),
        ),
      ],
    );
  }
}
