import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;

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
          image: AssetImage('Assets/krowl_logo.png'),
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.4,
        ),
      ),
    );
  }

  _timer() async {
    try {
      new Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, '/intro_page', (route) => false);
      });
    } catch (e) {
      print(e);
    }
  }
}