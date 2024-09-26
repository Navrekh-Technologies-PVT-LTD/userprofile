import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';

class ClipsAppbarWidget extends StatelessWidget {
  const ClipsAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.clips.tr(),
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 240, 245),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(width: 0.5, color: const Color(0xff7A7A7A))),
                child: TextField(
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
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
