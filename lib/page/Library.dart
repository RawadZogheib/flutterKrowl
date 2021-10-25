

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:flutter_app_backend/page/Responsive.dart';
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
    Size _size = MediaQuery.of(context).size;
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
                    QuietTable(),
                    QuietTable(),
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
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CreateRoom(),
                Column(
                    children: [
                      QuietTable(),
                      QuietTable(),
                      SizedBox(width: 20,),
                    ]
                ),

              ],
            ),
        ),
      ), desktop: SingleChildScrollView(
        reverse: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: _size.width > 1058?  1:2,
                child: CreateRoom()
            ), Expanded(
              flex: _size.width > 1058? 2:4,
              child: Row(
                  children: [
                    QuietTable(),
                    QuietTable(),
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
