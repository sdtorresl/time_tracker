import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker/src/tracker/domain/entity/tracker.dart';
import 'package:time_tracker/src/tracker/domain/repository/tracker_repository.dart';

class TrackerController with ChangeNotifier {
  final TrackerRepository trackerRepository;
  final int alertIntervalMinutes;

  DateTime? startTime;
  DateTime? pauseTime;
  Duration elapsedTime = Duration.zero;
  String? note;
  bool isRunning = false;
  Timer? _timer;
  String _activity = '';

  bool _isSubmitEnabled = false;
  AudioPlayer audioPlayer = AudioPlayer();

  TrackerController({
    required this.trackerRepository,
    this.alertIntervalMinutes = 15,
  });

  String get activity => _activity;
  bool get isSubmitEnabled => _isSubmitEnabled;

  void updateActivity(String value) {
    _activity = value;
    _isSubmitEnabled = value.isNotEmpty;
    notifyListeners();
  }

  void startCron() {
    if (!isRunning) {
      startTime ??= DateTime.now();
      isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), _updateCron);
    }
  }

  void _updateCron(_) {
    elapsedTime = Duration(milliseconds: elapsedTime.inMilliseconds + 1000);
    notifyListeners();
    if (elapsedTime.inSeconds % (alertIntervalMinutes * 60) == 0) {
      _playAlert();
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

      trackerRepository.add(Tracker(
          startDate: startTime!, duration: elapsedTime, activity: _activity));

      pauseTime = null;
      elapsedTime = Duration.zero;
      startTime = null;
      isRunning = false;

      notifyListeners();
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

  void _playAlert() {
    audioPlayer.play(AssetSource(
        'sounds/alert.mp3')); // Replace with appropriate system sound if available
  }

  @override
  void dispose() {
    _timer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }
}
