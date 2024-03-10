import 'package:intl/intl.dart';

String removeAmPm(String timeString) {
  DateTime currentTime = DateFormat('HH:mm' , 'en').parse(timeString);
  String formattedTime = DateFormat('hh:mm a' , 'en').format(currentTime);
  final indexOfSpace = formattedTime.lastIndexOf(' ');

  if (indexOfSpace != -1) {
    timeString = formattedTime.substring(0, indexOfSpace);
  }
  return timeString;
}
