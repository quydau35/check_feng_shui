import 'dart:async';
import 'dart:developer';

import 'package:check_feng_shui/features/scan_calculator/data/data.dart';
import 'package:check_feng_shui/features/scan_calculator/domain/content_repository.dart';
import 'package:check_feng_shui/widget/container/scanscreencontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';

class ScanScreenScaffold extends ConsumerStatefulWidget {
  @override
  ConsumerState<ScanScreenScaffold> createState() => _ScanScreenScaffoldState();
}

class _ScanScreenScaffoldState extends ConsumerState<ScanScreenScaffold> {
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

  @override
  Widget build(BuildContext context) {
    ContentData content = ref.watch(contentProvider);
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
                    ref
                        .read(contentRepositoryProvider)
                        .calculateRank(snapshotData);
                    ResultContainer(textInput: snapshot.data! ?? "");
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
