import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final rawContentProvider = StateProvider<String?>((ref) {
  return ''; // initial value
});

Stream<String> setText(dynamic value) async* {
  yield value.toString();
}
