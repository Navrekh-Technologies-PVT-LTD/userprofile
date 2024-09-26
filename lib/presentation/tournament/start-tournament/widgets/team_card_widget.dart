import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/utils/color.dart';

class TeamCardWidget extends StatelessWidget {
  const TeamCardWidget({
    super.key,
    required this.team,
    this.onTapAdd,
    this.isAdded = false,
    this.elevation,
  });

  final TeamModel team;
  final VoidCallback? onTapAdd;
  final double? elevation;
  final bool isAdded;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: elevation,
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.network(
                team.logo!,
                height: 50,
                width: 50,
                loadingBuilder:
                    (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/images/app_logo.png',
                    height: 50,
                  );
                },
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                team.name!.toString().length <= 15
                    ? team.name!
                    : team.name!.toString().substring(0, 15),
                style: GoogleFonts.inter(
                    fontSize: 17, fontWeight: FontWeight.w600, color: const Color(0xFF554585)),
              ),
              Text(
                team.city!,
                style: GoogleFonts.inter(color: Colors.grey),
              ),
            ],
          ),
          if (onTapAdd != null) const Spacer(),
          if (onTapAdd != null)
            GestureDetector(
              onTap: onTapAdd,
              child: Container(
                width: 56,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: isAdded ? TColor.white : const Color(0xFF554585),
                  border: Border.all(
                    color: !isAdded ? TColor.white : const Color(0xFF554585),
                  ),
                ),
                child: Center(
                  child: Text(
                    isAdded ? "Added" : "Add",
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: !isAdded ? TColor.white : const Color(0xFF554585),
                      fontWeight: isAdded ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(width: 16)
        ],
      ),
    );
  }
}
