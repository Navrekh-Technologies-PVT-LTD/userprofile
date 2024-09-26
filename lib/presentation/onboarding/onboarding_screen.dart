import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/onboarding/select_language.dart';
import 'package:yoursportz/providers/onboarding/onboarding_provider.dart';
import 'package:yoursportz/utils/size_config.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List images = const [
    "assets/images/img_bg_1.png",
    "assets/images/img_bg_2.png",
    "assets/images/img_bg_3.png",
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFFFFFFFF),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      curve: Curves.easeIn,
      width: _currentPage == index ? 25 : 10,
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("assets/images/img_bg_1.png"), context);
    precacheImage(const AssetImage("assets/images/img_bg_2.png"), context);
    precacheImage(const AssetImage("assets/images/img_bg_3.png"), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<OnboardingProvider>(
        builder: (context, onboardingState, _) {
          return SafeArea(
            child: Container(
              height: SizeConfig.screenH,
              width: SizeConfig.screenW,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(images[_currentPage]),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/app_icon.png",
                            height: 45.h,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "YourSportz",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Game it your way",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Flexible(
                    flex: 7,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _controller,
                      onPageChanged: (value) =>
                          setState(() => _currentPage = value),
                      itemCount: onboardingState.onBoardingContents.length,
                      itemBuilder: (context, index) {
                        final data = onboardingState.onBoardingContents[index];
                        return Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Image.asset(
                                data.image,
                                height: SizeConfig.blockV! * 40,
                              ),
                              Text(
                                data.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                data.desc,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _currentPage + 1 ==
                              onboardingState.onBoardingContents.length
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectLanguageScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: SizeConfig.screenW,
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.fromLTRB(12, 0, 12, 12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Color(0xff554585),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingState.onBoardingContents.length,
                          (int index) => _buildDots(
                            index: index,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
