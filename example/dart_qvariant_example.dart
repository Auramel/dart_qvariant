import 'package:dart_qvariant/dart_qvariant.dart';

void main() {
  final values = {
    'intAsString': Variant('42'),
    'doubleValue': Variant(3.14159),
    'boolValueTrue': Variant(true),
    'boolValueFalse': Variant(false),
    'nullValue': Variant(null),
    'dateString': Variant('2024-06-04T18:00:00Z'),
    'invalidInt': Variant('abc'),
  };

  for (final entry in values.entries) {
    final key = entry.key;
    final v = entry.value;

    print('Key: $key');
    print('Value: $v');
    print('|-isNull: ${v.isNull}');
    print('|-toInt(): ${v.toInt()}');
    print('|-toDouble(): ${v.toDouble()}');
    print('|-toBoolean(): ${v.toBoolean()}');
    print('|-toText(): ${v.toText()}');
    print('|-toNumericString(): ${v.toNumericString()}');
    print('|-toNumericString(roundCount: 4): ${v.toNumericString(roundCount: 4)}');
    print('|-toDateTime(): ${v.toDateTime()?.toIso8601String()}');
    print('------------------------------');
  }
}
