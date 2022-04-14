import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//RegExp expSpace = new RegExp(r"^[ ]+|^[ ]*[^ ]+([ ]{2,})+|(([^ ]+[ ]+[^ ]+)[ ])+"); //catch if the expression have a second space or two or more space with each other


class TextInput1 extends StatefulWidget {
  var onChanged;
  var fillColor;
  var hintText;
  var cursorColor;
  var focusColor;
  var controller;
  bool spaceAllowed;
  var maxLength;

  TextInput1(
      {
      this.spaceAllowed = true,
      this.maxLength,
      this.onChanged,
      this.controller,
      this.fillColor,
      this.hintText,
      this.cursorColor,
      this.focusColor});


  @override
  State<TextInput1> createState() => _TextInput1State();
}

class _TextInput1State extends State<TextInput1> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      onChanged: widget.onChanged,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        counterText: "",
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
        // if (widget.spaceAllowed == false)
        //   FilteringTextInputFormatter.deny(expSpace1),
        // if (widget.spaceAllowed == false)
        //   FilteringTextInputFormatter.deny(expSpace2),
        // //if (widget.spaceAllowed == false)
        //   FilteringTextInputFormatter.deny(expSpace3),
        if (widget.spaceAllowed == false)
          FilteringTextInputFormatter.deny(RegExp(r"((?![a-zA-Z0-9_-]).)*")),
        // if (widget.spaceAllowed == false)
        //   FilteringTextInputFormatter.deny(RegExp(r"\s")),
        // if (widget.spaceAllowed == false)
        //   FilteringTextInputFormatter.deny(RegExp(r"\n")),
      ],
    );
  }
}
