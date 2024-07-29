import 'dart:async';
import 'package:flutter/foundation.dart';

class TrackerController with ChangeNotifier {
  DateTime? startTime;
  DateTime? pauseTime;
  Duration elapsedTime = Duration.zero;
  String? note;
  bool isRunning = false;
  Timer? _timer;

  void startCron() {
    if (!isRunning) {
      startTime ??= DateTime.now();
      isRunning = true;
      _timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
        elapsedTime = Duration(milliseconds: elapsedTime.inMilliseconds + 1);
        notifyListeners();
      });
    }
  }

  void pauseCron() {
    if (isRunning) {
      _timer?.cancel();
      pauseTime = DateTime.now();
      isRunning = false;
    }
  }

  void stopCron() {
    if (isRunning) {
      _timer?.cancel();
      pauseTime = null;
      elapsedTime = Duration.zero;
      startTime = null;
      isRunning = false;
    }
  }

  void resetCron() {
    _timer?.cancel();
    startTime = null;
    pauseTime = null;
    elapsedTime = Duration.zero;
    isRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
