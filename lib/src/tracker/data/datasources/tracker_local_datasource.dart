import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:time_tracker/src/core/data/datasources/database.dart';
import 'package:time_tracker/src/tracker/data/model/tracker_model.dart';

class TrackerLocalDatasource {
  final AppDatabase databaseProvider;

  TrackerLocalDatasource({required this.databaseProvider});

  Future<Database> get _db async => await databaseProvider.database;

  Future<void> save(TrackerModel tracker) async {
    final db = await _db;
    await db.insert('tracker', tracker.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(int id) async {
    final db = await _db;
    await db.delete('tracker', where: 'id = ?', whereArgs: [id]);
  }

  Future<TrackerModel?> fetch(int id) async {
    final db = await _db;
    final maps = await db.query('tracker', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return TrackerModel.fromMap(maps.first);
    }
    return null;
  }

  Future<List<TrackerModel>> fetchAll() async {
    final db = await _db;
    final result = await db.query('tracker');
    return result.map((map) => TrackerModel.fromMap(map)).toList();
  }
}
