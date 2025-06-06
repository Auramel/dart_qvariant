// Dart imports:
import 'dart:math';

/// A read-only wrapper around a dynamic value.
/// 
/// Inspired by Qt's QVariant. Provides typed access to a value of unknown type
/// (e.g. from JSON) with smart casting and safe type checks.
/// 
/// Example:
/// ```dart
/// final v1 = Variant("42");
/// print(v1.toInt()); // 42
/// 
/// final v2 = Variant(3.14);
/// print(v2.toText()); // "3.14"
/// 
/// final v3 = Variant("true");
/// print(v3.toBoolean()); // true
/// 
/// final v4 = Variant("2024-01-01T12:00:00");
/// print(v4.toDateTime()?.toIso8601String());
/// ```
class Variant {
  final dynamic _value;
  dynamic get value => _value;
  
  const Variant(this._value);

  /// Returns true if the value is null.
  bool get isNull => (_value == null);

  /// Returns true if the value is a [String].
  bool get isString => _value is String;

  /// Returns true if the value is an [int].
  bool get isInt => _value is int;

  /// Returns true if the value is a [double].
  bool get isDouble => _value is double;

  /// Returns true if the value is a [bool].
  bool get isBool => _value is bool;

  /// Returns true if the value is a [num] (int or double).
  bool get isNumeric => _value is num;

  @override
  String toString() => toText() ?? 'null';

  /// Returns value as [String] or null. Falls back to .toString() for supported types.
  String? toText() => _match<String>(
    onString: () => _value,
    onInt: () => _value.toString(),
    onDouble: () => _value.toString(),
    onBool: () => _value ? 'true' : 'false',
  );

  /// Returns value as [int] if possible. Casts from string/double/bool.
  int? toInt() => _match<int>(
    onString: () => int.tryParse(_value),
    onInt: () => _value as int,
    onDouble: () => (_value as double).toInt(),
    onBool: () => (_value as bool) ? 1 : 0,
  );

  /// Returns value as [double] if possible. Casts from string/int/bool.
  double? toDouble() => _match<double>(
    onString: () => double.tryParse(_value),
    onInt: () => (_value as int).toDouble(),
    onDouble: () => _value as double,
    onBool: () => (_value as bool) ? 1.0 : 0.0,
  );

  /// Returns value as [num] if possible. Casts from string/int/double/bool.
  num? toNumeric() => _match<num>(
    onString: () => num.tryParse(_value),
    onInt: () => _value as int,
    onDouble: () => _value as double,
    onBool: () => (_value as bool) ? 1 : 0,
  );

  /// Returns value as [bool] if possible. Casts from string/int/double.
  bool? toBoolean() => _match<bool>(
    onString: () => _value == 'true',
    onInt: () => (_value as int) > 0,
    onDouble: () => (_value as double) > 0,
    onBool: () => _value as bool,
  );

  /// Returns value as formatted numeric string with optional rounding.
  /// 
  /// Example: `Variant(3.140000).toNumericString(roundCount: 2)` → `"3.14"`
  String? toNumericString({final int roundCount = 2}) {
    return _match(
      onString: () => double.tryParse(_value)?.customRound(roundCount: roundCount).toString().replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), ''),
      onInt: () => int.tryParse(_value.toString()).toString(),
      onDouble: () => (_value as double).customRound(roundCount: roundCount).toString().replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), ''),
      onBool: () => (_value) ? 'true' : 'false',
    );
}

  /// Tries to parse value into [DateTime]. Accepts [DateTime] or ISO8601 strings.
  DateTime? toDateTime({final bool toLocal = false}) {
    if (_value == null) {
      return null;
    }

    if (_value is DateTime) {
      if (toLocal) {
        return (_value).toLocal();
      } else {
        return (_value);
      }
    }

    return toLocal
      ? DateTime.tryParse(_value.toString())?.toLocal()
      : DateTime.tryParse(_value.toString());
  }

  T? _match<T>({
    required final T? Function() onString,
    required final T? Function() onInt,
    required final T? Function() onDouble,
    required final T? Function() onBool,
  }) {
    if (_value == null) {
      return null;
    }

    if (_value is String) {
      return onString();
    }

    if (_value is int) {
      return onInt();
    }

    if (_value is double) {
      return onDouble();
    }

    if (_value is bool) {
      return onBool();
    }

    throw UnsupportedError('Variant received unsupported type: ${_value.runtimeType}');
  }
}

/// Extension on [double?] to perform custom rounding with precision.
extension DoubleExtension on double? {
  /// Rounds number to fixed [roundCount] decimals, with internal 6-digit accuracy.
  double? customRound({final int roundCount = 2}) {
    if (this == null) {
      return null;
    }
    final double rounded = ((this! * pow(10, 6)).roundToDouble()) / pow(10, 6);
    return (rounded * pow(10, roundCount)).roundToDouble() / pow(10, roundCount);
  }
}
