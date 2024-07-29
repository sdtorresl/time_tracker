import 'package:time_tracker/src/tracker/domain/entity/tracker.dart';

abstract class TrackerRepository {
  Future<void> add(Tracker tracker);
  Future<void> update(Tracker tracker);
  Future<void> delete(Tracker tracker);
  Future<List<Tracker>> list();
}
