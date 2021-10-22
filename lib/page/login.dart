import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:flutter_app_backend/widgets/PreviousButton.dart';
import 'package:flutter_app_backend/widgets/NextButton.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Login extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSaved();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  key: Key(globals.emailLogin.toString()),
                  initialValue: globals.emailLogin.toString(),
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
                    globals.emailLogin = value;
                    //print("" + globals.email);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: PreviousButton(text: "previous", color: blue1, icon: Icons.arrow_back, onTap: () {
                      Navigator.pop(context, '/intro_page');
                    },),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 70,
                        margin: EdgeInsets.only(left: 100.sp),
                        child: NextButton(text: "Next", color: blue1 ,icon: Icons.arrow_forward,   onTap: () {
                          if (globals.emailLogin != null ) {
                            if (globals.emailLogin!.isNotEmpty) {
                                 Navigator.pushNamed(context, '/login2' );
                            }
                           else{ showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(globals.error1),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                              );
                          }
                          }else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    'Email can not be empty.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }, ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  _getSaved() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var e = localStorage.getString("email");
    var p = localStorage.getString("password");

        if (e != null)
          if (p != null) {

              setState(() {

                globals.emailLogin = e;
                globals.passwordLogin = p;

                print("loginnnn"+ globals.emailLogin!);
                print("loginnnn"+ globals.passwordLogin!);

              });

            }

  }

}
