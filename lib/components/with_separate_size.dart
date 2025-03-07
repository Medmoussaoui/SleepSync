import 'package:flutter/material.dart';

class WithSeparateSize extends StatelessWidget {
  final Widget child;
  final double size;
  final bool enable;
  const WithSeparateSize({
    super.key,
    required this.child,
    required this.size,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size),
      child: child,
    );
  }
}
