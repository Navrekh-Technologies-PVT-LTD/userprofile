import 'package:flutter/material.dart';
import 'package:yoursportz/presentation/widgets/custom_round_button.dart';
import 'package:yoursportz/presentation/widgets/my_profile_gallery_card.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/round_button.dart';

class MyProfileGalleryFragment extends StatefulWidget {
  const MyProfileGalleryFragment({super.key});

  @override
  State<MyProfileGalleryFragment> createState() =>
      _MyProfileGalleryFragmentState();
}

class _MyProfileGalleryFragmentState extends State<MyProfileGalleryFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Important to call this when using AutomaticKeepAliveClientMixin
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: const [
                  MyProfileGalleryCard(imageUrl: "imageUrl"),
                  MyProfileGalleryCard(imageUrl: "imageUrl"),
                  MyProfileGalleryCard(imageUrl: "imageUrl"),
                  MyProfileGalleryCard(imageUrl: "imageUrl"),
                  MyProfileGalleryCard(imageUrl: "imageUrl"),
                  MyProfileGalleryCard(imageUrl: "imageUrl"),
                  MyProfileGalleryCard(imageUrl: "imageUrl"),
                  MyProfileGalleryCard(imageUrl: "imageUrl"),
                  MyProfileGalleryCard(imageUrl: "imageUrl")
                ]),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomRoundButton(
            title: "Upload",
            onPressed: () {},
            type: CustomRoundButtonType.bgPrimary,
            buttonColor: TColor.msgbck,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; // This ke
}
