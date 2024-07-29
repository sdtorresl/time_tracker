import 'package:flutter/material.dart';
import 'package:time_tracker/src/core/extensions/duration.dart';
import 'package:time_tracker/src/tracker/presentation/controller/tracker_controller.dart';

class CronView extends StatelessWidget {
  final TrackerController trackerController;
  const CronView({super.key, required this.trackerController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: trackerController,
        builder: (context, child) {
          return _cronometer(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ListenableBuilder(
        listenable: trackerController,
        builder: (context, child) {
          return FloatingActionButton(
            onPressed: trackerController.isRunning
                ? trackerController.pauseCron
                : trackerController.startCron,
            child: trackerController.isRunning
                ? const Icon(Icons.pause_circle_outline_outlined)
                : const Icon(Icons.play_arrow_outlined),
          );
        },
      ),
    );
  }

  Widget _cronometer(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          trackerController.elapsedTime.format(),
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        trackerController.isRunning
            ? Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: FilledButton.icon(
                    onPressed: trackerController.stopCron,
                    icon: const Icon(Icons.stop_outlined),
                    label: const Text("Stop"),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
