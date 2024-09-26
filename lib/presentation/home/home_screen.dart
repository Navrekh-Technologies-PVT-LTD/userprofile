import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoursportz/presentation/home/home_layout.dart';
import 'package:yoursportz/providers/appbase/app_base_provider.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppBaseProvider>(
      builder: (context, appBaseState, child) {
        return HomeLayout(
          searchtext: appBaseState.searchcontroller.text,
        );
      },
    );
  }
}
