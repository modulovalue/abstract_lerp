import 'package:abstract_dart/abstract_dart.dart';
import 'package:decimal/decimal.dart';

/// Base class for interpolation implementations.
abstract class Lerp<T> {
  T lerp(T t);

  T reLerp(T t);
}

/// A [Lerp] based on a [Field_].
class FieldLerp<T> implements Lerp<T> {
  final T from;
  final T to;
  final Field_<T> field;

  const FieldLerp(this.from, this.to, this.field)
      : assert(from != null),
        assert(to != null),
        assert(field != null);

  /// Linearly interpolates between [from] and [to].
  @override
  T lerp(T t) {
    return field.addition.operate(
      field.addition.inverse(
        from,
        field.multiplication.operate(from, t),
      ),
      field.multiplication.operate(to, t),
    );
  }

  /// Inverse of [lerp].
  /// Example:
  ///
  ///     from = 10
  ///     to = 20
  ///     reLerp(15) // 0.5
  ///
  @override
  T reLerp(T t) {
    return field.multiplication.inverse(
      field.addition.inverse(t, from),
      field.addition.inverse(to, from),
    );
  }

  FieldLerp<T> copyWith({T from, T to}) =>
      FieldLerp(from ?? this.from, to ?? this.to, field);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldLerp &&
          runtimeType == other.runtimeType &&
          from == other.from &&
          to == other.to &&
          field == other.field;

  @override
  int get hashCode => from.hashCode ^ to.hashCode ^ field.hashCode;
}

class DoubleLerp extends FieldLerp<double> {
  const DoubleLerp(double from, double to)
      : super(from, to, const DoubleField());
}

class DecimalLerp extends FieldLerp<Decimal> {
  const DecimalLerp(Decimal from, Decimal to)
      : super(from, to, const DecimalField());
}

class NumLerp extends FieldLerp<num> {
  const NumLerp(num from, num to) : super(from, to, const NumField());
}
