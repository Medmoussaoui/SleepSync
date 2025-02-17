import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class SwipeUp extends StatelessWidget {
  final String text;
  final Widget child;
  final VoidCallback onSwipe;
  final Color? textColor;
  final Color? iconColor;

  const SwipeUp({
    super.key,
    required this.text,
    required this.onSwipe,
    required this.child,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Align(alignment: Alignment.bottomCenter, child: child),
        _SwipeUpWidget(
          text: text,
          onSwipe: onSwipe,
        ),
      ],
    );
  }
}

class _SwipeUpWidget extends StatefulWidget {
  final String text;
  final VoidCallback onSwipe;
  final Color? textColor;
  final Color? iconColor;

  const _SwipeUpWidget({
    required this.text,
    required this.onSwipe,
    this.textColor,
    this.iconColor,
  });

  @override
  State<_SwipeUpWidget> createState() => _SwipeUpWidgetState();
}

class _SwipeUpWidgetState extends State<_SwipeUpWidget> {
  double swipeSize = -5;
  final double sensitivity = 0.5;
  final double triggerThreshold =
      1000.0; // Distance needed to trigger swipe action

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      double moveSize = details.primaryDelta! * sensitivity;

      swipeSize = moveSize.isNegative
          ? swipeSize + moveSize
          : -(swipeSize.abs() - moveSize);
      // swipeSize = swipeSize.clamp(0, -triggerThreshold); // Prevent over-dragging
      // Prevent over-dragging
      swipeSize = swipeSize.clamp(-200, -5);
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (swipeSize <= -200) {
      widget.onSwipe(); // Trigger the swipe action
    }
    setState(() {
      swipeSize = -5; // Reset position
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: -5, end: swipeSize),
        duration: 225.ms,
        builder: (_, value, child) {
          return Transform.translate(
            offset: Offset(0.0, value),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    ColorizeAnimatedText(
                      widget.text,
                      textStyle: TextStyle(
                        color: (widget.textColor ?? Color(0xffB0B0B0))
                            .withOpacity(0.2),
                        fontSize: 14.0,
                      ),
                      colors: [
                        (widget.textColor ?? Color(0xffB0B0B0))
                            .withOpacity(0.4),
                        (widget.textColor ?? Color(0xffB0B0B0))
                            .withOpacity(0.1),
                      ],
                    )
                  ],
                ),
                Lottie.asset(
                  'assets/animations/swipeup.json', // Replace with your actual path
                  height: 90,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
