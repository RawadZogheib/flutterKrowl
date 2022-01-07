import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';



class TextInput1 extends StatelessWidget {

  TextInput1 ({ this.onChanged, this.fillColor, this.hintText });

  var onChanged;
  var fillColor;
  var hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(5)),
        fillColor: fillColor,
        filled: true,
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
