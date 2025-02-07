import 'package:flutter/cupertino.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class CustomSwitchButton extends StatelessWidget {
  final bool isChecked;
  final void Function(bool state)? onChanged;

  const CustomSwitchButton(
      {super.key, required this.isChecked, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: CupertinoSwitch(
        value: isChecked,
        activeTrackColor: AppColors.primaryBtnColor,
        inactiveTrackColor: AppColors.white.withOpacity(0.2),
        inactiveThumbColor: AppColors.white.withOpacity(0.5),
        onChanged: (state) {},
      ),
    );
  }
}
