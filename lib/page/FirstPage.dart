import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var height;
    return Scaffold(
      backgroundColor: globals.blue2,
      body: Container(
        alignment: Alignment.center,
        child: Image(
          image: AssetImage('Assets/krowl_logo.gif'),
          fit: BoxFit.cover,
          height: 200,
          width: 200,
        ),
      ),
    );
  }

  _timer() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // await localStorage.clear();
    try {
      new Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, '/intro_page', (route) => false);
      });
    } catch (e) {
      print(e);
    }
  }
}