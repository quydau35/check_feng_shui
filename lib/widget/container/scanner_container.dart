import 'dart:developer';

import 'package:check_feng_shui/features/scan_calculator/presenter/raw_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';

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
          // await Future.delayed(const Duration(milliseconds: 100), () {
          //   ref.read(rawContentProvider.notifier).setText(value);
          // });
          ref.read(rawContentProvider.notifier).setText(value);
        });
  }
}
