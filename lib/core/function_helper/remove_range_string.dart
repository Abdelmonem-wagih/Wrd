String extractDesiredString(String input) {
  List<String> words =
      input.split(','); // Split the string into words using ','
  if (words.length >= 3) {
    words.removeRange(
        words.length - 3, words.length); // Remove the last two words
    return words
        .join(',')
        .trim(); // Join the remaining words back into a string separated by ',' and trim any leading/trailing whitespace
  } else {
    return input; // Return the original string if it has fewer than three words
  }
}

String extractLastWord(String input) {
  List<String> words = input.split(','); // Split the string by commas
  String lastWord = words.last.trim();
  return lastWord;
}

String removeWordBeforeLast(String input) {
  List<String> words = input.split(' '); // Split the string into words
  if (words.length >= 2) {
    words.removeAt(
        words.length - 2); // Remove the word at the second-to-last position
    return words.join(' '); // Join the remaining words back into a string
  } else {
    return input; // Return the original string if it has fewer than two words
  }
}
