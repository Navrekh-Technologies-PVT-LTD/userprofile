import 'package:flutter/material.dart';
import 'package:yoursportz/presentation/widgets/my_profile_highlights_card.dart';

class MyProfileHighlightsFragment extends StatelessWidget {
  const MyProfileHighlightsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return const MyProfileHighlightsCard(
          imageUrl:
              "https://www.flutterbeads.com/wp-content/uploads/2021/11/o-creating-circular-image-in-flutter.png",
          matchName: '',
          highlight: '',
          venue: '',
          matchState: '',
        );
      },
    );
  }
}
