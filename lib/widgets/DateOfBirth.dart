import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Krowl/globals/globals.dart' as globals;



class DateOfBirth extends StatelessWidget {
  DateTime _date = DateTime.now();
  TextEditingController _datecontroller = new TextEditingController();

  var myFormat = DateFormat('d-MM-yyyy');
  Future<Null?> _selectDate(BuildContext context) async{

    DateTime? _datePicker = await showDatePicker(
      context: context,
      firstDate: DateTime(1947),
      lastDate: DateTime(2022),
      initialDate: _date,
      initialDatePickerMode: DatePickerMode.year,
    );
    if (_datePicker != null && _datePicker != _date){
       setState(() {
        _date = _datePicker;
        print(
          _date.toString(),
        );
      });
    }
  }

  DateOfBirth ({this.onTap, this.text, this.color, this.fillColor });

  var onTap;
  var text;
  var color;
  var setState;
  var fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _datecontroller,
      cursorColor: Colors.blue.shade900,
      readOnly: true,
      onTap: (){
        setState(() {
          _selectDate(context);
        });
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: globals.blue1),
            borderRadius: BorderRadius.circular(5)),
        filled: true,
        fillColor: fillColor,
        labelText: "Date of birth",
        labelStyle: TextStyle( color: Colors.blue.shade900.withOpacity(0.5)),
        hintText: ('${myFormat.format(_date)}'),
        hintStyle: TextStyle(
          color: Colors.blue.shade900,
          fontSize: 15.0,
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade900, width: 2.0),
            borderRadius: BorderRadius.circular(5)
        ),
      ),
    );
  }
}
