class Tuple<T, U> {
  final T key;
  final U value;

  Tuple(this.key, this.value);

  @override
  String toString() {
    return '$key - $value';
  }

  @override
  bool operator ==(Object other) {
    if (other is Tuple) {
      return key == other.key && value == other.value;
    }
    return false;
  }
}