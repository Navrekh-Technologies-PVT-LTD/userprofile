import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'start-tournament/tournament_rules.dart';

class SelectTournamentType extends StatefulWidget {
  const SelectTournamentType(
      {super.key, required this.phone, required this.tournamentId});

  final String phone;
  final String tournamentId;

  @override
  State<SelectTournamentType> createState() => _SelectTournamentTypeState();
}

class _SelectTournamentTypeState extends State<SelectTournamentType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: GestureDetector(
          onTap: (){
            print("fwsfgwfgfgqa--${widget.tournamentId}");
          },
          child: Text(
            'Select Round',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        titleSpacing: -8, // This removes the space between the title and the leading icon
      ),

      body: Stack(children: [
        Positioned.fill(
            child: Image.asset(
          "assets/images/round_bg.jpg",
          fit: BoxFit.cover,
        )),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Column(children: [
            // TournamentOption(
            //     phone: widget.phone,
            //     title: "Round Robbin",
            //     icon: Icons.restart_alt,
            //     tournamentId: widget.tournamentId),
            TournamentOption(
                phone: widget.phone,
                title: "League Matches",
                imageUrl: "assets/images/league_matches.png",
                tournamentId: widget.tournamentId),
            TournamentOption(
                phone: widget.phone,
                title: "Knockout",
                imageUrl: "assets/images/knockout.png",
                tournamentId: widget.tournamentId),
            TournamentOption(
                phone: widget.phone,
                title: "Semi-Final",
                imageUrl: "assets/images/semi_finals.png",
                tournamentId: widget.tournamentId),
            TournamentOption(
                phone: widget.phone,
                title: "Final",
                imageUrl: "assets/images/final.png",
                tournamentId: widget.tournamentId),
          ]),
        )
      ]),
    );
  }
}

class TournamentOption extends StatelessWidget {
  const TournamentOption({
    super.key,
    required this.phone,
    required this.title,
    required this.imageUrl,
    required this.tournamentId,
  });

  final String phone;
  final String title;
  final String imageUrl; // New parameter for the image URL
  final String tournamentId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TournamentRules(
        //             phone: phone,
        //             tournamentId: tournamentId,
        //            )));
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  imageUrl,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(87, 87, 87, 1),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios,color: Colors.grey,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
