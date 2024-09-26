import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/widgets/appbar.dart';
import 'package:yoursportz/presentation/widgets/custom_btn.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';

import 'tournament_toss2.dart';

class TossSuccessPage extends StatefulWidget {
  const TossSuccessPage({super.key, required this.phone});

  final String phone;

  @override
  State<TossSuccessPage> createState() => _TossSuccessPageState();
}

class _TossSuccessPageState extends State<TossSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.kBGcolors,
      appBar: customAppBarForTournament(
        context: context,
        title: 'Toss',
      ),
      body: InkWell(
        onTap: () {
          context.read<StartMatchVM>().tossCoin();
        },
        child: Ink(
          height: height(context, 1),
          width: width(context, 1),
          color: TColor.kBGcolors,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/${context.watch<StartMatchVM>().tossResult.toLowerCase()}.svg",
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          "It’s a ${context.watch<StartMatchVM>().tossResult}",
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(flex: 3),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 119,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/click.svg"),
                        w(5),
                        Text(
                          "Tap the coin to flip again",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    customButtonForTournament(
                      margin: const EdgeInsetsDirectional.all(16).copyWith(top: 8),
                      title: "Done",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TournamentToss2(phone: widget.phone, isFromVirtualToss: true),
                          ),
                        );
                      },
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
