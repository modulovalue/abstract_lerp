import 'package:abstract_dart/abstract_dart.dart';
import 'package:abstract_lerp/abstract_lerp.dart';
import 'package:decimal/decimal.dart';

void main() {
  /// A double lerp.
  const Lerp<double> _double = DoubleLerp(10.0, 20.0);

  /// A num lerp.
  const Lerp<num> _num = NumLerp(10.0, 20.0);

  /// A decimal lerp.
  final Lerp<Decimal> _decimal =
      DecimalLerp(Decimal.fromInt(10), Decimal.fromInt(20));

  /// A custom lerp.
  ///
  /// Multiplication, division, addition and subtraction are needed for a lerp.
  /// A Field provides all of that.
  final FieldLerp<double> _customLerp = FieldLerp(
    /// from
    10.0,

    /// to
    20.0,
    Field_.create(
      /// addition
      Group_.create(() => 0.0, (a, b) => a + b, (a, b) => a - b),

      /// multiplication
      Group_.create(() => 1.0, (a, b) => a * b, (a, b) => a / b),
    ),
  );

  print(_double.lerp(0.7)); // 17.0;
  print(_double.reLerp(17.0)); // 0.7;
  print(_num.lerp(0.7)); // 17.0;
  print(_num.reLerp(17.0)); // 0.7;
  print(_decimal.lerp(Decimal.parse("0.7"))); // 17.0;
  print(_decimal.reLerp(Decimal.parse("17"))); // 0.7;
  print(_customLerp.lerp(0.7)); // 17.0;
  print(_customLerp.reLerp(17.0)); // 0.7;

  final fromZero = _customLerp.copyWith(from: 0.0);

  print(fromZero.lerp(0.7)); // 14.0;
  print(_customLerp.reLerp(14.0)); // 0.7;
}
