import 'dart:math';

class UUID {
  static const String _nil = '00000000-0000-0000-0000-000000000000';

  static String get getNil => _nil;

  /// get new UUID (String)
  static String get getNew => _create();

  static String _create() {
    var rnd = Random();

    String nextRnd() {
      var char = '0123456789abcdef';
      return char[rnd.nextInt(16)];
    }

    String variantOne() {
      var char = '89ab';
      return char[rnd.nextInt(4)];
    }

    var s = '';
    int i;
    // 00000000-____-____-____-____________
    for (i = 1; i <= 8; i++) {
      s += nextRnd();
    }
    s += '-';
    // 00000000-0000-____-____-____________
    for (i = 1; i <= 4; i++) {
      s += nextRnd();
    }
    s += '-4'; //version 4(Random)
    // 00000000-0000-4000-V___-____________
    for (i = 1; i <= 3; i++) {
      s += nextRnd();
    }
    s += '-';
    s += variantOne();
    // 00000000-0000-4000-V000-____________
    for (i = 1; i <= 3; i++) {
      s += nextRnd();
    }
    s += '-';
    // 00000000-0000-4000-V000-000000000000
    for (i = 1; i <= 12; i++) {
      s += nextRnd();
    }
    return s;
  }
}
