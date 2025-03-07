class CheckSleepInterval {
  List<int> intervals = [2, 1];
  List<int> trys = [4, 1];

  int _pointer = 0;
  int _trys = 0;

  int get interval {
    if (_trys == trys[_pointer]) movePointer();
    _trys++;
    return intervals[_pointer];
  }

  void movePointer() {
    if (_pointer == intervals.length - 1) {
      _pointer = 0;
    } else {
      _pointer++;
    }
    _trys = 0;
  }
}
