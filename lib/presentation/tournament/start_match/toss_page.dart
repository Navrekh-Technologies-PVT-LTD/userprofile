import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/tournament/start_match/toss_success_page.dart';
import 'package:yoursportz/presentation/widgets/appbar.dart';
import 'package:yoursportz/providers/tournament/start_match_vm.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';

class TossPage extends StatefulWidget {
  const TossPage({super.key, required this.phone});

  final String phone;

  @override
  State<TossPage> createState() => _TossPageState();
}

class _TossPageState extends State<TossPage> {
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TossSuccessPage(phone: widget.phone),
            ),
          );
        },
        child: Ink(
          height: height(context, 1),
          width: width(context, 1),
          color: TColor.kBGcolors,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SvgPicture.asset("assets/images/coin.svg"),
                ),
              ),
              SizedBox(
                height: 119,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/click.svg"),
                        w(5),
                        Text(
                          "Tap the coin to flip",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
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
