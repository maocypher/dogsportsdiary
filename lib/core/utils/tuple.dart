class Tuple<T, U> {
  final T key;
  final U value;

  Tuple(this.key, this.value);

  @override
  String toString() {
    return '$key - $value';
  }
}