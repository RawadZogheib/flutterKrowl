import 'package:Krowl/Data/University_data.dart';
import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:textfield_search/textfield_search.dart';

class TypeAhead extends StatefulWidget {

  List<dynamic> Items;
  var name;
  Function(String) onTap;

  TypeAhead ({ required this.Items, required this.name, required this.onTap});

  @override
  State<TypeAhead> createState() => _TypeAheadState();
}

class _TypeAheadState extends State<TypeAhead> {
  TextEditingController myController = TextEditingController();

  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }
  _printLatestValue() {
    print("text field: ${myController.text}");
    widget.onTap(myController.text);
  }
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFieldSearch(
        initialList: widget.Items,
        label: widget.name,
        controller: myController);
  }
}
