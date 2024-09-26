import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

class DeeplinkHandling {
  Future<void> initUniLinks(BuildContext context) async {
    final appLinks = AppLinks(); // AppLinks is singleton

    // Subscribe to all events (initial link and further)
    appLinks.uriLinkStream.listen((uri) {
      // Do something (navigation, ...)
    });
  }
}
