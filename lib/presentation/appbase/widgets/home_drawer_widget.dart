import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/presentation/auth/login_screen.dart';
import 'package:yoursportz/presentation/home/change_language.dart';
import 'package:yoursportz/presentation/myperformance/show_my_performance_screen.dart';
import 'package:yoursportz/presentation/profile/settings.dart';
import 'package:yoursportz/presentation/teams/my_teams.dart';
import 'package:yoursportz/presentation/tournament/create_team.dart';
import 'package:yoursportz/presentation/tournament/select_ground.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';
import 'package:yoursportz/routing/app_router.gr.dart';
import 'package:yoursportz/utils/showdialogbox.dart';

class HomeDrawerWidget extends StatefulWidget {
  const HomeDrawerWidget({super.key, required this.phone});
  final String phone;
  @override
  State<HomeDrawerWidget> createState() => _HomeDrawerWidgetState();
}

class _HomeDrawerWidgetState extends State<HomeDrawerWidget> {
  void showdialogfunctioin() {
    showCustomDialog(
      context: context,
      title: "Login Required",
      content: "Guest Login Note",
      confirmText: "Login",
      onConfirm: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      },
      onCancel: () {
        Navigator.of(context).pop();
        // Perform the cancel action
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppBaseProvider>(
      builder: (context, appBaseState, _) {
        return Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/drawer_bg.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(200, 200, 200, 200)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.transparent,
                                    child: ClipOval(
                                        child: Image.network(
                                      appBaseState.userDetails['dp'] ?? "",
                                      height: 50,
                                      width: 50,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(32),
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                          'assets/images/dp.png',
                                          height: 50,
                                          width: 50,
                                        );
                                      },
                                    ))),
                                Text(
                                    appBaseState.userDetails['name'] ??
                                        LocaleKeys.user_name.tr(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Row(children: [
                                Text(
                                    appBaseState.userDetails['phone'] != null
                                        ? appBaseState.userDetails['phone']
                                                    .length <=
                                                25
                                            ? appBaseState.userDetails['phone']
                                            : appBaseState.userDetails['phone']
                                                .toString()
                                                .substring(0, 25)
                                        : LocaleKeys.phone_or_email.tr(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54)),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/go_live.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.go_live.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  // Handle navigation to Item 1
                },
              ),
              ListTile(
                title: Row(children: [
                  Image.asset(
                    'assets/images/create_teams.png',
                    height: 25,
                  ),
                  const SizedBox(width: 8),
                  Text(LocaleKeys.create_team.tr(),
                      style: const TextStyle(fontSize: 15)),
                ]),
                onTap: () {
                  Navigator.pop(context);
                  widget.phone == "guest"
                      ? showdialogfunctioin()
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => CreateTeam(
                                  phone: widget.phone,
                                  ground: appBaseState.ground,
                                  source: "home"))));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/my_teams.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.my_teams.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  widget.phone == "guest"
                      ? showdialogfunctioin()
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  MyTeams(phone: widget.phone))));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/start_match.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.start_a_match.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  widget.phone == "guest"
                      ? showdialogfunctioin()
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  SelectGround(phone: widget.phone))));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/start_tournament.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.start_a_tournament.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  widget.phone == "guest"
                      ? showdialogfunctioin()
                      : context.navigateTo(
                          OngoingTournamentRoute(phone: widget.phone),
                        );
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/performance.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.show_my_performance.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  widget.phone == "guest"
                      ? showdialogfunctioin()
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ShowMyPerformanceScreen(
                                  phone: widget.phone))));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/premium.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.premier_league.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  // Handle navigation to Item 1
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/admin.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.admin.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  // Handle navigation to Item 1
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/ads.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.my_ads.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  // Handle navigation to Item 1
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/share.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.share_with_friends.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Share.share(LocaleKeys.download_app_message.tr());
                  // 'Download YourSportz on the App Store and Google Play to stay connected with your local football arena! 📲⚽\n\n👉 iOS App: https://www.apple.com/in/search/YourSportz \n\n👉 Android App: https://play.google.com/store/apps/details?id=com.eternachat.app');
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/change_language.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.change_language.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              ChangeLanguage(phone: widget.phone))));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/settings.png',
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(LocaleKeys.settings.tr(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              Settings(phone: widget.phone))));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
