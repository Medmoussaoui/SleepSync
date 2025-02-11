import 'dart:async';

enum ScreenTouchEvents {
  tap,
  doubleTap,
  longTap,
  none,
}

class TouchScreenLisener {
  static StreamController<ScreenTouchEvents>? _controller;

  static StreamController<ScreenTouchEvents> get controller {
    _controller ??= StreamController.broadcast();
    return _controller!;
  }

  static Stream<ScreenTouchEvents> get screenEvent => controller.stream;
}
