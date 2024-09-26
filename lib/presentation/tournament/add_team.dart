import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTeams extends StatefulWidget {
  const AddTeams({
    super.key,
    required this.phone,
    required this.tournamentId,
    required this.numberofteams,
  });

  final String phone;
  final String tournamentId;
  final String numberofteams;

  @override
  State<AddTeams> createState() => _AddTeamsState();
}

class _AddTeamsState extends State<AddTeams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: GestureDetector(
          onTap: () {
            print("vsavgaqfgvagfva0---${widget.tournamentId}");
            print("number of teams--${widget.numberofteams}");
          },
          child: Text(
            'Add Teams',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        titleSpacing: -8,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 65),
            child: Column(
              children: [
                const SizedBox(
                  height: 7,
                ),
                GestureDetector(
                  onTap: () {
                    // context.navigateTo(
                    //   AddTeamsToTournamentRoute(
                    //     phone: widget.phone,
                    //     tournamentId: widget.tournamentId,
                    //     numberofteams: widget.numberofteams.toString(),
                    //   ),
                    // );
                  },
                  child: Container(
                    height: 104,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors
                          .white, // Add background color to see the shadow
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color

                          blurRadius: 10, // Blur radius
                          offset: const Offset(-2,
                              4), // Offset in the left and downward direction
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                          15), // Optional: Add border radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add My Team',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Add a team from your list.',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF7A7A7A),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Icon(
                                Icons.add_circle_outline,
                                size: 38,
                                color: Color(0xFF7A7A7A),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Color(0xFF7A7A7A),
                            size: 45,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 104,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        Colors.white, // Add background color to see the shadow
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color

                        blurRadius: 10, // Blur radius
                        offset: const Offset(
                            -2, 5), // Offset in the left and downward direction
                      ),
                    ],
                    borderRadius: BorderRadius.circular(
                        15), // Optional: Add border radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invite Team',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Invite a team via link.',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF7A7A7A),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Icon(
                              Icons.add_circle_outline,
                              size: 38,
                              color: Color(0xFF7A7A7A),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF7A7A7A),
                          size: 45,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
