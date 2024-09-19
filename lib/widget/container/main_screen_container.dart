import 'package:check_feng_shui/features/scan_calculator/presentation/result_container.dart';
import 'package:check_feng_shui/widget/container/main_text_input_container.dart';
import 'package:flutter/material.dart';

class MainScreenContainer extends StatelessWidget {
  const MainScreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainTextInputContainer(),
        const ResultContainer(),
      ],
    );
  }
}
