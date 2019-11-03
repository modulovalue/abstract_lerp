import 'package:abstract_dart/abstract_dart.dart';
import 'package:abstract_lerp/abstract_lerp.dart';
import 'package:test/test.dart';
import 'package:decimal/decimal.dart';

// for coverage
// ignore_for_file: prefer_const_constructors
void main() {
  group("$DoubleLerp", () {
    test("not null", () {
      // ignore: prefer_const_constructors
      expect(() => DoubleLerp(null, 1.0),
          throwsA(const TypeMatcher<AssertionError>()));
      // ignore: prefer_const_constructors
      expect(() => DoubleLerp(1.0, null),
          throwsA(const TypeMatcher<AssertionError>()));
      expect(() => FieldLerp<double>(1.0, 2.0, null),
          throwsA(const TypeMatcher<AssertionError>()));
    });

    test("lerp negative & positive", () {
      const range = DoubleLerp(-100.0, 100.0);
      expect(range.lerp(0.0), -100.0);
      expect(range.lerp(0.5), 0.0);
      expect(range.lerp(1.0), 100.0);
      expect(range.lerp(2.0), 300.0);
      expect(range.lerp(10.0), 1900.0);
      expect(range.lerp(-1.0), -300.0);
    });

    test("reLerp negative & positive", () {
      const range = DoubleLerp(-100.0, 100.0);
      expect(range.reLerp(0.0), 0.5);
      expect(range.reLerp(100.0), 1.0);
      expect(range.reLerp(1000.0), 5.5);
      expect(range.reLerp(-100.0), 0.0);
      expect(range.reLerp(50.0), 0.75);
    });

    test("lerp ascending", () {
      const range = DoubleLerp(0.0, 100.0);
      expect(range.lerp(0.0), 0.0);
      expect(range.lerp(0.5), 50.0);
      expect(range.lerp(1.0), 100.0);
      expect(range.lerp(10.0), 1000.0);
      expect(range.lerp(-1.0), -100.0);
    });

    test("lerp descending", () {
      const range = DoubleLerp(100.0, 0.0);
      expect(range.lerp(0.0), 100.0);
      expect(range.lerp(0.5), 50.0);
      expect(range.lerp(1.0), 0.0);
      expect(range.lerp(10.0), -900.0);
      expect(range.lerp(-1.0), 200.0);
    });

    test("reLerp ascending", () {
      const range = DoubleLerp(0.0, 100.0);
      expect(range.reLerp(0.0), 0.0);
      expect(range.reLerp(100.0), 1.0);
      expect(range.reLerp(1000.0), 10.0);
      expect(range.reLerp(-100.0), -1.0);
      expect(range.reLerp(50.0), 0.5);
    });

    test("reLerp descending", () {
      const range = DoubleLerp(100.0, 0.0);
      expect(range.reLerp(0.0), 1.0);
      expect(range.reLerp(100.0), 0.0);
      expect(range.reLerp(1000.0), -9.0);
      expect(range.reLerp(-100.0), 2.0);
      expect(range.reLerp(50.0), 0.5);
    });

    test("copyWith", () {
      expect(const DoubleLerp(2.0, 1.0).copyWith(from: 3.0).from, 3.0);
      expect(const DoubleLerp(2.0, 1.0).copyWith(from: 3.0).to, 1.0);
      expect(const DoubleLerp(2.0, 1.0).copyWith(to: 3.0).from, 2.0);
      expect(const DoubleLerp(2.0, 1.0).copyWith(to: 3.0).to, 3.0);
    });

    test("==", () {
      expect(const DoubleLerp(2.0, 2.0), const DoubleLerp(2.0, 2.0));
    });

    test("!=", () {
      expect(const NumLerp(2.0, 2.0), isNot(const DoubleLerp(2.0, 2.0)));
      expect(const DoubleLerp(2.0, 1.0), isNot(const DoubleLerp(2.0, 2.0)));
      expect(
          FieldLerp<double>(
                        2.0,
                        1.0,
                        Field_.create(
                          Group_.create<double>(
                              () => 0.0, (a, b) => a + b, (a, b) => a - b),
                          Group_.create<double>(
                              () => 1.0, (a, b) => a * b, (a, b) => a / b),
                        )),
          isNot(FieldLerp<double>(
              2.0,
              1.0,
              Field_.create(
                Group_.create<double>(
                    () => 0.0, (a, b) => a + b, (a, b) => a - b),
                Group_.create<double>(
                    () => 1.0, (a, b) => a * b, (a, b) => a / b),
              ))));
    });

    test("hashCode", () {
      expect(const DoubleLerp(2.0, 2.0).hashCode,
          const DoubleLerp(2.0, 2.0).hashCode);
      expect(const DoubleLerp(2.0, 1.0).hashCode,
          isNot(const DoubleLerp(2.0, 2.0).hashCode));
      expect(const NumLerp(2.0, 1.0).hashCode,
          isNot(const DoubleLerp(2.0, 2.0).hashCode));
    });
  });

  group("$DecimalLerp", () {
    test("$DecimalLerp", () {
      expect(
          DecimalLerp(Decimal.fromInt(0), Decimal.fromInt(10))
              .lerp(Decimal.parse("0.5")),
          Decimal.fromInt(5));
    });
  });

  group("$NumLerp", () {
    test("$NumLerp", () {
      expect(NumLerp(1.0, 2.0).lerp(0.5), 1.5);
    });
  });
}
