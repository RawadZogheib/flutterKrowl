import 'dart:async';
import 'dart:convert';

import 'package:Krowl/api/my_api.dart';
import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;

///it's the FirstPage but edited so we can get "private" parameter from the url

class AddTable extends StatefulWidget {
  @override
  State<AddTable> createState() => _AddTableState();
}

class _AddTableState extends State<AddTable> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer();
  }

  @override
  Widget build(BuildContext context) {
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
      var arg=Uri.base.queryParameters["private"];
      if(arg != null){
        if(arg.toString().isNotEmpty){
          var data = {
            'version': globals.version,
            'private':arg
          };
          var res = await CallApi().postData(data, '(Control)checkLinkTable.php');
          print(res.body);
          List<dynamic> body = json.decode(res.body);
          if(body[0] == 'success'){
            new Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushNamedAndRemoveUntil(context, '/intro_page',(route) => false,arguments:arg);
            });
          }else {
            print("Wrong Link, Please retry again");
          }
        }}
    } catch (e) {
      print(e);
    }
  }}
