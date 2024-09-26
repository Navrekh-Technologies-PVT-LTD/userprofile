import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:yoursportz/domain/home/onboarding_entity.dart';

@injectable
class OnboardingProvider extends ChangeNotifier {
  List<OnboardingEntity> onBoardingContents = [
    OnboardingEntity(
      title: "TrackScore",
      image: "assets/images/1.png",
      desc:
          "Play, record, and relive the moments that make your game extraordinary.",
    ),
    OnboardingEntity(
      title: "Game Insight",
      image: "assets/images/2.png",
      desc:
          "Dive into the game like never before – Uncover player and team insights that redefine your football experience.",
    ),
    OnboardingEntity(
      title: "Targeted Triumphs",
      image: "assets/images/3.png",
      desc:
          "Discover your game changer with precision – where targeted ads redefine your journey to victory.",
    ),
  ];
}
