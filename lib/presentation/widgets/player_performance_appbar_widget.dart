import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/presentation/profile/edit_profile.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';
import 'package:yoursportz/utils/color.dart';

class PlayerPerformaceAppBarWidget extends StatefulWidget {
  const PlayerPerformaceAppBarWidget({super.key, required this.phone});
  final String phone;
  @override
  State<PlayerPerformaceAppBarWidget> createState() =>
      _PlayerPerformaceAppBarWidgetState();
}

class _PlayerPerformaceAppBarWidgetState
    extends State<PlayerPerformaceAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppBaseProvider>(
      builder: (context, appBaseState, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                BackButton(
                  color: Colors.black,
                ),
                Text(
                  "Player Performance",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Stack(
                children: [
                  CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                          child: Image.network(
                        appBaseState.userDetails['dp'] ?? "",
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
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 60, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        appBaseState.getImage(context, widget.phone);
                      },
                      child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ClipOval(child: Icon(Icons.camera_alt))),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(appBaseState.userDetails['followers'].length.toString(),
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
                  Text((appBaseState.userDetails['profileViews']).toString(),
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
                      data: appBaseState.userDetails['followLink'],
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
              const SizedBox()
            ]),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                  appBaseState.userDetails['position'] ??
                      LocaleKeys.player_position.tr(),
                  style: const TextStyle(fontSize: 17, color: Colors.black)),
            ),
            Row(
              children: [
                const Icon(Icons.location_pin, color: Colors.grey, size: 15),
                const SizedBox(width: 4),
                Text(appBaseState.userDetails['city'] ?? LocaleKeys.city_.tr(),
                    style: const TextStyle(fontSize: 15, color: Colors.grey)),
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
                    Text(appBaseState.userDetails['height'] ?? "-",
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
                    Text(appBaseState.age,
                        style: TextStyle(
                            color: TColor.greyText,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      appBaseState.userDetails['dob'] ??
                          LocaleKeys.date_of_birth.tr(),
                      style: TextStyle(fontSize: 12, color: TColor.greyText),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(appBaseState.userDetails['foot'] ?? "-",
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
                    Text(appBaseState.userDetails['country'] ?? "-",
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
            )
          ],
        );
      },
    );
  }
}
