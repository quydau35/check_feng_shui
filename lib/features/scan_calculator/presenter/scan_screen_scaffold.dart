import 'package:check_feng_shui/features/scan_calculator/presenter/scan_screen_container.dart';
import 'package:check_feng_shui/scaffold/main_screen_scaffold.dart';
import 'package:check_feng_shui/widget/container/scanner_container.dart';
import 'package:flutter/material.dart';

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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreenScaffold(),
                    ),
                  );
                },
                child: Text('Enter number manually'),
              )
            ],
          ),
        ));
  }
}
