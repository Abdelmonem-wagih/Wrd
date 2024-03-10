import 'package:intl/intl.dart';

String updateTime(String timeString) {
  DateTime currentTime = DateFormat('HH:mm', 'en').parse(timeString);
  String formattedTime = DateFormat('HH:mm', 'en').format(currentTime);
  return formattedTime;
}

DateTime changeDateToCurrent(DateTime originalDateTime) {
  final currentDate = DateTime.now(); // Get the current date
  return DateTime(
    currentDate.year,
    currentDate.month,
    currentDate.day,
    originalDateTime.hour,
    originalDateTime.minute,
    originalDateTime.second,
    originalDateTime.microsecond,
  );
}
