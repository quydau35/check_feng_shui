import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RawContentNotifier extends Notifier<String?> {
  @override
  String build() {
    return '';
  }

  void setText(dynamic value) async {
    Future.delayed(const Duration(milliseconds: 100), () {
      state = value.toString();
    });
  }
}

final rawContentProvider = NotifierProvider<RawContentNotifier, String?>(() {
  return RawContentNotifier();
});

// Stream<String> setText(dynamic value) async* {
//   yield value.toString();
// }
