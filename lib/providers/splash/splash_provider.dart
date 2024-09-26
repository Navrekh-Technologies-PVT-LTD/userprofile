import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:yoursportz/routing/app_router.gr.dart';

@injectable
class SplashProvider extends ChangeNotifier {
  var theme = 1;
  var userId = "null";

  Future<void> changeColor(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    theme = 2;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    var currentUser = await Hive.openBox('CurrentUser');
    if (currentUser.containsKey('userId')) {
      userId = currentUser.get('userId');
      notifyListeners();
    } else {
      await currentUser.put('userId', "null");
    }
    if (userId == "null") {
      if (context.mounted) {
        AutoRouter.of(context).pushAndPopUntil(
          const OnboardingRoute(),
          predicate: (route) => false,
        );
      }
    } else {
      if (context.mounted) {
        AutoRouter.of(context).pushAndPopUntil(
          AppBaseRoute(phone: userId),
          predicate: (route) => false,
        );
      }
    }
  }
}
