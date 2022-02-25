import 'package:flutter/foundation.dart';

extension EnumX on Object {
  String asString() => toString().split('.').last;
}

extension ExtendedInteger on int {
  static int get max {
    return kIsWeb ? 9007199254740991.round() : 1.7976931348623157e+308.round();
  }
}
