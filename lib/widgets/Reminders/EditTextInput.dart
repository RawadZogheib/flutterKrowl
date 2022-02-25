import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';



class EditTextInput extends StatefulWidget {

  EditTextInput ({ this.onChanged,this.controller, this.fillColor, this.hintText, this.cursorColor, this.focusColor, this.suffixIcon, required this.BorderColor, required this.FocusedBorderColor });

  var onChanged;
  var fillColor;
  var hintText;
  var cursorColor;
  var focusColor;
  var controller;
  var suffixIcon;
  var BorderColor;
  var FocusedBorderColor;

  @override
  State<EditTextInput> createState() => _EditTextInputState();
}

class _EditTextInputState extends State<EditTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.BorderColor),
            borderRadius: BorderRadius.circular(5)),
        fillColor: widget.fillColor,
        filled: true,
        focusColor: widget.focusColor,
        hintText: widget.hintText,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: widget.FocusedBorderColor)),
      ),
      textInputAction: TextInputAction.done,
    );
  }
}
