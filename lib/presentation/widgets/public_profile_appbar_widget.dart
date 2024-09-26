import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/presentation/widgets/common_container.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';
import 'package:yoursportz/utils/color.dart';

class PublicProfileAppbarWidget extends StatefulWidget {
  const PublicProfileAppbarWidget({super.key, required this.data});
  final Map<String, dynamic> data;
  @override
  State<PublicProfileAppbarWidget> createState() =>
      _PublicProfileAppbarWidgetState();
}

class _PublicProfileAppbarWidgetState extends State<PublicProfileAppbarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BackButton(
          color: Colors.black,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Stack(
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                      child: Image.network(
                    // widget.data['dp'] ?? "",
                    "",
                    height: 70,
                    width: 70,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
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
                        'assets/images/dp.png',
                        height: 70,
                      );
                    },
                  ))),
            ],
          ),
          Column(
            children: [
              Text(widget.data['followers']?.length.toString() ?? "0",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text(
                LocaleKeys.followers.tr(),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
          Column(
            children: [
              Text((widget.data['profileViews']).toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text(
                LocaleKeys.profile_views.tr(),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
          InkWell(
            onTap: () {
              AlertDialog alert = AlertDialog(
                title: const Text("My QR Code"),
                content: PrettyQrView.data(
                  data: widget.data['followLink'].toString(),
                  decoration: const PrettyQrDecoration(
                    image: PrettyQrDecorationImage(
                      image: AssetImage('images/flutter.png'),
                    ),
                  ),
                ),
                actions: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                ],
              );

              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
            child: Column(
              children: [
                Image.asset(
                  'assets/images/qr.jpg',
                  height: 20,
                ),
                const SizedBox(height: 5),
                Text(
                  LocaleKeys.qr_code.tr(),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
          ),
          const SizedBox(),
        ]),
        Padding(
          padding: const EdgeInsets.all(2),
          child: Text(widget.data['name'] ?? LocaleKeys.player_name.tr(),
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: const EdgeInsets.all(2),
          child: Text(
              widget.data['position'] ?? LocaleKeys.player_position.tr(),
              style: const TextStyle(fontSize: 15, color: Colors.black)),
        ),
        Row(
          children: [
            const Icon(Icons.location_pin, color: Colors.grey, size: 15),
            const SizedBox(width: 4),
            Text(widget.data['city'] ?? LocaleKeys.city_.tr(),
                style: const TextStyle(fontSize: 15, color: Colors.grey)),
            const Spacer(),
            InkWell(
              onTap: () {
                AppBaseProvider().followUser(widget.data["phone"]).then((_) {
                  Navigator.pop(context);
                });
              },
              child: CommonContainer(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 2, bottom: 2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: matchesResultBGColor),
                color: matchesResultBGColor.withOpacity(0.1),
                child: Text("Follow",
                    style: GoogleFonts.inter(
                        color: matchesResultBGColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(widget.data['height'] ?? "-",
                    style: TextStyle(
                        color: TColor.greyText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  LocaleKeys.height.tr(),
                  style: TextStyle(fontSize: 12, color: TColor.greyText),
                )
              ],
            ),
            Column(
              children: [
                Text(
                    "${AppBaseProvider().calculateAge(widget.data['dob'])} Years",
                    style: TextStyle(
                        color: TColor.greyText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  widget.data['dob'] ?? LocaleKeys.date_of_birth.tr(),
                  style: TextStyle(fontSize: 12, color: TColor.greyText),
                )
              ],
            ),
            Column(
              children: [
                Text(widget.data['foot'] ?? "-",
                    style: TextStyle(
                        color: TColor.greyText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  LocaleKeys.preferred_foot.tr(),
                  style: TextStyle(fontSize: 12, color: TColor.greyText),
                )
              ],
            ),
            Column(
              children: [
                Text(widget.data['country'] ?? "-",
                    style: TextStyle(
                        color: TColor.greyText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  LocaleKeys.country.tr(),
                  style: TextStyle(fontSize: 12, color: TColor.greyText),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
