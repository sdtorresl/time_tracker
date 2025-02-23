import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/src/settings/settings_view.dart';
import 'package:time_tracker/src/tracker/presentation/widgets/cron_view.dart';
import 'package:time_tracker/src/tracker/presentation/controller/tracker_controller.dart';
import 'package:time_tracker/src/tracker/presentation/widgets/history_view.dart';

enum TrackerViews { tracker, history }

class TrackerView extends StatefulWidget {
  const TrackerView({super.key});

  static const routeName = '/';

  @override
  State<TrackerView> createState() => _TrackerViewState();
}

class _TrackerViewState extends State<TrackerView> {
  late final TrackerController trackerController;

  final List<ButtonSegment<TrackerViews>> segments = [
    const ButtonSegment(
      value: TrackerViews.tracker,
      label: Text("Tracker"),
      icon: Icon(Icons.timelapse_outlined),
    ),
    const ButtonSegment(
      value: TrackerViews.history,
      label: Text("History"),
      icon: Icon(Icons.list_outlined),
    )
  ];

  late Set<dynamic> selected;

  @override
  void initState() {
    super.initState();
    selected = {segments.first.value};
    trackerController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton(
              segments: segments,
              selected: selected,
              onSelectionChanged: (val) {
                setState(() {
                  selected = val;
                });
              },
              multiSelectionEnabled: false,
              showSelectedIcon: false,
            ),
            Expanded(
              child: selected.first == TrackerViews.tracker
                  ? CronView(trackerController: trackerController)
                  : const HistoryViewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
