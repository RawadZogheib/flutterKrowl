import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/CreateRoom.dart';
import 'package:flutter_app_backend/widgets/QuietTable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';





void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Library()));

class Library extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Library> createState() => _TestState();
}

class _TestState extends State<Library> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globals.white,
      body: Row(
        children: [
          Expanded(
            flex: 1,
              child: CreateRoom()
          ),
          Expanded(
            flex: 3,
              child: QuietTable()
          ),
        ],
      ),
    );
  }
}
