import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/components/CustomTouchScreenLisener/controller.dart';

class CustomTouchScreenLisener extends StatelessWidget {
  final Widget child;

  const CustomTouchScreenLisener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        TouchScreenLisener.controller.add(ScreenTouchEvents.tap);
      },
      onPointerUp: (details) {
        TouchScreenLisener.controller.add(ScreenTouchEvents.none);
      },
      child: child,
    );
  }
}
