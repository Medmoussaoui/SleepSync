import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/Data/static/index.dart';
import 'package:sleepcyclesapp/components/custom_dialog.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/custom_tile.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/components/selectVebration/controller.dart';
import 'package:sleepcyclesapp/components/with_separate_size.dart';
import 'package:sleepcyclesapp/entitys/vebration_type_entity.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';

class SelectVebrationDialog extends StatelessWidget {
  final Function(VebrationTypeEntity vebration) onChange;

  const SelectVebrationDialog({super.key, required this.onChange});

  CustomTile _vebrationItemWidget({
    required bool isSelected,
    required VebrationTypeEntity vebration,
    required void Function() onTap,
  }) {
    return CustomTile(
      title: vebration.name,
      subtitle: vebration.description,
      borderColor: AppColors.white.withOpacity(0.07),
      leadingIcon: CustomIcon(background: true, icon: AppIcons.vebration),
      trailingWidget: CustomIcon(
        icon: AppIcons.done,
        color: isSelected
            ? AppColors.primaryBtnColor
            : AppColors.secondaryTextColor.withOpacity(0.4),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller =  Get.put(SelectVebrationController());
    final data = StaticData.vebrationTypes;
    return CustomDialog(
      title: "Vibration Sensitivity",
      content: Material(
        color: Colors.transparent,
        child: GetBuilder<SelectVebrationController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: data
                  .map((vebration) => WithSeparateSize(
                        size: 10,
                        enable: vebration.name != data.last.name,
                        child: _vebrationItemWidget(
                            isSelected: vebration.name == controller.selectedVebration.name,
                            vebration: vebration,
                            onTap: () => controller.selectVebration(vebration)),
                      ))
                  .toList(),
            );
          },
        ),
      ),
      action: PrimaryButton(
        text: "Apply",
        onPressed: () {
          controller.applyChange(onChange);
        },
      ),
    );
  }
}
