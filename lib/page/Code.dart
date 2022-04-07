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

class Code extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {

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
    try {

      SharedPreferences localStorage = await SharedPreferences.getInstance();

        String? vCode;
        vCode = globals.code1! +
            globals.code2! +
            globals.code3! +
            globals.code4! +
            globals.code5! +
            globals.code6!;

        var data = {
          'version': globals.version,
          'email': await localStorage.getString("email"),
          'username': await localStorage.getString("username"),
          'vCode': vCode
        };
        print(data);
        var res = await CallApi().postData(data, '(Control)getVCode.php');
        List<dynamic> body = json.decode(res.body);
        print(body[0]);
        if (body[0] == "true") {
          //var client = StreamChatClient(globals.apiKey, logLevel: Level.INFO);
          // await client.connectUser(
          //   User(id: globals.userName!, extraData: {
          //     "name": globals.userName!,
          //     // image:
          //     // 'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
          //   }),
          //   body[1],
          // );
          _saveLogin();
          Navigator.pushNamedAndRemoveUntil(
              cont, '/intro_page2', (route) => false);
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "false") {
          ErrorPopup(context, 'Wrong Code !');
        } else if (body[0] == "error7") {
          ErrorPopup(context, globals.warning7);
        } else {
          ErrorPopup(context, globals.errorElse);
        }
    } catch (e) {
      ErrorPopup(context, globals.errorException);
    }
  }

  _saveLogin() async{
    // globals.emailLogin = globals.email.toString();
    // globals.passwordLogin = globals.password.toString();

    await SessionManager().set("email",globals.email!);
    await SessionManager().set("username",globals.userName!);
    await SessionManager().set("password",globals.password!);

  }
}
