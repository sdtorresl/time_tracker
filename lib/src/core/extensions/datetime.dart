import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toHumanReadable() {
    final DateFormat formatter = DateFormat('EEEE, MMM d, y h:mm a');
    return formatter.format(this);
  }
}
