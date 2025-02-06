import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
