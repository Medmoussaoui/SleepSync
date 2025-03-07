import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/Data/static/index.dart';
import 'package:sleepcyclesapp/components/CustompaperContent/paper_content_widget.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Privacy Policy & Terms",
          style: AppTextStyles.headline3medium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: ListView(
          children: [
            SizedBox(height: 20),
            CustomPaperContent(content: StaticData.privacyPolicyInformation),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
