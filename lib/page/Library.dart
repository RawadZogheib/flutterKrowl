

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/CreateRoom.dart';
import 'package:flutter_app_backend/widgets/QuietTable.dart';
import 'package:flutter_app_backend/widgets/SilentTable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:desktop_window/desktop_window.dart';





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
    Size _size = MediaQuery.of(context).size;
    DesktopWindow.setMinWindowSize(Size(500, 500));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globals.white,
      body: Responsive(mobile:
      SingleChildScrollView(
        reverse: true,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateRoom(),
              Column(
                  children: [
                    SilentTable(text: "HIII",),
                    QuietTable(text: "HIII",),
                    SizedBox(width: 20,),
                  ]
              ),

            ],
          ),
        ),
      ),
        tablet:
        SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateRoom(),
              Column(
                  children: [
                    QuietTable(text: "HIII",),
                    QuietTable(text: "HIII",),
                    SizedBox(width: 20,),
                  ]
              ),

            ],
          ),
      ), desktop: SingleChildScrollView(
        reverse: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                flex: _size.width > 1100?  1:4,
                child: CreateRoom()
            ), Expanded(
              flex: _size.width > 1100? 2:6,
              child: Row(
                  children: [
                    SilentTable(text: "HIII",),
                    QuietTable(text: "HIII",),
                    SizedBox(width: 20,),
                  ]
              ),
            ),

          ],
        ),
      ),)
    );
  }
}
