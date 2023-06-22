import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:no_screenshot/no_screenshot.dart';

class DashbrdController extends GetxController {
  ThemeMode themeModee = ThemeMode.system;
  void changeTheme(ThemeMode themeMode) {
    themeModee = themeMode;
    update();
  }

  Future<void> preventScreenshots() async {
    final noScreenshot = NoScreenshot.instance;
    await noScreenshot.screenshotOff();
    update();
  }
}
