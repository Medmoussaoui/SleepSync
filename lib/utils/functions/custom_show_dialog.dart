import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/custom_dialog.dart';

customShowDialog(Widget widget) {
  Get.dialog(
    widget,
    barrierColor: Colors.transparent,
    barrierDismissible: true,
  );

  // return showDialog(
  //   context: context,
  //   barrierDismissible: true, // Close dialog on tap outside
  //   barrierColor: Colors.transparent,
  // );
}
