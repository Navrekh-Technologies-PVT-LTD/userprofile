import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  // Capitalize the first letter of a string
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

extension NavigationExtensions on BuildContext {
  void navigate(PageRouteInfo route) {
    AutoRouter.of(this).push(route);
  }

  void popBack() {
    AutoRouter.of(this).popForced();
  }
}
