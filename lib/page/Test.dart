import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/NextButton.dart';
import 'package:flutter_app_backend/widgets/TextInput.dart';
import 'package:sizer/sizer.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Test()));

class Test extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async{
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1947),
      lastDate: DateTime(2021),
    );
    if (_datePicker != null && _datePicker != _date){
      setState(() {
        _date = _datePicker;
        print(
          _date.toString(),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red[900],
      body: Container(
        margin: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextInput (textString: "hello"),
            TextFormField(
              cursorColor: Colors.blue.shade900,
              readOnly: true,
              onTap: (){
                setState(() {
                  _selectDate(context);
                });
              },
              decoration: InputDecoration(
                  hintText: ("Select a date"),
                  hintStyle: TextStyle(
                    color: Colors.blue.shade900,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade900, width: 2.0),
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),

          ],
        ),
      ),
    );
  }
}
