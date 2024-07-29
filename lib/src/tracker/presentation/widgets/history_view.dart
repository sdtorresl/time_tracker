import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/src/core/data/datasources/database.dart';
import 'package:time_tracker/src/core/extensions/datetime.dart';
import 'package:time_tracker/src/core/extensions/duration.dart';
import 'package:time_tracker/src/tracker/data/datasources/tracker_local_datasource.dart';
import 'package:time_tracker/src/tracker/data/repository/tracker_repository_impl.dart';
import 'package:time_tracker/src/tracker/presentation/controller/history_controller.dart';

class HistoryViewWidget extends StatelessWidget {
  const HistoryViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HistoryController>(
      create: (context) => HistoryController(
        trackerRepository: TrackerRepositoryImpl(
          localDatasource: TrackerLocalDatasource(
            databaseProvider: AppDatabase(),
          ),
        ),
      )..getItems(),
      child: Builder(
        builder: (context) {
          return ListenableBuilder(
              listenable: context.read<HistoryController>(),
              builder: (context, child) {
                var controller = context.read<HistoryController>();
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: controller.trackerItems
                      .map(
                        (item) => ListTile(
                          leading: Text(item.id?.toString() ?? ""),
                          title: Text(item.activity),
                          subtitle: Text(item.startDate.toHumanReadable()),
                          trailing: Text(item.duration.format()),
                        ),
                      )
                      .toList(),
                );
              });
        },
      ),
    );
  }
}
