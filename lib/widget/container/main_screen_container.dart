import 'package:check_feng_shui/features/scan_calculator/data/data.dart';
import 'package:flutter/material.dart';

class MainScreenContainer extends StatefulWidget {
  const MainScreenContainer({super.key});

  @override
  _MainScreenContainerState createState() => _MainScreenContainerState();
}

class _MainScreenContainerState extends State<MainScreenContainer> {
  final TextEditingController _conNum = TextEditingController();
  String content = '';
  String contentRank = '';
  MaterialColor? backgroundColor;
  String elementName = '';
  final Meaning meaning = Meaning();
  final Ranking ranking = Ranking();
  final Elements element = Elements();
  Future? futureContent;

  void calculateRank(String value) {
    String subString = _conNum.text.substring(
        (_conNum.text.length > 4) ? _conNum.text.length - 4 : 0,
        _conNum.text.length);
    debugPrint('last 4 digits: $subString');
    int key = (subString == "") ? 0 : int.parse(subString) % 80;
    key = (key == 0) ? 80 : key;
    setState(() {
      if (_conNum.text.isNotEmpty) {
        content = meaning.details[key]?['detail'];
        contentRank = ranking.rank[meaning.details[key]?['rank']]?['name'];
        backgroundColor = ranking.rank[meaning.details[key]?['rank']]?['color'];
        elementName = calculateMaterial();
        // calculateMaterial();
        debugPrint(backgroundColor.toString());
      } else {
        _conNum.clear();
        backgroundColor = null;
        content = '';
        contentRank = '';
      }
    });
    debugPrint('content: $content');
    debugPrint('ranking: $contentRank');
  }

  calculateMaterial() {
    if (_conNum.text.isNotEmpty) {
      int key = calculateSum(
        int.parse(
          _conNum.text.replaceAll(RegExp(r"\,|\."), ""),
        ),
      );
      debugPrint('element: ${element.rank[key]?['name']}');
      return element.rank[key]?['name'];
    } else {
      return null;
    }
  }

  calculateSum(int input) {
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
      return calculateSum(tempSum);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Không được để trống';
                } else {
                  return null;
                }
              },
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Nhập số',
              ),
              controller: _conNum,
              onChanged: calculateRank,
            ),
          ),
        ),
        InkWell(
          child: FutureBuilder(
            future: futureContent,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Card(
                  margin: const EdgeInsets.all(16.0),
                  color: backgroundColor ?? Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Text('Hành: '),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Ý nghĩa: '),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (true) {
                return Card(
                  margin: const EdgeInsets.all(16.0),
                  color: backgroundColor ?? Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Hành: '),
                            Text(
                              elementName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Ý nghĩa: '),
                            Text(
                              contentRank,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          content,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
