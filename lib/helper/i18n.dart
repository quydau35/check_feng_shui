import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class I18n {
  I18n(Locale locale) {
    _locale = locale;
  }

  static Locale _locale;

  static String _currentCode;

  static Map<String, dynamic> _value;

  static I18n of(BuildContext context) {
    return Localizations.of<I18n>(context, I18n);
  }

  static Future<I18n> load(Locale locale) async {
    final I18n i18n = I18n(locale);

    updateCode('vi');

    await loadOfflineAsset();

    return i18n;
  }

  static Future<void> updateCode(String value) {
    _currentCode = value;
    return null;
  }

  static Future<void> loadOfflineAsset() async {
    const files = ['assets/i18n/i18n.json'];

    final jsonStrings = await Future.wait(files.map((file) {
      return rootBundle.loadString(file);
    }));

    final i18n = <String, dynamic>{};

    for (final string in jsonStrings) {
      final Map<String, dynamic> map = jsonDecode(string);
      for (final key in map.keys) {
        i18n[key] = map[key];
      }
    }

    _value = i18n;
  }

  void update(Map<String, dynamic> value) {
    for (final key in value.keys) {
      _value[key] = value[key];
    }
  }

  String get code {
    if (_currentCode != null) {
      return _currentCode;
    }

    return _locale.languageCode;
  }

  String text(String key) {
    if (!_value.containsKey(key)) {
      return key;
    }

    final dynamic word = _value[key];

    if (!word.containsKey(code) && word.containsKey('en')) {
      return word['en'];
    }

    if (!word.containsKey(code)) {
      return key;
    }

    return word[code];
  }
}
