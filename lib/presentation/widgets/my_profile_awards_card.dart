import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/utils/color.dart';

class MyProfileAwardsCard extends StatelessWidget {
  final String imageUrl;
  final String imageTitle;
  final String imageSubtitle;
  final String cardName;
  final String cardPosition;
  const MyProfileAwardsCard(
      {required this.imageUrl,
      required this.imageTitle,
      required this.imageSubtitle,
      required this.cardName,
      required this.cardPosition,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CommonContainer(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color

            blurRadius: 10, // Blur radius
            offset: const Offset(
                -2, 4), // Offset in the left and downward direction
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7.5),
                    child: Stack(
                      // Darkening bottom of image
                      children: [
                        Image.network(
                          imageUrl,
                          width: MediaQuery.of(context).size.width,
                          height: 286,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'assets/images/app_logo.png',
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7)
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Scored 5 Goals",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Player of the match",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.inter(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: yellowAwardMyProfileTitle),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Name",
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: TColor.greyText),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Playing Position",
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: TColor.greyText),
            ),
            const SizedBox(
              height: 19,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(children: [
                Flexible(
                  child: CommonContainer(
                    borderRadius: BorderRadius.circular(5),
                    color: TColor.msgbck,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.0),
                            child: Text("Profile",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: CommonContainer(
                    borderRadius: BorderRadius.circular(5),
                    color: TColor.msgbck,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_outline_sharp,
                            color: Colors.white,
                            size: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.0),
                            child: Text("Like",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: CommonContainer(
                    borderRadius: BorderRadius.circular(5),
                    color: TColor.msgbck,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.0),
                            child: Text("Share",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
