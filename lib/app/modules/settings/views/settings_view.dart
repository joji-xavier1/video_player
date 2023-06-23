import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_task/app/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);
  final signupController = Get.put<SettingsController>(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dark Mode',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Switch(
                value: isDarkMode.value,
                onChanged: (value) {
                  controller.toggleDarkMode(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
