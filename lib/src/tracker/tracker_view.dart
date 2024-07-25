import 'package:flutter/material.dart';
import 'package:time_tracker/src/tracker/cron_view.dart';
import 'package:time_tracker/src/tracker/tracker_controller.dart';

enum TrackerViews { tracker, history }

class TrackerView extends StatefulWidget {
  const TrackerView({super.key});

  static const routeName = '/';

  @override
  State<TrackerView> createState() => _TrackerViewState();
}

class _TrackerViewState extends State<TrackerView> {
  final TrackerController trackerController = TrackerController();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Tracker"),
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
                  : const Text("History"),
            ),
          ],
        ),
      ),
    );
  }
}
