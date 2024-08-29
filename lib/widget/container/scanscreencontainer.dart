import 'package:check_feng_shui/features/scan_calculator/data/data.dart';
import 'package:check_feng_shui/features/scan_calculator/domain/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultContainer extends ConsumerWidget {
  ResultContainer({
    Key? key,
    required this.textInput,
  });

  final String textInput;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ContentData content = ref.watch(contentProvider);
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: content.backgroundColor,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('Hành: '),
                Text(
                  content.elementName ?? '',
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
                  content.contentRank ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              content.content ?? '',
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
