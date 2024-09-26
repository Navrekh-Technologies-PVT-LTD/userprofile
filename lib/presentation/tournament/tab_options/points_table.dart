import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/domain/tournament/tournaments_entity.dart';
import 'package:yoursportz/presentation/widgets/group_tab_bar.dart';
import 'package:yoursportz/providers/tournament/tournament_provider.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';

class PointsTableTab extends StatefulWidget {
  const PointsTableTab({super.key});

  @override
  State<PointsTableTab> createState() => _PointsTableTabState();
}

class _PointsTableTabState extends State<PointsTableTab> {
  @override
  Widget build(BuildContext context) {
    List<List<PointsTableModel>> pointTable =
        context.watch<TournamentProvider>().selectedTournament?.pointsTable ?? [];

    int numberOfGroups = int.tryParse(
            context.watch<TournamentProvider>().selectedTournament?.numberOfGroups ?? "0") ??
        0;
    int selectedPointTableGroupIndex =
        context.watch<TournamentProvider>().selectedPointTableGroupIndex;

    List<PointsTableModel> selectedPointTable = selectedPointTableGroupIndex < pointTable.length
        ? pointTable[selectedPointTableGroupIndex]
        : [];

    return Column(
      children: [
        h(16),
        GroupTabBar(
          selectedIndex: selectedPointTableGroupIndex,
          listLength: numberOfGroups,
          onChangeIndex: (i) {
            context.read<TournamentProvider>().setSelectedPointTableGroupIndex(i);
          },
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsetsDirectional.all(16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: TColor.white),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textForTable("#", flex: 2, color: TColor.borderColor),
                    textForTable("Team Name", flex: 10),
                    textForTable("M"),
                    textForTable("W"),
                    textForTable("L"),
                    textForTable("D"),
                    textForTable("Points", flex: 3),
                  ],
                ),
                h(8),
                Expanded(
                    child: ListView(
                  children: [
                    ...selectedPointTable.map(
                      (e) {
                        int i = selectedPointTable.indexOf(e);
                        return Team(data: e, index: i);
                      },
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget textForTable(String title, {int flex = 1, Color? color}) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          color: color ?? TColor.msgbck,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class Team extends StatelessWidget {
  const Team({super.key, required this.data, required this.index});

  final PointsTableModel data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        border: Border.all(
          color: TColor.msgbck.withOpacity(0.44),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsetsDirectional.symmetric(vertical: 4),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          textForTable(
            "${index + 1}",
            color: TColor.borderColor,
            fontWeight: FontWeight.w700,
            flex: 2,
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: (data.logo ?? "") != "" && data.logo != "null"
                      ? Image.network(
                          data.logo ?? "",
                          height: 14,
                          width: 14,
                        )
                      : Image.asset(
                          'assets/images/app_icon.png',
                          height: 14,
                          width: 14,
                        ),
                ),
                w(8),
                Expanded(
                  child: Text(
                    data.name ?? "",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: TColor.msgbck,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          textForTable("${data.played ?? ""}"),
          textForTable("${data.won ?? ""}"),
          textForTable("${data.loss ?? ""}"),
          textForTable("${data.draw ?? ""}"),
          textForTable("${data.points ?? ""}", flex: 3),
        ],
      ),
    );
  }

  Widget textForTable(String title,
      {int flex = 1, Color? color, double? fontSize, FontWeight? fontWeight}) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          color: color ?? TColor.msgbck,
          fontSize: fontSize ?? 12,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}
