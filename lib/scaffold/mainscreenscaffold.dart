import 'package:check_feng_shui/widget/container/mainscreencontainer.dart';
import 'package:flutter/material.dart';

class MainScreenScaffold extends StatelessWidget {
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
