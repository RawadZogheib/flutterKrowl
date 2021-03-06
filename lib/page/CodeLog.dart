import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Buttons/NextButton.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

late BuildContext cont;
var client = StreamChatClient(globals.apiKey, logLevel: Level.INFO);

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
));

class CodeLog extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<CodeLog> createState() => _CodeLogState();
}

class _CodeLogState extends State<CodeLog> {
  String? username;
  String? email;

  @override
  void initState() {
    _notLoggedIn();
    // TODO: implement initState
    super.initState();
  }

  Future<void> dispose() async {
    // TODO: implement dispose
    super.dispose();
    await client.disconnectUser();
  }

  @override
  Widget build(BuildContext context) {
    cont = context;
    Size _size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            margin: EdgeInsets.all(25.0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('Assets/krowl_logo.png'),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.sp),
                  child: Text("check your email for a 6-digit code",
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontFamily: 'Rubik',
                        fontSize: 30,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 50,
                            margin: EdgeInsets.only(left: 5),
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                globals.code1 = value;
                                //print("" + globals.code1);
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 50,
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                globals.code2 = value;
                                //print("" + globals.code2);
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 50,
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                globals.code3 = value;
                                //print("" + globals.code3);
                              },
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, bottom: 65.0),
                              child: Icon(
                                Icons.minimize,
                                size: 40,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 50,
                            margin: EdgeInsets.only(left: 5),
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                globals.code4 = value;
                                //print("" + globals.code4);
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 50,
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                globals.code5 = value;
                                //print("" + globals.code5);
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 50,
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                globals.code6 = value;
                                //print("" + globals.code6);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                    ),
                  ],
                ),
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 180.sp),
                    child: NextButton(
                      text: "next",
                      color: blue1,
                      icon: Icons.arrow_forward,
                      onTap: () {
                        _sendCode();
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sendCode() async {
    //_getLogin();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    username= await localStorage.getString("username");
    email= await localStorage.getString("email");
    try {

      String? vCode;
      vCode = globals.code1! +
          globals.code2! +
          globals.code3! +
          globals.code4! +
          globals.code5! +
          globals.code6!;

      var data = {
        'version': globals.version,
        'email':  email,
        'username': username,
        'vCode': vCode
      };
      print("CodeLog DATAAAAAA"+data.toString());
      var res = await CallApi().postData(data, '(Control)getVCode.php');
      List<dynamic> body = json.decode(res.body);
      print(body[0]);
      if (body[0] == "true") {
        await client.connectUser(
          User(id: username!, extraData: {
            "name": username!,
            // image:
            // 'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
          }),
          body[1],
        );
        localStorage.remove('username');
        localStorage.remove('email');
        await _saveLogin();
        Navigator.pushNamedAndRemoveUntil(
            cont, '/intro_page2', (route) => false);


      } else if (body[0] == "errorVersion") {
        errorPopup(context, globals.errorVersion);
      } else if (body[0] == "errorToken") {
        errorPopup(context, globals.errorToken);
      } else if (body[0] == "false") {
        errorPopup(context, 'Wrong Code !');
      } else if (body[0] == "error7") {
        errorPopup(context, globals.warning7);
      } else {
        errorPopup(context, globals.errorElse);
      }
    } catch (e) {
      errorPopup(context, globals.errorException);
    }
  }

  Future<void> _saveLogin() async{
    await SessionManager().set('isLoggedIn', true);
  }

  Future<void> _notLoggedIn() async {
  }
}
