import 'dart:async';
import 'dart:developer';

import 'package:check_feng_shui/features/scan_calculator/data/data.dart';
import 'package:check_feng_shui/features/scan_calculator/domain/content_repository.dart';
import 'package:check_feng_shui/features/scan_calculator/presenter/raw_content_provider.dart';
import 'package:check_feng_shui/features/scan_calculator/presenter/scanscreencontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';

class ScanScreenScaffold extends StatelessWidget {
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
              ScannerContainer(),
              ResultContainer(),
            ],
          ),
        ));
  }
}

class ScannerContainer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScalableOCR(
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
        getScannedText: (value) async {
          await Future.delayed(Duration(milliseconds: 500));
          ref.read(rawContentProvider.notifier).state = value;
        });
  }
}
