class Tracker {
  final int? id;
  final DateTime startDate;
  final Duration duration;
  final String activity;

  Tracker({
    this.id,
    required this.startDate,
    required this.duration,
    required this.activity,
  });
}
