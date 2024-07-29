import 'package:flutter/material.dart';
import 'package:time_tracker/src/tracker/domain/repository/tracker_repository.dart';

import '../../domain/entity/tracker.dart';

class HistoryController with ChangeNotifier {
  final TrackerRepository trackerRepository;
  bool isLoading = true;

  List<Tracker> trackerItems = [];

  HistoryController({required this.trackerRepository});

  getItems() async {
    isLoading = true;
    notifyListeners();
    trackerItems = await trackerRepository.list();
    isLoading = false;
    notifyListeners();
  }
}
