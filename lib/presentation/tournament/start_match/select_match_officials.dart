import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/tournament/start_match/components/scorer_card.dart';
import 'package:yoursportz/presentation/widgets/appbar.dart';
import 'package:yoursportz/presentation/widgets/custom_btn.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';
import 'package:yoursportz/utils/text_style.dart';

class SelectMatchOfficial extends StatefulWidget {
  const SelectMatchOfficial({super.key, required this.phone});
  final String phone;
  @override
  State<SelectMatchOfficial> createState() => _SelectMatchOfficialState();
}

class _SelectMatchOfficialState extends State<SelectMatchOfficial> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<StartMatchVM>().fetchAllPlayers();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.kBGcolors,
      appBar: customAppBarForTournament(
        context: context,
        title: 'Match Officials',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Scorer",
              style: style16600BlackSFProDisplay,
            ),
            h(5),
            Text(
              "*Minimum one Scorer should be selected before starting a match",
              style: style10400GreySFProDisplay,
            ),
            h(10),
            Row(
              children: [
                ScorerCard(
                  label: "Select Scorer",
                  selected: context.watch<StartMatchVM>().scorer1,
                  image: "assets/images/scorer_img.png",
                  isFirst: true,
                ),
                w(11),
                ScorerCard(
                  label: "Select Scorer",
                  selected: context.watch<StartMatchVM>().scorer2,
                  image: "assets/images/scorer_img.png",
                ),
              ],
            ),
            h(20),
            Text(
              "Select Scorer",
              style: style16600BlackSFProDisplay,
            ),
          ],
        ),
      ),
      bottomNavigationBar: customButtonForTournament(
        margin: const EdgeInsetsDirectional.all(16).copyWith(top: 8),
        title: "Done",
        onTap: () {
          // if (selectedPlayer1 == null && selectedPlayer2 == null) {
          //   // Show a SnackBar if no scorer is selected
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('At least one scorer must be selected!'),
          //       backgroundColor: Colors.red,
          //     ),
          //   );
          // } else {
          //   // Navigate to the next screen if at least one scorer is selected
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => TournamentToss1(phone: widget.phone),
          //     ),
          //   );
          // }
        },
      ),
    );
  }
}
