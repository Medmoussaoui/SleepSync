import 'package:flutter/material.dart';
import 'package:get/get.dart';

customShowDialog(Widget widget) {
  Get.dialog(
    widget,
    barrierColor: Colors.transparent,
    barrierDismissible: true,
  );
}
