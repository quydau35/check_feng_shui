import 'package:check_feng_shui/features/scan_calculator/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentRepository {
  String? content;

  ContentData CalculateRank(String value) {
    String content = '';
    String contentRank = '';
    Color? backgroundColor;
    String elementName = '';
    String subString = value.substring(
        (value.length > 4) ? value.length - 4 : 0, value.length);
    debugPrint('last 4 digits: ${subString}');
    int key = (subString == "") ? 0 : int.parse(subString) % 80;
    key = (key == 0) ? 80 : key;

    if (content.isNotEmpty) {
      content = meaning.details[key]?['detail'];
      contentRank = ranking.rank[meaning.details[key]?['rank']]?['name'];
      backgroundColor = ranking.rank[meaning.details[key]?['rank']]?['color'];
      elementName = calculateMaterial(content);
      // calculateMaterial();

      debugPrint('content: ${content}');
      debugPrint('ranking: ${contentRank}');
      debugPrint(backgroundColor.toString());
      return ContentData(
        content: content,
        contentRank: contentRank,
        backgroundColor: backgroundColor,
        elementName: elementName,
      );
    } else {
      backgroundColor = null;
      content = '';
      contentRank = '';
      return ContentData(
        content: content,
        contentRank: contentRank,
        backgroundColor: backgroundColor,
        elementName: '',
      );
    }
  }

  calculateMaterial(content) {
    if (content.isNotEmpty) {
      RegExp exp = RegExp(r"[0-9]");
      Iterable<RegExpMatch> matches = exp.allMatches(content);
      String outputString = matches.fold<String>(
          '', (previousValue, element) => previousValue + element[0]!);
      int key = calculateSum(
        int.parse(outputString),
      );
      debugPrint('element: ' + element.rank[key]?['name']);
      return element.rank[key]?['name'];
    } else {
      return null;
    }
  }

  calculateSum(int input) async {
    if (input < 10) {
      return input;
    } else {
      String tempString = input.toString();
      int tempSum = int.parse(
        tempString.split('').reduce(
          (value, element) {
            BigInt tempValue = BigInt.parse(value) + BigInt.parse(element);
            value = tempValue.toString();
            return value;
          },
        ),
      );
      return await calculateSum(tempSum);
    }
  }
}

final Meaning meaning = Meaning();
final Ranking ranking = Ranking();
final Elements element = Elements();
