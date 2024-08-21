import 'package:check_feng_shui/features/scan_calculator/data/data.dart';
import 'package:flutter/material.dart';

class ResultContainer extends StatelessWidget {
  ResultContainer({
    Key? key,
    required this.textInput,
  }) : super(key: key);

  final String textInput;

  final Meaning meaning = Meaning();
  final Ranking ranking = Ranking();
  final Elements element = Elements();

  void calculateRank(String value) async {
    String subString = textInput.substring(
        (textInput.length > 4) ? textInput.length - 4 : 0, textInput.length);
    // debugPrint('last 4 digits: ${subString}');
    int key = (subString == "") ? 0 : int.parse(subString) % 80;
    key = (key == 0) ? 80 : key;
    // debugPrint('content: ${content}');
    // debugPrint('ranking: ${contentRank}');
  }

  calculateMaterial() async {
    if (textInput.isNotEmpty) {
      int key = await calculateSum(
        int.parse(
          textInput.replaceAll(RegExp(r"\,|\.[a-z][A-Z]"), ""),
        ),
      );
      // debugPrint('element: ' + element.rank[key]?['name']);
      // setState(() {
      //   elementName = element.rank[key]['name'];
      // });
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

  @override
  Widget build(BuildContext context) {
    String content = '';
    String contentRank = '';
    Color? backgroundColor;
    String elementName = '';
    if (textInput.isNotEmpty && textInput != Null) {
      content = meaning.details[key]?['detail'] ?? '';
      contentRank = ranking.rank[meaning.details[key]?['rank']]?['name'] ?? '';
      backgroundColor =
          ranking.rank[meaning.details[key]?['rank']]?['color'] ?? Colors.white;
      elementName = calculateMaterial();
      // calculateMaterial();
      // debugPrint(backgroundColor.toString());
    } else {
      backgroundColor = Colors.white;
      content = '';
      contentRank = '';
    }
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: backgroundColor,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('Hành: '),
                Text(
                  elementName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Ý nghĩa: '),
                Text(
                  contentRank ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              content ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
