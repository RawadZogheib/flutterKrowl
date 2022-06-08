



import 'dart:convert';

import 'package:Krowl/widgets/Buttons/myButton.dart';
import 'package:Krowl/widgets/ForgetPassword/codeDialogForgetPass.dart';
import 'package:Krowl/widgets/ForgetPassword/myTextInput.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/api/my_api.dart';

Color colEmail = globals.blue; //email
Color colEmail_1 = globals.blue_1;
Color colEmail_2 = globals.blue_2;

String errEmailForget = ''; //email error
Color colErrEmailForget = globals.transparent;

class forgetPass extends StatefulWidget {
  const forgetPass({Key? key}) : super(key: key);

  @override
  _forgetPassState createState() => _forgetPassState();
}

class _forgetPassState extends State<forgetPass> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => _back(),
    child: Scaffold(
      backgroundColor: globals.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Center(
            child: Container(
              width: 500,
              height: 570,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    left: 5,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login2', (route) => false);
                      },
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Forget Password?",style: TextStyle(fontSize: 30),),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Enter your email to continue'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: myTextInput(
                            textString: "Enter Your Email Address",
                            labelText: 'Enter Your Email Address',
                            colBlue: colEmail,
                            colBlue_1: colEmail_1,
                            colBlue_2: colEmail_2,
                            textInputAction: TextInputAction.next,
                            spaceAllowed: false,
                            obscure: false,
                            onChange: (value) {
                              globals.emailForgetPass = value;
                            }),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: InkWell(
                          child: btn(btnText: "Submit"),
                          onTap: () {
                            try {
                              _verifAcc();
                            } catch (e) {
                              errorPopup(context, globals.errorException);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


          ),
        ),
        ),
      ),
      );
  }

  _verifAcc(){
    errEmailForget = '';
    bool isEmpty = false;

    if (globals.emailForgetPass != null && globals.emailForgetPass != '') {
      setState(() {
        colEmail = Colors.blue.shade50;
        colEmail_1 = Colors.blue.shade900;
        colEmail_2 = Colors.blue.shade900.withOpacity(0.5);
      });
    } else {
      isEmpty = true;
      setState(() {
        colEmail = Colors.red.shade50;
        colEmail_1 = Colors.red.shade900;
        colEmail_2 = Colors.red.shade900.withOpacity(0.5);
        errEmailForget = globals.warning7;
        colErrEmailForget = globals.red_1;
      });
    }
    if (isEmpty == false) {
      _checkIsRegist();
    } else {
      //do nothing
    }

  }

  _checkIsRegist() async {
    errEmailForget = '';
    try {
      var data = {
        'version': globals.version,
        'email': globals.emailForgetPass,
      };

      var res =
          await CallApi().postData(data, '(Control)checkIfIsRegist.php');
      print(res);
      print(res.body);

      List<dynamic> body = json.decode(res.body);

      if (body[0] == "success") {
        showDialog(
            context: context,
            builder: (BuildContext context) => codeDialogForgetPass()).then((exit) {
          setState(() {
            //_nullTextCode();
          });
        });
      }else if(body[0] == "error7"){
        colEmail = Colors.red.shade50;
        colEmail_1 = Colors.red.shade900;
        colEmail_2 = Colors.red.shade900.withOpacity(0.5);
        setState(() {
          errEmailForget = globals.warning7;
          colErrEmailForget = globals.red_1;
        });
      }else if(body[0] == "error11"){
        colEmail = Colors.red.shade50;
        colEmail_1 = Colors.red.shade900;
        colEmail_2 = Colors.red.shade900.withOpacity(0.5);
        setState(() {
          errEmailForget = globals.error11;
          colErrEmailForget = globals.red_1;
        });
      }else if(body[0] == "error12"){
        colEmail = Colors.red.shade50;
        colEmail_1 = Colors.red.shade900;
        colEmail_2 = Colors.red.shade900.withOpacity(0.5);
        setState(() {
          errEmailForget = globals.error12;
          colErrEmailForget = globals.red_1;
        });
      }
    }catch(e){
      print(e);
      setState(() {
        errEmailForget = globals.errorException;
        colErrEmailForget = globals.red_1;
      });
    }
  }

  _back(){
    setState(() {
      globals.emailForgetPass = null;
    });

    errEmailForget = '';
    colErrEmailForget = globals.transparent;

    colEmail = globals.blue; //email
    colEmail_1 = globals.blue_1;
    colEmail_2 = globals.blue_2;


    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

}
