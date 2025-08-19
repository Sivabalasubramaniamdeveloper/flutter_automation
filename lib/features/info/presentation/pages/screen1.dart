import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/base/abstract/base_screen.dart';

class Screen1 extends BaseScreen {
  const Screen1({super.key});

  @override
  String get title => "Home";

  @override
  Widget buildBody(BuildContext context) {
    return Center(child: Text("Welcome to Home Screen"));
  }

  @override
  List<Widget>? get actions => [
    IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
  ];

  @override
  Widget? get floatingActionButton =>
      FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add));
}
