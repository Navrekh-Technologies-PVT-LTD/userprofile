import 'package:flutter/material.dart';
import 'package:yoursportz/presentation/widgets/my_profile_awards_card.dart';

class MyProfileAwardsFragment extends StatefulWidget {
  const MyProfileAwardsFragment({super.key});

  @override
  State<MyProfileAwardsFragment> createState() =>
      _MyProfileAwardsFragmentState();
}

class _MyProfileAwardsFragmentState extends State<MyProfileAwardsFragment> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return const MyProfileAwardsCard(
          imageUrl:
              "https://www.flutterbeads.com/wp-content/uploads/2021/11/o-creating-circular-image-in-flutter.png",
          imageTitle: '',
          imageSubtitle: '',
          cardName: '',
          cardPosition: '',
        );
      },
    );
  }
}
