import 'dart:async';
import 'dart:developer';

import 'package:check_feng_shui/features/scan_calculator/data/data.dart';
import 'package:check_feng_shui/widget/container/scanscreencontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';

class ScanScreenScaffold extends StatefulWidget {
  @override
  State<ScanScreenScaffold> createState() => _ScanScreenScaffoldState();
}

class _ScanScreenScaffoldState extends State<ScanScreenScaffold> {
  String text = "";
  final StreamController<String> streamDataController =
      StreamController<String>();

  void setText(value) {
    streamDataController.add(value);
  }

  @override
  void dispose() {
    streamDataController.close();
    super.dispose();
  }

  String snapshotData = '';
  String content = '';
  String contentRank = '';
  MaterialColor? backgroundColor;
  String elementName = '';
  final Meaning meaning = Meaning();
  final Ranking ranking = Ranking();
  final Elements element = Elements();
  Future? futureContent;

  void calculateRank(String value) {
    String subString = snapshotData.substring(
        (snapshotData.length > 4) ? snapshotData.length - 4 : 0,
        snapshotData.length);
    debugPrint('last 4 digits: ${subString}');
    int key = (subString == "") ? 0 : int.parse(subString) % 80;
    key = (key == 0) ? 80 : key;
    setState(() {
      if (snapshotData.isNotEmpty) {
        content = meaning.details[key]?['detail'];
        contentRank = ranking.rank[meaning.details[key]?['rank']]?['name'];
        backgroundColor = ranking.rank[meaning.details[key]?['rank']]?['color'];
        elementName = calculateMaterial();
        // calculateMaterial();
        debugPrint(backgroundColor.toString());
      } else {
        backgroundColor = null;
        content = '';
        contentRank = '';
      }
    });
    debugPrint('content: ${content}');
    debugPrint('ranking: ${contentRank}');
  }

  calculateMaterial() {
    if (snapshotData.isNotEmpty) {
      int key = calculateSum(
        int.parse(
          snapshotData.replaceAll(RegExp(r"\,|\.[a-z][A-Z]"), ""),
        ),
      );
      debugPrint('element: ' + element.rank[key]?['name']);
      // setState(() {
      //   elementName = element.rank[key]['name'];
      // });
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Phong Thuy"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ScalableOCR(
                  paintboxCustom: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4.0
                    ..color = const Color.fromARGB(153, 102, 160, 241),
                  boxLeftOff: 5,
                  boxBottomOff: 2.5,
                  boxRightOff: 5,
                  boxTopOff: 2.5,
                  boxHeight: MediaQuery.of(context).size.height / 3,
                  getRawData: (value) {
                    inspect(value);
                  },
                  getScannedText: (value) {
                    setText(value);
                  }),
              StreamBuilder<String>(
                stream: streamDataController.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.data != null) {
                    snapshotData = snapshot.data!;
                    calculateRank(snapshotData);
                    return Card(
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
                    );
                  }
                  return ResultContainer(
                      textInput: snapshot.data != null ? snapshot.data! : "");
                },
              )
            ],
          ),
        ));
  }
}
