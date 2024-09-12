import 'package:check_feng_shui/widget/container/main_screen_container.dart';
import 'package:flutter/material.dart';

class MainScreenScaffold extends StatelessWidget {
  const MainScreenScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check phong thuỷ dãy số'),
      ),
      body: MainScreenContainer(),
    );
  }
}
