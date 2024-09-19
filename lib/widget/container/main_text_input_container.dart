import 'package:check_feng_shui/features/scan_calculator/presentation/raw_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainTextInputContainer extends ConsumerWidget {
  MainTextInputContainer({super.key});
  final TextEditingController _conNum = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
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
          onChanged: (value) async {
            ref.read(rawContentProvider.notifier).setText(value);
          },
        ),
      ),
    );
  }
}
