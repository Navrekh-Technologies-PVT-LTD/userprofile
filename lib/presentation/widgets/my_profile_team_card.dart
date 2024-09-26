import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/utils/color.dart';

class MyProfileTeamCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const MyProfileTeamCard(
      {required this.imageUrl,
      required this.title,
      required this.subtitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.0.w, 16.0, 24.0.w, 0.0),
      child: CommonContainer(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              blurRadius: 4, // Blur radius
              offset: const Offset(
                  4, 4), // Offset in the left and downward direction
            ),
          ],
          color: Colors.white,
          child: Row(
            children: [
              CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                      child: Image.network(
                    imageUrl,
                    height: 54,
                    width: 54,
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
                            value: loadingProgress.expectedTotalBytes != null
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
                        height: 54,
                        width: 54,
                      );
                    },
                  ))),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: TColor.greyText),
                      ),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: TColor.greyText),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
