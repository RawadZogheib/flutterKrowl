import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;

class CustomTabBar extends StatelessWidget {

 CustomTabBar({ required this.controller, required this.tabs });
 final TabController controller;
 final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: 550,
      child: TabBar(controller: controller, tabs: tabs, indicatorColor: Colors.transparent, labelColor: globals.blue1, unselectedLabelColor: Colors.black),
    );
  }
}
