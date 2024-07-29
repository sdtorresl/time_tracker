import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/src/core/extensions/datetime.dart';
import 'package:time_tracker/src/core/extensions/duration.dart';
import 'package:time_tracker/src/core/presentation/widgets/confirmation_dialog.dart';
import 'package:time_tracker/src/tracker/domain/entity/tracker.dart';
import 'package:time_tracker/src/tracker/presentation/controller/history_controller.dart';

class HistoryViewWidget extends StatefulWidget {
  const HistoryViewWidget({super.key});

  @override
  State<HistoryViewWidget> createState() => _HistoryViewWidgetState();
}

class _HistoryViewWidgetState extends State<HistoryViewWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoryController>(context, listen: false).getItems();
    });
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, Tracker item, HistoryController historyController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Delete Item',
          content: 'Are you sure you want to delete this item?',
          confirmText: 'Delete',
          cancelText: 'Cancel',
          onConfirm: () {
            historyController.delete(item);
            Navigator.of(context).pop(); // Close the dialog
          },
          onCancel: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryController>(
      builder: (context, history, child) {
        if (history.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: history.trackerItems
              .map(
                (item) => ListTile(
                  leading: IconButton(
                    onPressed: () =>
                        _showDeleteConfirmationDialog(context, item, history),
                    icon: Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  title: Text(item.activity),
                  subtitle: Text(item.startDate.toHumanReadable()),
                  trailing: Text(item.duration.format()),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
