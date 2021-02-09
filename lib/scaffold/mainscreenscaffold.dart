import 'package:check_feng_shui/widget/container/mainscreencontainer.dart';
import 'package:flutter/material.dart';

class MainScreenScaffold extends StatelessWidget {
  const MainScreenScaffold({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check'),
      ),
      body: MainScreenContainer(),
    );
  }
}
