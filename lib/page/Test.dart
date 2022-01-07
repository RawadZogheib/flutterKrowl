import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';

import 'Responsive.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Test()));

class Test extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      ),
    );
  }

}



