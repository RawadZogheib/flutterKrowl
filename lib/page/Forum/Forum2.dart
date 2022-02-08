import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum2/Dropdown2.dart';
import 'package:flutter_app_backend/widgets/PopUp/errorPopUp.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Responsive.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Forum2()));

class Forum2 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Forum2> createState() => _Forum2State();
}

class _Forum2State extends State<Forum2> with SingleTickerProviderStateMixin {
  List<LogicalKeyboardKey> keys = [];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        final key = event.logicalKey;
        if (event is RawKeyDownEvent) {
          if (keys.contains(key)) return;
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            _createPost();
            Navigator.pushNamedAndRemoveUntil(
                context, '/Forum1', (route) => false);
          }
          setState(() => keys.add(key));
        } else {
          setState(() => keys.remove(key));
        }
      },
      child: Scaffold(
          backgroundColor: globals.white,
          body: Responsive(
            mobile: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.center,
                child: Column(),
              ),
            ),
            tablet: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.center,
                child: Column(),
              ),
            ),
            desktop: SingleChildScrollView(
              reverse: true,
              child: Column(children: [
                CustomTabBar(),
                Container(
                  height: 800,
                  color: globals.blue1.withOpacity(0.98),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 450,
                        height: 550,
                        child: Stack(children: [
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            child: AnimatedTextKit(
                              totalRepeatCount: 5,
                              animatedTexts: [
                                WavyAnimatedText('Ask a question ?'),
                              ],
                              isRepeatingAnimation: true,
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ),
                          Positioned(
                            top: 45,
                            child: Text(
                              "If you are stuck on anything here's your chance to ask a\nquestion about many different subjects.\n\nKrowl has a forum section that is accessible by every\nstudents. This is a great way of getting answers from your\npeers and get help.",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Rubik',
                                  color: Colors.white),
                            ),
                          )
                        ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.only(left: 20, top: 45),
                        width: 520,
                        height: 520,
                        decoration: BoxDecoration(
                          color: globals.blue2,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Subject *",
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                            SizedBox(
                              height: 10,
                            ),
                            Dropdown2(),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Question *",
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: 450,
                                height: 40,
                                child: TextInput1(
                                  fillColor: Colors.white,
                                  hintText: 'Enter your question here',
                                  onChanged: (val) {
                                    globals.question = val;
                                    print(globals.question.toString());
                                  },
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Context of question *",
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: 450,
                                child: TextInput1(
                                    fillColor: Colors.white,
                                    hintText: 'Give some context...',
                                    onChanged: (val) {
                                      globals.context_question = val;
                                      print(
                                          globals.context_question.toString());
                                    })),
                            SizedBox(
                              height: 100,
                            ),
                            Container(
                              width: 170,
                              height: 50,
                              child: AskQuestionButton(
                                color1: globals.blue1,
                                color2: Colors.blueGrey,
                                text: 'Create post',
                                onPressed: () {
                                  _createPost();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/Forum1', (route) => false);
                                },
                                textcolor: globals.blue2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          )),
    );
  }

  Future<void> _createPost() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var account_Id = localStorage.getString("account_Id");

    var data = {
      'version': globals.version,
      'account_Id': account_Id,
      'post_subject': globals.dropdown2,
      'post_question': globals.question.toString(),
      'post_context': globals.context_question.toString(),
    };

    var res = await CallApi().postData(data, '(Control)createPost.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

    if (body[0] == "success") {
      //toast success
      //show on forum1
    } else if (body[0] == "errorVersion") {
      ErrorPopUp(context, globals.errorVersion);
    } else if (body[0] == "errorToken") {
      ErrorPopUp(context, globals.errorToken);
    } else if (body[0] == "error7") {
      WarningPopUp(context, globals.warning7);
    }
  }
}
