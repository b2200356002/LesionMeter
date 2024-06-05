extension IterableX<T extends num> on Iterable<T> {
  T get avg {
    if (isEmpty) return T == int ? 0 as T : 0.0 as T;
    return (reduce((a, b) => (a + b) as T) / length).roundToDouble() as T;
  }

  T get max {
    if (isEmpty) return T == int ? 0 as T : 0.0 as T;
    return reduce((a, b) => a > b ? a : b).roundToDouble() as T;
  }
}
