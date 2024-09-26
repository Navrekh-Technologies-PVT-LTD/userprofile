import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yoursportz/utils/color.dart';

import '../../gen/locale_keys.g.dart';

class GoLiveStreaming extends StatefulWidget {
  const GoLiveStreaming({super.key});

  @override
  State<GoLiveStreaming> createState() => _GoLiveStreamingState();
}

class _GoLiveStreamingState extends State<GoLiveStreaming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // <-- Use this
        centerTitle: false,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        titleSpacing: 0,

        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: TColor.secondaryText,
            ),
            tooltip: 'Menu Icon',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          LocaleKeys.go_live.tr(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/images/broadcast.svg",
                width: 22,
                height: 22,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Live Stream",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: double.infinity,
            height: 132,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.only(left: 36, right: 36),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Experience the thrill,\n stream the first match for free at 360p \n- 5 minutes of pure excitement, on us!",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
