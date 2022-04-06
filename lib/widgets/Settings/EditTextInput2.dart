import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:flutter/services.dart';



class EditTextInput2 extends StatefulWidget {

  EditTextInput2 ({required this.initialValue,
    required this.hintText,
    this.fillColor,
    this.labelText,
    this.keybType,
    this.maxLength,
    this.maxLines,
    this.textInputAction,
    this.prefixText,
    required this.suffixIcon,
    required this.spaceAllowed,
    required this.enterAllowed,
    required this.obscure,
    this.onChange});

  var hintText;
  var fillColor;
  var onChange;
  var keybType;
  bool spaceAllowed;
  bool enterAllowed;
  bool obscure;
  var maxLength;
  var maxLines;
  var textInputAction;
  var labelText;
  var prefixText;
  var suffixIcon;
  var initialValue;

  @override
  State<EditTextInput2> createState() => _EditTextInput2State();
}

class _EditTextInput2State extends State<EditTextInput2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(widget.initialValue),
      initialValue: widget.initialValue!,
      autofocus: true,
      onChanged: widget.onChange,
      textAlign: TextAlign.left,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: globals.blue1),
            borderRadius: BorderRadius.circular(5.0)),
        filled: true,
        fillColor: widget.fillColor,
        alignLabelWithHint: true,
        labelStyle: TextStyle(fontSize: 14.0, color: globals.blue1),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: globals.blue1),
            borderRadius: BorderRadius.circular(5)),
        prefixText: widget.prefixText,
      ),
      textInputAction: widget.textInputAction,
      keyboardType: widget.keybType,
      obscureText: widget.obscure,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      inputFormatters: [
        if (widget.spaceAllowed == false)
          FilteringTextInputFormatter.deny(RegExp(r"\s")),
        if (widget.enterAllowed == false)
          FilteringTextInputFormatter.deny(RegExp(r"\n")),
      ],
    );
  }
}
