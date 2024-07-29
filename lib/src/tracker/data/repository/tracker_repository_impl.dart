import 'package:time_tracker/src/tracker/data/datasources/tracker_local_datasource.dart';
import 'package:time_tracker/src/tracker/data/model/tracker_model.dart';
import 'package:time_tracker/src/tracker/domain/entity/tracker.dart';
import 'package:time_tracker/src/tracker/domain/repository/tracker_repository.dart';

class TrackerRepositoryImpl implements TrackerRepository {
  final TrackerLocalDatasource localDatasource;
  TrackerRepositoryImpl({required this.localDatasource});
  @override
  Future<void> add(Tracker tracker) {
    TrackerModel trackerModel = TrackerModel.fromEntity(tracker);
    return localDatasource.save(trackerModel);
  }

  @override
  Future<void> delete(Tracker tracker) {
    TrackerModel trackerModel = TrackerModel.fromEntity(tracker);
    return localDatasource.delete(trackerModel.id!);
  }

  @override
  Future<List<Tracker>> list() {
    return localDatasource.fetchAll();
  }

  @override
  Future<void> update(Tracker tracker) {
    TrackerModel trackerModel = TrackerModel.fromEntity(tracker);
    return localDatasource.fetch(trackerModel.id!);
  }
}
