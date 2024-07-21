class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() {
    return message;
  }
}