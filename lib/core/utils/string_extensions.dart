extension StringExtension on String {
  String fixInterpunctuation() {
    return replaceAll(",", ".");
  }
}