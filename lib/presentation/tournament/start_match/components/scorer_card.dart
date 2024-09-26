import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yoursportz/presentation/chat/player%20chat/all_player_model.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';
import 'package:yoursportz/utils/text_style.dart';

// scorer_img.png
// linesman_img.png
// referee_img.png
// live_streamer_img.png

class ScorerCard extends StatelessWidget {
  const ScorerCard(
      {super.key, required this.selected, required this.label, required this.image, this.isFirst});
  final AllPlayerModel? selected;
  final String label;
  final String image;
  final bool? isFirst;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: TColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: SvgPicture.asset(
                  "assets/images/scor_card_bg.svg",
                ),
              ),
            ),
            Positioned(
              left: 10,
              child: SizedBox(
                width: width(context, 0.5) - 108,
                child: Text(
                  selected != null ? (selected?.name ?? "") : label,
                  style: style12500GreySFProDisplay,
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 18,
              child: selected != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        selected?.dp ?? "",
                        height: 35,
                        width: 35,
                        errorBuilder:
                            (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image.asset(
                            image,
                            height: 35,
                            width: 35,
                          );
                        },
                      ),
                    )
                  : isFirst == true
                      ? Image.asset(
                          image,
                          height: 35,
                          width: 35,
                        )
                      : SvgPicture.asset(
                          'assets/images/match_officials_user_image.svg',
                          height: 35,
                          width: 35,
                        ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       w(10),
            //       w(40),
            //       CircleAvatar(
            //         radius: 25,
            //         backgroundColor: Colors.white,
            //         child: ClipOval(
            //           child: Image.network(
            //             selected != null ? (selected?.dp ?? "") : "https://via.placeholder.com/35",
            //             height: 35,
            //             width: 35,
            //             loadingBuilder:
            //                 (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            //               if (loadingProgress == null) {
            //                 return child;
            //               }
            //               return Center(
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(20),
            //                   child: CircularProgressIndicator(
            //                     value: loadingProgress.expectedTotalBytes != null
            //                         ? loadingProgress.cumulativeBytesLoaded /
            //                             loadingProgress.expectedTotalBytes!
            //                         : null,
            //                   ),
            //                 ),
            //               );
            //             },
            //             errorBuilder:
            //                 (BuildContext context, Object exception, StackTrace? stackTrace) {
            //               return Image.asset(
            //                 'assets/images/match_official_userimg.png',
            //                 height: 35,
            //                 width: 35,
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            //       w(18),
            //     ],
            //   ),
            // ),
            // Positioned(
            //   bottom: 10,
            //   left: 12,
            //   right: 12,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // filteredPlayers = widget.allPlayers;
            //       // showDialog(
            //       //   context: context,
            //       //   builder: (context) {
            //       //     String filterText = '';
            //       //     return StatefulBuilder(
            //       //       builder: (context, setState) {
            //       //         return Dialog(
            //       //           shape: RoundedRectangleBorder(
            //       //             borderRadius: BorderRadius.circular(8),
            //       //           ),
            //       //           backgroundColor: Colors.grey[100],
            //       //           child: Column(
            //       //             mainAxisSize: MainAxisSize.min,
            //       //             children: [
            //       //               const Padding(
            //       //                 padding: EdgeInsets.all(8),
            //       //                 child: Text(
            //       //                   "Select Official",
            //       //                   style: TextStyle(fontSize: 20),
            //       //                 ),
            //       //               ),
            //       //               TextField(
            //       //                 onChanged: (value) {
            //       //                   setState(() {
            //       //                     filterText = value;
            //       //                     filterPlayers(filterText);
            //       //                   });
            //       //                 },
            //       //                 decoration: InputDecoration(
            //       //                   border: OutlineInputBorder(
            //       //                     borderSide: BorderSide.none,
            //       //                     borderRadius: BorderRadius.circular(32),
            //       //                   ),
            //       //                   filled: true,
            //       //                   fillColor: Colors.grey[200],
            //       //                   contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            //       //                   prefixIcon: const Icon(Icons.search),
            //       //                   hintText: "Search for the user",
            //       //                   hintStyle: GoogleFonts.inter(fontWeight: FontWeight.normal),
            //       //                 ),
            //       //               ),
            //       //               const SizedBox(height: 8),
            //       //               Expanded(
            //       //                 child: ListView.builder(
            //       //                   itemCount: filteredPlayers.length,
            //       //                   itemBuilder: (context, index) {
            //       //                     final player = filteredPlayers[index];
            //       //                     return ListTile(
            //       //                       leading: CircleAvatar(
            //       //                         backgroundColor: Colors.white,
            //       //                         backgroundImage: player.dp.isNotEmpty
            //       //                             ? NetworkImage(player.dp)
            //       //                             : const AssetImage('assets/images/player.png')
            //       //                                 as ImageProvider,
            //       //                         radius: 20,
            //       //                       ),
            //       //                       title: Text(player.name, style: GoogleFonts.inter()),
            //       //                       subtitle: Text(player.city, style: GoogleFonts.inter()),
            //       //                       trailing: ElevatedButton(
            //       //                         onPressed: () {
            //       //                           widget.onSelect(player);
            //       //                           Navigator.of(context).pop(); // Close the dialog
            //       //                         },
            //       //                         style: ButtonStyle(
            //       //                           backgroundColor: WidgetStateProperty.all<Color>(
            //       //                               const Color(0xFF413566)),
            //       //                         ),
            //       //                         child: Text(
            //       //                           "Select",
            //       //                           style: GoogleFonts.inter(color: Colors.white),
            //       //                         ),
            //       //                       ),
            //       //                     );
            //       //                   },
            //       //                 ),
            //       //               ),
            //       //             ],
            //       //           ),
            //       //         );
            //       //       },
            //       //     );
            //       //   },
            //       // );
            //     },
            //     style: ButtonStyle(
            //       padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(6)),
            //       backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF413566)),
            //       shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       ),
            //     ),
            //     child: Text(
            //       selected == null ? "Select scorer" : "Change scorer",
            //       style: GoogleFonts.inter(color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
