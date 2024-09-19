import 'package:check_feng_shui/features/scan_calculator/data/data.dart';
import 'package:check_feng_shui/features/scan_calculator/domain/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultContainer extends ConsumerWidget {
  const ResultContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ContentData> content = ref.watch(contentProvider);
    return content.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
      data: (content) => Card(
        margin: const EdgeInsets.all(16.0),
        color: content.backgroundColor,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Hành: '),
                  Text(
                    content.elementName,
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
                    content.contentRank,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                content.content,
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
      ),
    );
  }
}
