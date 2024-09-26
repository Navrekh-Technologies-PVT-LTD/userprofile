import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/presentation/chat/player%20chat/player_chat_onboard.dart';
import 'package:yoursportz/presentation/streaming/go_live_streaming.dart';
import 'package:yoursportz/presentation/tournament/select_ground.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';

class HomeAppbarWidget extends StatefulWidget {
  const HomeAppbarWidget({super.key, required this.phone});
  final String phone;

  @override
  State<HomeAppbarWidget> createState() => _HomeAppbarWidgetState();
}

class _HomeAppbarWidgetState extends State<HomeAppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppBaseProvider>(
      builder: (context, appBaseState, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    log("message");
                    Scaffold.of(context).openDrawer();
                  },
                  child: Image.asset(
                    "assets/images/menu.png",
                    height: 30,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 7),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 250, 240, 240),
                          border: Border.all(
                              color: const Color(0xffBE2929), width: 0),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ic_play.png",
                            height: 25,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const GoLiveStreaming()));
                            },
                            child: Text(
                              LocaleKeys.go_live.tr(),
                              style: const TextStyle(
                                  color: Color(0xffBE2929), fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SelectGround(phone: widget.phone)))
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 7),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 240, 240, 250),
                            border: Border.all(
                                color: const Color(0xff413566), width: 0),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/ic_foot_ic.png",
                              height: 25,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              LocaleKeys.play.tr(),
                              style: const TextStyle(
                                  color: Color(0xff413566), fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerChatOnboard(
                                      phone: widget.phone,
                                    )))
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 7),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 240, 240, 250),
                            border: Border.all(
                                color: const Color(0xff413566), width: 0),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.comment,
                              size: 21,
                              color: Color(0xff413566),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Chat",
                              style: TextStyle(
                                  color: Color(0xff413566), fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 245),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 0.5,
                        color: const Color(0xff7A7A7A),
                      ),
                    ),
                    child: TextField(
                      controller: appBaseState.searchcontroller,
                      onChanged: (value) {
                        appBaseState.updateSearchControllerValue(value);
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xff7A7A7A),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(top: 7),
                          hintText: LocaleKeys.search.tr(),
                          hintStyle: const TextStyle(
                              color: Color(0xff7A7A7A),
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Stack(children: [
                  Image.asset(
                    "assets/images/notification.png",
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "3",
                      style:
                          TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
              ],
            )
          ],
        );
      },
    );
  }
}
