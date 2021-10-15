import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';



class TextInput extends StatelessWidget {

  TextInput ({required this.textString, this.onChanged });

  final String textString;
  var onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textAlign: TextAlign.center,
      cursorColor: Colors.blue.shade900,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade900),
            borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.blue.shade50,

        hintText: this.textString,
        hintStyle: TextStyle(
          fontSize: 15.0,
          color: Colors.blue.shade900,
           ),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue.shade900)),
      ),
      textInputAction: TextInputAction.next,
    );
  }
}
