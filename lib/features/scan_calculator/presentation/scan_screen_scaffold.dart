import 'package:check_feng_shui/features/scan_calculator/presentation/result_container.dart';
import 'package:check_feng_shui/scaffold/main_screen_scaffold.dart';
import 'package:check_feng_shui/widget/container/scanner_container.dart';
import 'package:flutter/material.dart';

class ScanScreenScaffold extends StatelessWidget {
  const ScanScreenScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Phong Thuy"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const ScannerContainer(),
              const ResultContainer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreenScaffold(),
                    ),
                  );
                },
                child: const Text('Enter number manually'),
              )
            ],
          ),
        ));
  }
}
