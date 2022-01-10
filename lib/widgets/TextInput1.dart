import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';



class TextInput1 extends StatelessWidget {

  TextInput1 ({ this.onChanged, this.fillColor, this.hintText, this.cursorColor, this.focusColor });

  var onChanged;
  var fillColor;
  var hintText;
  var cursorColor;
  var focusColor;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(5)),
        fillColor: fillColor,
        filled: true,
        focusColor: focusColor,
        hintText: hintText,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.blue.shade900)),
      ),
      textInputAction: TextInputAction.done,
    );
  }
}
