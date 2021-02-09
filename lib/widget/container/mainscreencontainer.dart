import 'package:check_feng_shui/model/data.dart';
import 'package:flutter/material.dart';

class MainScreenContainer extends StatefulWidget {
  MainScreenContainer({Key key}) : super(key: key);

  @override
  _MainScreenContainerState createState() => _MainScreenContainerState();
}

class _MainScreenContainerState extends State<MainScreenContainer> {
  final TextEditingController _conNum = TextEditingController();
  String content;
  String contentRank;
  MaterialColor backgroundColor;
  String elementName;
  final Meaning meaning = Meaning();
  final Ranking ranking = Ranking();
  final Elements element = Elements();

  void calculateRank(String value) {
    String subString = _conNum.text.substring(
        (_conNum.text.length > 4) ? _conNum.text.length - 4 : 0,
        _conNum.text.length);
    debugPrint(subString);
    int key = int.parse(subString) % 80;
    setState(() {
      if (_conNum.text.isNotEmpty) {
        content = meaning.details[key]['detail'];
        contentRank = ranking.rank[meaning.details[key]['rank']]['name'];
        backgroundColor = ranking.rank[meaning.details[key]['rank']]['color'];
        // elementName = calculateMaterial();
        calculateMaterial();
        debugPrint(backgroundColor.toString());
      } else {
        _conNum.clear();
        backgroundColor = null;
        content = null;
        contentRank = null;
      }
    });
    debugPrint('content: ${content}');
    debugPrint('ranking: ${contentRank}');
  }

  Future<String> calculateMaterial() async {
    if (_conNum.text.isNotEmpty) {
      double key =
          await calculateSum(double.parse(_conNum.text.replaceAll(",", "")));
      debugPrint('element: ' + element.rank[key]['name']);
      setState(() {
        elementName = element.rank[key]['name'];
      });
      return element.rank[key]['name'];
    } else {
      return null;
    }
  }

  Future<double> calculateSum(double input) async {
    if (input < 10) {
      return input;
    } else {
      String tempString = input.toString();
      double tempSum = double.parse(
        tempString.split('').reduce(
          (value, element) {
            double tempValue = double.parse(value.replaceAll(",", "")) +
                double.parse(element.replaceAll(",", ""));
            value = tempValue.toString().replaceAll(",", "");
            return value;
          },
        ).replaceAll(",", ""),
      );
      return calculateSum(tempSum);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Form(
            child: TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Không được để trống';
                } else {
                  return null;
                }
              },
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Tiêu đề',
              ),
              controller: _conNum,
              onChanged: calculateRank,
            ),
          ),
          // RaisedButton(
          //   child: Text(
          //     'check',
          //   ),
          //   onPressed: calculateRank,
          // ),
          InkWell(
            child: Card(
              margin: const EdgeInsets.all(16.0),
              color: backgroundColor ?? Colors.white,
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
            ),
          )
        ],
      ),
    );
  }
}
