import 'dart:async';
import 'package:flutter/material.dart';

class ScreenLifeCycleStateController {
  ScreenLifeCycleStateController() {
    screenState = StreamController.broadcast();
  }

  late StreamController<AppLifecycleState> screenState;

  dispose() {
    screenState.close();
  }
}

class ScreenLifeCycleState extends StatefulWidget {
  ///
  /// to clear the [controller] stream lisener
  final bool? clear;

  ///
  /// when screen is close the [controller] will automaticly closed if [clear] = true
  ///
  final ScreenLifeCycleStateController controller;

  ///
  /// the [child] is the Screen Widget (home,settings...)
  final Widget child;

  const ScreenLifeCycleState(
      {super.key, required this.controller, required this.child, this.clear});

  @override
  State<ScreenLifeCycleState> createState() => _ScreenLifeCycleStateState();
}

class _ScreenLifeCycleStateState extends State<ScreenLifeCycleState>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (widget.clear == true) widget.controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("App state changed: $state");
    widget.controller.screenState.add(state);
    // if (state == AppLifecycleState.resumed) {
    //   print("✅ App is in the foreground (resumed)");
    // } else if (state == AppLifecycleState.paused) {
    //   print("⏸️ App is paused (background but still running)");
    // } else if (state == AppLifecycleState.detached) {
    //   print("❌ App is closed (detached)");
    // } else if (state == AppLifecycleState.inactive) {
    //   print("🔸 App is inactive (e.g., call or losing focus)");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
