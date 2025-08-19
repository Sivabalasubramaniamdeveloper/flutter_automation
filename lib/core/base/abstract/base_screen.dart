import 'package:flutter/material.dart';

// Abstract base screen with scaffold (Stateful version)
abstract class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  String get title;

  // Must be implemented
  Widget buildBody(BuildContext context);

  // Optional overrides
  List<Widget>? get actions => null;
  Widget? get floatingActionButton => null;
  Widget? get drawer => null;
  Color? get backgroundColor => Colors.white;
  Widget? get leading => null;
  bool get showAppBar => true;
  bool get centerTitle => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
        title: Text(title),
        centerTitle: centerTitle,
        actions: actions,
        leading: leading,
      )
          : null,
      body: buildBody(context),
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      backgroundColor: backgroundColor,
    );
  }
}
