import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/utils/color.dart';

class PublicProfileStatCard extends StatelessWidget {
  final int statsTotal;
  final String statsTitle;
  final String assetPath;
  const PublicProfileStatCard(
      {required this.assetPath,
      required this.statsTotal,
      required this.statsTitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: CommonContainer(
    //     color: Colors.white,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.2), // Shadow color

    //         blurRadius: 10, // Blur radius
    //         offset: const Offset(
    //             -2, 5), // Offset in the left and downward direction
    //       ),
    //     ],
    //     borderRadius: BorderRadius.circular(8),
    //     child: Column(
    //       children: [
    //         Stack(
    //             alignment: Alignment.center,
    //             clipBehavior: Clip.none, // Allows offsetting the image
    //             children: [
    //               Positioned(
    //                 child: CircleAvatar(
    //                   radius: 38,
    //                   backgroundColor: TColor.msgbck,
    //                   // backgroundImage:  AssetImage("assets/images/public_profile_goals.png"),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(
    //                       top: 4.0,
    //                       left: 4,
    //                     ),
    //                     child: Image.asset(
    //                       "assets/images/public_profile_goals.png",
    //                       width: 55,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ]),
    //         Flexible(
    //             child: Center(
    //                 child: Text(
    //           statsTotal.toString(),
    //           style: GoogleFonts.inter(
    //               fontSize: 24,
    //               color: TColor.msgbck,
    //               fontWeight: FontWeight.w600),
    //         ))),
    //         Padding(
    //           padding: const EdgeInsets.fromLTRB(23, 6, 23, 7),
    //           child: Text(
    //             statsTitle,
    //             maxLines: 2,
    //             textAlign: TextAlign.center,
    //             style: GoogleFonts.inter(color: TColor.greyText, fontSize: 14),
    //             overflow: TextOverflow.ellipsis,
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonContainer(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5), // Rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],

        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -10,
                left: -10,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: TColor.msgbck,
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: TColor.msgbck,
                    // backgroundImage:  AssetImage("assets/images/public_profile_goals.png"),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        left: 4,
                      ),
                      child: Image.asset(
                        assetPath,
                        width: 55,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Column(
                  children: [
                    Text(
                      statsTotal.toString(),
                      style: GoogleFonts.inter(
                          fontSize: 24,
                          color: TColor.msgbck,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      statsTitle,
                      style: GoogleFonts.inter(
                          color: TColor.greyText, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
