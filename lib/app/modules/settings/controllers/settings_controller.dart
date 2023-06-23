import 'package:flutter/material.dart';
import 'package:get/get.dart';

final isDarkMode = false.obs;

class SettingsController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;

  void toggleDarkMode(bool value) {
    if (value) {
      Get.changeTheme(ThemeData.dark());
      isDarkMode.value = value;
      print('theme called $value');
    } else {
      Get.changeTheme(ThemeData.light());
      isDarkMode.value = value;
      print('theme called $value');
    }
  }
}
