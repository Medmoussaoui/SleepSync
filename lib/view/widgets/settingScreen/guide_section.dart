import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/custom_tile.dart';
import 'package:sleepcyclesapp/components/custom_tile_container.dart';
import 'package:sleepcyclesapp/controllers/settings_screen_controller.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';

class AppSettingGuideSection extends GetView<SettingsScreenController> {
  const AppSettingGuideSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTileContainer(
      children: [
        CustomTile(
          key: ValueKey("ContactSupport"),
          padding: false,
          title: "Contact Support",
          subtitle: "support@SleepSync.com",
          leadingIcon: CustomIcon(
            icon: AppIcons.support,
            background: true,
          ),
          onTap: () {
            controller.sendEmailToSupport();
          },
        ),
        CustomTile(
          key: ValueKey("Privacy Policy & Terms"),
          padding: false,
          title: "Privacy Policy & Terms",
          leadingIcon: CustomIcon(
            icon: AppIcons.docs,
            background: true,
          ),
          onTap: () {
            Get.toNamed(AppRoutes.privacyPolicyScreen);
          },
        ),
      ],
    );
  }
}
