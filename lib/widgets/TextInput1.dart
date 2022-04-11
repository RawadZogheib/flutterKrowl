import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

RegExp expSpace = new RegExp(r"^[ ]+|^[ ]*[^ ]+([ ]{2,})+|(([^ ]+[ ]+[^ ]+)[ ])+"); //catch if the expression have a second space or two or more space with each other

class TextInput1 extends StatefulWidget {

  TextInput1 ({ required this.spaceAllowed, this.onChanged,this.controller, this.fillColor, this.hintText, this.cursorColor, this.focusColor });

  var onChanged;
  var fillColor;
  var hintText;
  var cursorColor;
  var focusColor;
  var controller;
  bool spaceAllowed = true;

  @override
  State<TextInput1> createState() => _TextInput1State();
}

class _TextInput1State extends State<TextInput1> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(5)),
        fillColor: widget.fillColor,
        filled: true,
        focusColor: widget.focusColor,
        hintText: widget.hintText,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.blue.shade900)),
      ),
      textInputAction: TextInputAction.done,
      inputFormatters: [
        if (widget.spaceAllowed == false)
          FilteringTextInputFormatter.deny(expSpace)
      ],
    );
  }
  }

