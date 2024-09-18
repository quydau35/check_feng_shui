import 'package:check_feng_shui/features/scan_calculator/data/data.dart';
import 'package:check_feng_shui/features/scan_calculator/presentation/raw_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentRepository {
  ContentData? contentData;

  RegExp exp = RegExp(r"[0-9]");

  Future<ContentData> calculateRank(String value) async {
    String content = '';
    String contentRank = '';
    Color? backgroundColor;
    String elementName = '';
    Iterable<RegExpMatch> matches = exp.allMatches(value);
    String digitsString = matches.fold<String>(
        '', (previousValue, element) => previousValue + element[0]!);
    String subString = digitsString.substring(
        (digitsString.length > 4) ? digitsString.length - 4 : 0,
        digitsString.length);
    debugPrint('last 4 digits: $subString');
    int key = (subString == "") ? 0 : int.parse(subString) % 80;
    key = (key == 0) ? 80 : key;

    if (content != null) {
      content = meaning.details[key]?['detail'];
      contentRank = ranking.rank[meaning.details[key]?['rank']]?['name'];
      backgroundColor = ranking.rank[meaning.details[key]?['rank']]?['color'];
      elementName = await calculateMaterial(digitsString ?? '');

      debugPrint('content: $content');
      debugPrint('ranking: $contentRank');
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
        content: '',
        contentRank: contentRank,
        backgroundColor: backgroundColor,
        elementName: '',
      );
    }
  }

  calculateMaterial(String content) async {
    if (content.isNotEmpty) {
      // Iterable<RegExpMatch> matches = exp.allMatches(content);
      // String outputString = matches.fold<String>(
      //     '', (previousValue, element) => previousValue + element[0]!);
      String outputString = content.toString();
      int key = await calculateSum(
        int.parse(outputString),
      );
      debugPrint('element: ${element.rank[key]?['name']}');
      return element.rank[key]?['name'];
    } else {
      return '';
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

// final contentRepositoryProvider = Provider((ref) {
//   return ContentRepository();
// });

// final contentProvider = StateProvider<ContentData>((ref) {
//   final contentRepository = ref.watch(contentRepositoryProvider);
//   return contentRepository.contentData!;
// });

final contentProvider = StreamProvider.autoDispose<ContentData>((ref) async* {
  String? rawContent = ref.watch(rawContentProvider);
  final contentRepository = ContentRepository();
  yield await contentRepository.calculateRank(rawContent ?? '');
});
