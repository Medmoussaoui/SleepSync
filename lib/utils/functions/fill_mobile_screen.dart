import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

fillMobileScreen({bool hideStatusBar = false}) {
  List<SystemUiOverlay> overlays = [];
  if (!hideStatusBar) overlays.add(SystemUiOverlay.top);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: overlays,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}
