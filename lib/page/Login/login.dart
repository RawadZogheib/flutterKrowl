import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Buttons/NextButton.dart';
import 'package:Krowl/widgets/Buttons/PreviousButton.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Login extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSaved();
  }

  List<LogicalKeyboardKey> keys = [];

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        final key = event.logicalKey;
        if (event is RawKeyDownEvent) {
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            if (_email != null) {
              if (_email!.isNotEmpty) {
                Navigator.pushNamed(context, '/login2');
              } else {
                WarningPopup(context, globals.warning1);
              }
            } else {
              WarningPopup(context, globals.warning7);
            }
          }
          setState(() => keys.add(key));
        } else {
          setState(() => keys.remove(key));
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            margin: EdgeInsets.all(25.0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  image: AssetImage('Assets/krowl_logo.png'),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text("before you get started, we only need your email",
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontFamily: 'Rubik',
                        fontSize: 30,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 500,
                  child: TextFormField(
                    autofocus: true,
                    key: Key(_email.toString()),
                    initialValue: _email.toString(),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r"\s")),
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade50),
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue.shade900)),
                      hintText: "type your email here...",
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue.shade900,
                        fontFamily: 'Rubik',
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      _email = value;
                      //print("" + globals.email);
                    },
                    onEditingComplete: () {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: PreviousButton(
                        text: "previous",
                        color: globals.blue1,
                        icon: Icons.arrow_back,
                        onTap: () {
                          Navigator.pop(context, '/intro_page');
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 70,
                          margin: EdgeInsets.only(left: 100.sp),
                          child: NextButton(
                            text: "Next",
                            color: globals.blue1,
                            icon: Icons.arrow_forward,
                            onTap: () {
                              if (_email != null) {
                                if (_email!.isNotEmpty) {
                                  Navigator.pushNamed(context, '/login2',
                                      arguments: _email);
                                } else {
                                  WarningPopup(context, globals.warning1);
                                }
                              } else {
                                WarningPopup(context, globals.warning7);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getSaved() async {
    if (await SessionManager().containsKey('email')) {
      String e = (await SessionManager().get('email')).toString();
      print(e);
      setState(() {
        _email = e;
      });
    }
  }
//End if

}
