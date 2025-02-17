import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sleepcyclesapp/utils/images.dart';

class ClockCounter extends StatefulWidget {
  final int max;
  final int min;
  final int initialValue;
  final Function(int value) onMoving;
  final Function(int value) onChange;
  final Function(int value)? onDone;

  const ClockCounter({
    super.key,
    required this.max,
    required this.min,
    required this.onMoving,
    required this.onChange,
    required this.initialValue,
    this.onDone,
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
        widget.onChange(value);
        setState(() {});
      }

      steep = 0; // إعادة ضبط `steep` بعد كل تحديث
    } else {
      if (value == widget.min || value == widget.max) return;
      rotationAngle += angle; // السماح بحركة سلسة حتى بدون تغيير العدد
      setState(() {});
    }
    widget.onMoving(value);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: (details) {
          if (widget.onDone != null) widget.onDone!(value);
        },
        child: Transform.rotate(
          angle: rotationAngle,
          child: Image.asset(
            AppImages.testClock,
            width: 300,
            height: 300,
            opacity: AlwaysStoppedAnimation(0.8),
          ),
        ).animate().fade(duration: 500.ms),
      ),
    );
  }
}
