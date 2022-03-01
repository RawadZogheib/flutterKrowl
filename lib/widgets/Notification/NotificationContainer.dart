import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:simple_tooltip/simple_tooltip.dart';



class EditTextInput extends StatefulWidget {

  EditTextInput ({ this.onChanged, });

  var onChanged;

  @override
  State<EditTextInput> createState() => _EditTextInputState();
}

class _EditTextInputState extends State<EditTextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [],
      ),
    );
  }
}
