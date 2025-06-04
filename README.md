dart\_qvariant
==============

A Qt-style, immutable variant type wrapper for Dart, providing smart casting and safe typed access to dynamic values.

Inspired by Qt's `QVariant`, this package lets you easily work with values of unknown or mixed types (e.g. from JSON or loosely typed data sources) with convenient conversions and null safety.

* * *

Features
--------

*   Immutable wrapper around any dynamic value
*   Typed getters with automatic safe conversions:
    *   `toInt()`, `toDouble()`, `toBoolean()`, `toText()`, `toNumeric()`, `toDateTime()`
*   Null safety and graceful fallback (returns `null` when conversion fails)
*   Customizable numeric string formatting with rounding
*   Simple, concise API inspired by Qt's `QVariant`

* * *

Installation
------------

Add to your `pubspec.yaml`:

    dart pub add dart_qvariant

or

    flutter pub add dart_qvariant

Then run:

    dart pub get

* * *

Usage
-----

Import the package:

    import 'package:dart_qvariant/dart_qvariant.dart';
    

Create a `Variant` wrapping any value:

    final v1 = Variant("42");
    final v2 = Variant(3.1415);
    final v3 = Variant(true);
    final v4 = Variant(null);
    final v5 = Variant("2024-06-04T18:00:00");
    

### Type checks

    print(v1.isString);  // true
    print(v2.isDouble);  // true
    print(v3.isBool);    // true
    print(v4.isNull);    // true
    print(v5.isString);  // true
    

### Conversions

    print(v1.toInt());      // 42 (int)
    print(v1.toDouble());   // 42.0 (double)
    print(v2.toInt());      // 3 (int)
    print(v3.toBoolean());  // true (bool)
    print(v4.toText());     // null (String?)
    print(v5.toDateTime()?.toIso8601String()); // 2024-06-04T18:00:00.000
    

If conversion fails, methods return `null`:

    final v = Variant("not a number");
    print(v.toInt());       // null
    print(v.toDouble());    // null
    print(v.toBoolean());   // false (since string != 'true')
    

### Numeric string formatting

You can get a nicely formatted numeric string with rounding:

    final v = Variant("3.1415926535");
    print(v.toNumericString());           // "3.14" (default 2 decimals)
    print(v.toNumericString(roundCount: 4)); // "3.1416"
    

For booleans, it returns `"true"` or `"false"` strings:

    print(Variant(true).toNumericString());  // "true"
    print(Variant(false).toNumericString()); // "false"
    

### DateTime parsing

You can parse dates from ISO8601 strings or `DateTime` objects:

    final dt1 = Variant("2024-06-04T18:00:00Z").toDateTime();
    final dt2 = Variant(DateTime.now()).toDateTime(toLocal: true);
    
    print(dt1);  // Parsed UTC date
    print(dt2);  // Local date time
    

Returns `null` if parsing fails:

    print(Variant("invalid-date").toDateTime());  // null
    

### Useful in JSON or loosely typed data handling

    final Map<String, dynamic> json = {
      'id': '123',
      'price': '99.95',
      'active': 'true',
      'created': '2024-01-01T12:00:00Z',
    };
    
    final id = Variant(json['id']).toInt();
    final price = Variant(json['price']).toDouble();
    final active = Variant(json['active']).toBoolean();
    final created = Variant(json['created']).toDateTime();
    
    print('ID: \$id');           // 123
    print('Price: \$price');     // 99.95
    print('Active: \$active');   // true
    print('Created: \$created'); // 2024-01-01 12:00:00.000Z