import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/src/tracker/presentation/controller/tracker_controller.dart';

class SaveDialog extends StatelessWidget {
  const SaveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final trackerController = Provider.of<TrackerController>(context);

    return AlertDialog(
      title: const Text('Enter Activity'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              trackerController.updateActivity(value);
            },
            decoration: const InputDecoration(
              hintText: 'Activity',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: trackerController.isSubmitEnabled
              ? () {
                  trackerController.stopCron();
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
