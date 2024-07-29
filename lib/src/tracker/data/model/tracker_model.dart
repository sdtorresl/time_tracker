import 'package:time_tracker/src/core/data/model/model.dart';
import 'package:time_tracker/src/tracker/domain/entity/tracker.dart';

class TrackerModel extends Tracker implements Model<Tracker> {
  TrackerModel({
    required super.startDate,
    required super.duration,
    required super.activity,
  });

  @override
  Tracker toEntity() {
    return Tracker(
      startDate: startDate,
      duration: duration,
      activity: activity,
    );
  }

  factory TrackerModel.fromEntity(Tracker entity) {
    return TrackerModel(
      startDate: entity.startDate,
      duration: entity.duration,
      activity: entity.activity,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate.toIso8601String(),
      'duration': duration.inSeconds,
      'activity': activity,
    };
  }

  @override
  factory TrackerModel.fromMap(Map<String, dynamic> map) {
    return TrackerModel(
      startDate: DateTime.parse(map['startDate']),
      duration: Duration(seconds: map['duration']),
      activity: map['activity'],
    );
  }
}
