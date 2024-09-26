// Flutter imports:
// Package imports:

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:yoursportz/core/deeplink_handling.dart';
import 'package:yoursportz/gen/assets.gen.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/presentation/appbase/widgets/clips_appbar_widget.dart';
import 'package:yoursportz/presentation/appbase/widgets/find_appbar_widget.dart';
import 'package:yoursportz/presentation/appbase/widgets/home_appbar_widget.dart';
import 'package:yoursportz/presentation/appbase/widgets/home_drawer_widget.dart';
import 'package:yoursportz/presentation/appbase/widgets/my_football_appbar.dart';
import 'package:yoursportz/presentation/appbase/widgets/my_profile_appbar_widget.dart';
import 'package:yoursportz/presentation/home/home_screen.dart';
import 'package:yoursportz/presentation/myfootball/my_football_screen.dart';
import 'package:yoursportz/presentation/profile/user_profile_screen.dart';
import 'package:yoursportz/presentation/profile/profile_screen.dart';
import 'package:yoursportz/presentation/search/search_screen.dart';
import 'package:yoursportz/presentation/tournament/live_match.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';

@RoutePage()
class AppBaseScreen extends StatefulWidget {
  const AppBaseScreen({super.key, required this.phone});
  final String phone;
  @override
  State<AppBaseScreen> createState() => _AppBaseScreenState();
}

class _AppBaseScreenState extends State<AppBaseScreen> {
  int currentIndex = 0;
  List<Widget> destinations = [];
  BottomNavigationBarItem bottomItem(
    String name,
    String image,
    bool isSelected,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(4),
        child: Image.asset(
          image,
          height: 20.h,
          width: 20.w,
          color: isSelected
              ? const Color.fromARGB(255, 250, 100, 100)
              : Colors.grey,
        ),
      ),
      label: name,
    );
  }

  AppBar homeWidgetsAppBar(int index) {
    switch (index) {
      case 0:
        return AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 0,
          elevation: 6,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0,
          toolbarHeight: 130,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: HomeAppbarWidget(phone: widget.phone),
        );
      case 1:
        return AppBar(
          leadingWidth: 0,
          elevation: 6,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0,
          toolbarHeight: 130,
          backgroundColor: Colors.white,
          title: const FindAppbarWidget(),
        );
      case 2:
        return AppBar(
          leadingWidth: 0,
          elevation: 6,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0,
          toolbarHeight: 130,
          backgroundColor: Colors.white,
          title: const MyFootballAppbar(),
        );

      case 3:
        return AppBar(
          leadingWidth: 0,
          elevation: 6,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0,
          toolbarHeight: 130,
          backgroundColor: Colors.white,
          title: const ClipsAppbarWidget(),
        );
      case 4:
        return AppBar(
          leadingWidth: 0,
          elevation: 6,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0,
          toolbarHeight: 300,
          backgroundColor: Colors.white,
          title: MyProfileAppbarWidget(phone: widget.phone),
        );
      default:
        return AppBar();
    }
  }

  @override
  void initState() {
    destinations = [
      const HomeScreen(),
      const SearchScreen(),
      const MyFootballScreen(),
      ProfileScreen(phone: widget.phone),
      // const ClipsScreen(),
      UserProfileScreen(phone: widget.phone)
    ];
    DeeplinkHandling().initUniLinks(context);

    Provider.of<AppBaseProvider>(context, listen: false)
        .storeUserCredentials(widget.phone);
    if (widget.phone != "guest") {
      Provider.of<AppBaseProvider>(context, listen: false)
          .getUserDetails(widget.phone);
    }
    socket =
        IO.io("https://yoursportzbackend.azurewebsites.net/", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    socket.connect();
    socket.emit('streamStatus', {'activate': true});
    socket.on('status', (data) async {
      Provider.of<AppBaseProvider>(context, listen: false)
          .socketConnection(context, data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppBaseProvider>(
      builder: (context, appState, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: homeWidgetsAppBar(currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            selectedLabelStyle: const TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 250, 100, 100),
                fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                const TextStyle(fontSize: 13, color: Colors.grey),
            type: BottomNavigationBarType.fixed,
            items: [
              bottomItem(
                LocaleKeys.home.tr(),
                "assets/images/bn1.png",
                currentIndex == 0,
              ),
              bottomItem(
                LocaleKeys.find.tr(),
                "assets/images/bn2.png",
                currentIndex == 1,
              ),
              bottomItem(
                LocaleKeys.my_football.tr(),
                "assets/images/bottom_football.png",
                currentIndex == 2,
              ),
              bottomItem(
                "Chat",
                Assets.images.chatIconImage.path,
                currentIndex == 3,
              ),
              bottomItem(
                LocaleKeys.profile.tr(),
                "assets/images/bn5.png",
                currentIndex == 4,
              ),
            ],
            currentIndex: currentIndex,
            selectedItemColor: const Color.fromARGB(255, 250, 100, 100),
            onTap: (val) {
              setState(() {
                currentIndex = val;
              });
            },
          ),
          drawer: HomeDrawerWidget(phone: widget.phone),
          body: destinations[currentIndex],
        );
      },
    );
  }
}
