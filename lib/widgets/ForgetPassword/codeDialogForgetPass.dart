
import 'package:Krowl/widgets/ForgetPassword/sixCodeForgetPass.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class codeDialogForgetPass extends StatefulWidget {
  const codeDialogForgetPass({Key? key}) : super(key: key);

  @override
  _codeDialogForgetPassState createState() => _codeDialogForgetPassState();
}

class _codeDialogForgetPassState extends State<codeDialogForgetPass> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
      content: Container(
        height: 300, //300
        width: 400, //400
        child: ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              sixCodeForgetPass(),
            ]
        ),
      ),
    );
  }
}
