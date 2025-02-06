import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sleepcyclesapp/utils/images.dart';

class ClockCounter extends StatefulWidget {
  final int max;
  final int min;
  final int initialValue;
  final Function(int value) onMoving;
  final Function(int value) onChange;

  const ClockCounter({
    super.key,
    required this.max,
    required this.min,
    required this.onMoving,
    required this.onChange,
    required this.initialValue,
  });

  @override
  ClockCounterState createState() => ClockCounterState();
}

class ClockCounterState extends State<ClockCounter> {
  int value = 0; // عدد الدورات الافتراضي
  double rotationAngle = 0.0; // زاوية الدوران الافتراضية
  double sensitivity = 0.01; // حساسية الدوران

  double steep = 1;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    double angle =
        details.primaryDelta! * sensitivity; // حساب الزاوية بناءً على الحركة
    steep += angle;

    if (steep.abs() >= 0.16) {
      int newValue = value + (steep > 0 ? 1 : -1);

      if (newValue >= widget.min && newValue <= widget.max) {
        value = newValue;
        rotationAngle += angle;
        setState(() {});
      }

      steep = 0; // إعادة ضبط `steep` بعد كل تحديث
    } else {
      if (value == widget.min || value == widget.max) return;
      rotationAngle += angle; // السماح بحركة سلسة حتى بدون تغيير العدد
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onVerticalDragUpdate: _onVerticalDragUpdate,
        child: Transform.rotate(
          angle: rotationAngle,
          child: Image.asset(
            AppImages.testClock,
            width: 300,
            height: 300,
          ),
        ).animate().fade(duration: 500.ms),
        // child: Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     Transform.rotate(
        //       angle: rotationAngle,
        //       child: Image.asset(
        //         AppImages.testClock,
        //         width: 300,
        //         height: 300,
        //       ),
        //     ).animate().fade(duration: 500.ms),
        //     Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         AnimatedSwitcher(
        //           duration: 300.ms,
        //           transitionBuilder: (child, animation) =>
        //               FadeTransition(opacity: animation, child: child),
        //           child: Text(
        //             '$value',
        //             key: ValueKey(value),
        //             style: const TextStyle(
        //               fontSize: 50,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.white,
        //             ),
        //           ),
        //         ),
        //         Text(
        //           widget.hint,
        //           style: TextStyle(fontSize: 18, color: Colors.white70),
        //         ).animate().fade(duration: 800.ms).slideY(),
        //       ],
        //     )
        //   ],
        // ),
      ),
    );
  }
}
