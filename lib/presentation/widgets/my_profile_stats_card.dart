import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/utils/color.dart';

class MyProfileStatsCard extends StatelessWidget {
  final int statsTotal;
  final String statsTitle;
  const MyProfileStatsCard(
      {required this.statsTotal, required this.statsTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonContainer(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color

            blurRadius: 10, // Blur radius
            offset: const Offset(
                -2, 5), // Offset in the left and downward direction
          ),
        ],
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            Flexible(
                child: Center(
                    child: Text(
              statsTotal.toString(),
              style: GoogleFonts.inter(
                  fontSize: 24,
                  color: TColor.msgbck,
                  fontWeight: FontWeight.w600),
            ))),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: CommonContainer(
                width: MediaQuery.of(context).size.width,
                color: TColor.msgbck,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(23, 6, 23, 7),
                  child: Center(
                    child: Text(
                      statsTitle,
                      style:
                          GoogleFonts.inter(color: Colors.white, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
