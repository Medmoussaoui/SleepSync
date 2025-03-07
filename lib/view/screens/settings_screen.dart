import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/controllers/settings_screen_controller.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';
import 'package:sleepcyclesapp/view/widgets/settingScreen/app_settings.dart';
import 'package:sleepcyclesapp/view/widgets/settingScreen/guide_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsScreenController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Settings",
          style: AppTextStyles.headline3medium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            SizedBox(height: 30),
            AppSettingContainer(),
            SizedBox(height: 20),
            AppSettingGuideSection(),
          ],
        ),
      ),
    );
  }
}
