import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeWidgetVisibility extends StatefulWidget {
  final Widget child;
  final int? interferenceDelay;
  final int? duration;

  final Function(FadeWidgetVisibilityState state) onContentCompletelyVisible;

  const FadeWidgetVisibility({
    super.key,
    required this.child,
    required this.onContentCompletelyVisible,
    this.interferenceDelay,
    this.duration,
  });

  @override
  State<FadeWidgetVisibility> createState() => FadeWidgetVisibilityState();
}

class FadeWidgetVisibilityState extends State<FadeWidgetVisibility> {
  bool isContentVisible = false;
  late Duration fadeDuration = 400.ms;

  // return true if content is visible
  Future<void> drawContent() async {
    if (isContentVisible) return;
    setState(() => isContentVisible = true);
    final duration = widget.interferenceDelay?.ms ?? fadeDuration;
    await Future.delayed(
        duration, () => widget.onContentCompletelyVisible(this));
  }

  @override
  void initState() {
    fadeDuration = widget.duration?.ms ?? 400.ms;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isContentVisible ? 1 : 0,
      duration: fadeDuration,
      child: widget.child,
    );
  }
}
