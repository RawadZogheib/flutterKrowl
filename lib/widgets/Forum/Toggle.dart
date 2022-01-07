import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;


class ToggleButton1 extends StatefulWidget {
  State<ToggleButton1> createState() => _ToggleButton1State();
}

class _ToggleButton1State extends State<ToggleButton1> {
  List<bool> isSelected = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          children: <Widget>[
            Icon(Icons.ac_unit),
            Icon(Icons.call),
            Icon(Icons.cake),
          ],
          onPressed: (int index) {
            setState(() {
              isSelected[index] = !isSelected[index];

            });
          },
          isSelected: isSelected,
        ),
      ],
    );
  }
}
