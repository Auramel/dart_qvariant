import 'package:dart_qvariant/src/variant.dart';
import 'package:test/test.dart';

void main() {
  group('Variant', () {
    test('Type checks', () {
      print('isNull: ${Variant(null).isNull}');
      print('isString: ${Variant("text").isString}');
      print('isInt: ${Variant(123).isInt}');
      print('isDouble: ${Variant(3.14).isDouble}');
      print('isBool: ${Variant(true).isBool}');
      print('isNumeric: ${Variant(5.5).isNumeric}');

      expect(Variant(null).isNull, isTrue);
      expect(Variant('text').isString, isTrue);
      expect(Variant(123).isInt, isTrue);
      expect(Variant(3.14).isDouble, isTrue);
      expect(Variant(true).isBool, isTrue);
      expect(Variant(5.5).isNumeric, isTrue);
    });

    test('toText()', () {
      final v1 = Variant('abc');
      final v2 = Variant(123);
      final v3 = Variant(3.14);
      final v4 = Variant(true);
      final v5 = Variant(false);
      final v6 = Variant(null);

      print('toText abc: ${v1.toText()}');
      print('toText 123: ${v2.toText()}');
      print('toText 3.14: ${v3.toText()}');
      print('toText true: ${v4.toText()}');
      print('toText false: ${v5.toText()}');
      print('toText null: ${v6.toText()}');

      expect(v1.toText(), equals('abc'));
      expect(v2.toText(), equals('123'));
      expect(v3.toText(), equals('3.14'));
      expect(v4.toText(), equals('true'));
      expect(v5.toText(), equals('false'));
      expect(v6.toText(), isNull);
    });

    test('toInt()', () {
      final v1 = Variant('42');
      final v2 = Variant(99);
      final v3 = Variant(3.9);
      final v4 = Variant(true);
      final v5 = Variant(false);
      final v6 = Variant('not_a_number');

      print('toInt "42": ${v1.toInt()}');
      print('toInt 99: ${v2.toInt()}');
      print('toInt 3.9: ${v3.toInt()}');
      print('toInt true: ${v4.toInt()}');
      print('toInt false: ${v5.toInt()}');
      print('toInt "not_a_number": ${v6.toInt()}');

      expect(v1.toInt(), equals(42));
      expect(v2.toInt(), equals(99));
      expect(v3.toInt(), equals(3));
      expect(v4.toInt(), equals(1));
      expect(v5.toInt(), equals(0));
      expect(v6.toInt(), isNull);
    });

    test('toDouble()', () {
      final v1 = Variant('3.14');
      final v2 = Variant(7);
      final v3 = Variant(2.718);
      final v4 = Variant(true);
      final v5 = Variant(false);
      final v6 = Variant('oops');

      print('toDouble "3.14": ${v1.toDouble()}');
      print('toDouble 7: ${v2.toDouble()}');
      print('toDouble 2.718: ${v3.toDouble()}');
      print('toDouble true: ${v4.toDouble()}');
      print('toDouble false: ${v5.toDouble()}');
      print('toDouble "oops": ${v6.toDouble()}');

      expect(v1.toDouble(), closeTo(3.14, 0.0001));
      expect(v2.toDouble(), equals(7.0));
      expect(v3.toDouble(), equals(2.718));
      expect(v4.toDouble(), equals(1.0));
      expect(v5.toDouble(), equals(0.0));
      expect(v6.toDouble(), isNull);
    });

    test('toNumeric()', () {
      final v1 = Variant('5.0');
      final v2 = Variant('5');
      final v3 = Variant(3);
      final v4 = Variant(1.5);
      final v5 = Variant(true);
      final v6 = Variant(false);
      final v7 = Variant('fail');

      print('toNumeric "5.0": ${v1.toNumeric()}');
      print('toNumeric "5": ${v2.toNumeric()}');
      print('toNumeric 3: ${v3.toNumeric()}');
      print('toNumeric 1.5: ${v4.toNumeric()}');
      print('toNumeric true: ${v5.toNumeric()}');
      print('toNumeric false: ${v6.toNumeric()}');
      print('toNumeric "fail": ${v7.toNumeric()}');

      expect(v1.toNumeric(), equals(5.0));
      expect(v2.toNumeric(), equals(5));
      expect(v3.toNumeric(), equals(3));
      expect(v4.toNumeric(), equals(1.5));
      expect(v5.toNumeric(), equals(1));
      expect(v6.toNumeric(), equals(0));
      expect(v7.toNumeric(), isNull);
    });

    test('toBoolean()', () {
      final v1 = Variant('true');
      final v2 = Variant('false');
      final v3 = Variant(1);
      final v4 = Variant(0);
      final v5 = Variant(2.3);
      final v6 = Variant(0.0);
      final v7 = Variant(true);
      final v8 = Variant(false);

      print('toBoolean "true": ${v1.toBoolean()}');
      print('toBoolean "false": ${v2.toBoolean()}');
      print('toBoolean 1: ${v3.toBoolean()}');
      print('toBoolean 0: ${v4.toBoolean()}');
      print('toBoolean 2.3: ${v5.toBoolean()}');
      print('toBoolean 0.0: ${v6.toBoolean()}');
      print('toBoolean true: ${v7.toBoolean()}');
      print('toBoolean false: ${v8.toBoolean()}');

      expect(v1.toBoolean(), isTrue);
      expect(v2.toBoolean(), isFalse);
      expect(v3.toBoolean(), isTrue);
      expect(v4.toBoolean(), isFalse);
      expect(v5.toBoolean(), isTrue);
      expect(v6.toBoolean(), isFalse);
      expect(v7.toBoolean(), isTrue);
      expect(v8.toBoolean(), isFalse);
    });

    test('toNumericString()', () {
      final v1 = Variant('3.1400');
      final v2 = Variant('3.0000');
      final v3 = Variant('not_number');
      final v4 = Variant(42);
      final v5 = Variant(3.141592);
      final v6 = Variant(true);
      final v7 = Variant(false);

      print('toNumericString "3.1400": ${v1.toNumericString()}');
      print('toNumericString "3.0000": ${v2.toNumericString()}');
      print('toNumericString "not_number": ${v3.toNumericString()}');
      print('toNumericString 42: ${v4.toNumericString()}');
      print('toNumericString 3.141592: ${v5.toNumericString(roundCount: 3)}');
      print('toNumericString true: ${v6.toNumericString()}');
      print('toNumericString false: ${v7.toNumericString()}');

      expect(v1.toNumericString(), equals('3.14'));
      expect(v2.toNumericString(), equals('3'));
      expect(v3.toNumericString(), equals('0'));
      expect(v4.toNumericString(), equals('42'));
      expect(v5.toNumericString(roundCount: 3), equals('3.142'));
      expect(v6.toNumericString(), equals('true'));
      expect(v7.toNumericString(), equals('false'));
    });

    test('toDateTime()', () {
      final dt = DateTime.utc(2020);
      final strDt = '2022-03-01T12:00:00';
      final badStrDt = 'bad-date';

      print('toDateTime DateTime: ${Variant(dt).toDateTime()}');
      print('toDateTime DateTime toLocal: ${Variant(dt).toDateTime(toLocal: true)}');
      print('toDateTime String: ${Variant(strDt).toDateTime()}');
      print('toDateTime bad String: ${Variant(badStrDt).toDateTime()}');
      print('toDateTime null: ${Variant(null).toDateTime()}');

      expect(Variant(dt).toDateTime(), equals(dt));
      expect(Variant(dt).toDateTime(toLocal: true)?.isUtc, isFalse);
      expect(Variant(strDt).toDateTime()?.year, equals(2022));
      expect(Variant(badStrDt).toDateTime(), isNull);
      expect(Variant(null).toDateTime(), isNull);
    });

    test('toString()', () {
      final v1 = Variant('abc');
      final v2 = Variant(42);
      final v3 = Variant(null);

      print('toString abc: ${v1.toString()}');
      print('toString 42: ${v2.toString()}');
      print('toString null: ${v3.toString()}');

      expect(v1.toString(), equals('abc'));
      expect(v2.toString(), equals('42'));
      expect(v3.toString(), equals('null'));
    });

    test('throws on unsupported type', () {
      expect(() => Variant([1, 2, 3]).toInt(), throwsUnsupportedError);
      expect(() => Variant({}).toDouble(), throwsUnsupportedError);
    });
  });
}
