
String formatTime(String timeString) {
  int index = timeString.indexOf('(');
  if (index != -1) {
    timeString = timeString.substring(0, index).trim();
  }

  return timeString;
}
