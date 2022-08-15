extension DoubleNUtils on double? {
  bool get isNotNullOrZero => this != null && this != 0.0;

  /// returns the other if receiver is not null
  double? other(double other) {
    if (this != null) {
      return other;
    } else {
      return null;
    }
  }
}

extension DoubleUtils on double {
  /// returns 0.0 if sum results to negative value
  double positiveOrZero(double space) {
    final result = add(space);
    return result >= 0.0 ? result : 0.0;
  }

  /// add function for nullable double
  double add(double other) => this + other;

  /// returns difference for reuse
  double getOverrideAdjustment(double other) {
    return other - this;
  }
}
