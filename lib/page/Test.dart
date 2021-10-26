import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/CreateRoom.dart';
import 'package:flutter_app_backend/widgets/QuietTable.dart';
import 'package:flutter_app_backend/widgets/SilentTable.dart';





void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Test()));

class Test extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globals.white,
      body: Column(
        children: [
          QuietTable(text: "HIII",),
      SilentTable(text: "Hellooooo",),
        ],
      ),
    );
  }
}
