// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:yoursportz/presentation/widgets/common_container.dart';
// import 'package:yoursportz/utils/color.dart';

// class MyProfileMatchesCard extends StatelessWidget {
//   final String matchName;
//   final String matchVenue;
//   final String matchDate;
//   final String scoreline;
//   final String homeImageUrl;
//   final String homeTeamName;
//   final String awayImageUrl;
//   final String awayTeamName;
//   final String matchQuarter;
//   final String matchState;

//   const MyProfileMatchesCard(
//       {super.key,
//       required this.matchName,
//       required this.matchVenue,
//       required this.matchDate,
//       required this.scoreline,
//       required this.homeImageUrl,
//       required this.homeTeamName,
//       required this.matchQuarter,
//       required this.matchState,
//       required this.awayImageUrl,
//       required this.awayTeamName});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: CommonContainer(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2), // Shadow color

//               blurRadius: 10, // Blur radius
//               offset: const Offset(
//                   -2, 5), // Offset in the left and downward direction
//             ),
//           ],
//           borderRadius: BorderRadius.circular(8),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     matchName,
//                     style: GoogleFonts.inter(
//                         color: TColor.greyText,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 12),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(matchVenue,
//                               style: GoogleFonts.inter(
//                                   color: TColor.greyText,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 8))
//                         ],
//                       ),
//                     ),
//                     Flexible(
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 26.0),
//                         child: Text(matchDate,
//                             style: GoogleFonts.inter(
//                                 color: TColor.greyText,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 8)),
//                       ),
//                     ),
//                     Flexible(
//                       child: CommonContainer(
//                         padding: const EdgeInsets.only(
//                             left: 10, right: 10, top: 2, bottom: 2),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: matchesResultBGColor),
//                         color: matchesResultBGColor.withOpacity(0.1),
//                         child: Text(matchState,
//                             style: GoogleFonts.inter(
//                                 color: matchesResultBGColor,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 10)),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 24, right: 24),
//                   child: Row(
//                     children: [
//                       Column(
//                         children: [
//                           CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Colors.transparent,
//                               child: ClipOval(
//                                   child: Image.network(
//                                 homeImageUrl,
//                                 height: 90,
//                                 width: 90,
//                                 fit: BoxFit.cover,
//                                 loadingBuilder: (BuildContext context,
//                                     Widget child,
//                                     ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) {
//                                     return child;
//                                   }
//                                   return Center(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(20),
//                                       child: CircularProgressIndicator(
//                                         value: loadingProgress
//                                                     .expectedTotalBytes !=
//                                                 null
//                                             ? loadingProgress
//                                                     .cumulativeBytesLoaded /
//                                                 loadingProgress
//                                                     .expectedTotalBytes!
//                                             : null,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 errorBuilder: (BuildContext context,
//                                     Object exception, StackTrace? stackTrace) {
//                                   return Image.asset(
//                                     'assets/images/app_logo.png',
//                                     height: 100,
//                                   );
//                                 },
//                               ))),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Text(
//                             homeTeamName,
//                             style: GoogleFonts.inter(
//                               color: TColor.greyText,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           )
//                         ],
//                       ),
//                       const Spacer(),
//                       Column(
//                         children: [
//                           Text(
//                             scoreline,
//                             style: GoogleFonts.inter(
//                                 color: TColor.greyText,
//                                 fontSize: 36,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             height: 16,
//                           ),
//                           Text(
//                             matchQuarter,
//                             style: GoogleFonts.inter(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                       const Spacer(),
//                       Column(
//                         children: [
//                           CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Colors.transparent,
//                               child: ClipOval(
//                                   child: Image.network(
//                                 awayImageUrl,
//                                 height: 90,
//                                 width: 90,
//                                 fit: BoxFit.cover,
//                                 loadingBuilder: (BuildContext context,
//                                     Widget child,
//                                     ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) {
//                                     return child;
//                                   }
//                                   return Center(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(20),
//                                       child: CircularProgressIndicator(
//                                         value: loadingProgress
//                                                     .expectedTotalBytes !=
//                                                 null
//                                             ? loadingProgress
//                                                     .cumulativeBytesLoaded /
//                                                 loadingProgress
//                                                     .expectedTotalBytes!
//                                             : null,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 errorBuilder: (BuildContext context,
//                                     Object exception, StackTrace? stackTrace) {
//                                   return Image.asset(
//                                     'assets/images/app_logo.png',
//                                     height: 100,
//                                   );
//                                 },
//                               ))),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Text(
//                             awayTeamName,
//                             style: GoogleFonts.inter(
//                                 color: TColor.greyText,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/utils/color.dart';

class MyProfileMatchesCard extends StatelessWidget {
  final String matchName;
  final String matchVenue;
  final String matchDate;
  final String scoreline;
  final String homeImageUrl;
  final String homeTeamName;
  final String awayImageUrl;
  final String awayTeamName;
  final String matchQuarter;
  final String matchState;

  const MyProfileMatchesCard(
      {super.key,
      required this.matchName,
      required this.matchVenue,
      required this.matchDate,
      required this.scoreline,
      required this.homeImageUrl,
      required this.homeTeamName,
      required this.matchQuarter,
      required this.matchState,
      required this.awayImageUrl,
      required this.awayTeamName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: CommonContainer(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(-2, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                matchName,
                style: GoogleFonts.inter(
                  color: TColor.greyText,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          matchVenue,
                          style: GoogleFonts.inter(
                            color: TColor.greyText,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Column(
                      children: [
                        Text(
                          matchDate,
                          style: GoogleFonts.inter(
                            color: TColor.greyText,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  CommonContainer(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: matchesResultBGColor),
                    color: matchesResultBGColor.withOpacity(0.1),
                    child: Text(
                      matchState,
                      style: GoogleFonts.inter(
                        color: matchesResultBGColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Home Team
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.network(
                              homeImageUrl,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset(
                                  'assets/images/app_logo.png',
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          homeTeamName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: TColor.greyText,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Score and Quarter
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          scoreline,
                          style: GoogleFonts.inter(
                            color: TColor.greyText,
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          matchQuarter,
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Away Team
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.network(
                              awayImageUrl,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset(
                                  'assets/images/app_logo.png',
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          awayTeamName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: TColor.greyText,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
