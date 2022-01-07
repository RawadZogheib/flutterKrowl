import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Dropdown.dart';
import 'package:flutter_app_backend/widgets/Forum/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/CreatePostContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/Dropdown2.dart';
import 'package:flutter_app_backend/widgets/Forum/QuestionContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/SearchBar.dart';
import 'package:flutter_app_backend/widgets/Forum/Contributors.dart';
import 'package:flutter_app_backend/widgets/Library/CreateTable.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:flutter_app_backend/widgets/TextInput.dart';
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Responsive.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Forum2()));

class Forum2 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Forum2> createState() => _Forum2State();
}

class _Forum2State extends State<Forum2> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: globals.white,
        body: Responsive(
          mobile: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.center,
              child: Column(
              ),
            ),
          ),
          tablet: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.center,
              child: Column(
              ),
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
                      child:
                              Stack(
                                children:[ DefaultTextStyle(
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
                                    child: Text( "If you are stuck on anything here's your chance to ask a\nquestion about many different subjects.\n\nKrowl has a forum section that is accessible by every\nstudents. This is a great way of getting answers from your\npeers and get help.",
                                      style: TextStyle(fontSize: 16, fontFamily: 'Rubik', color: Colors.white), ),
                                  )
                              ]),
                           ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.only(left: 20,top: 45),
                      width: 520,
                      height: 520,
                      decoration: BoxDecoration(
                        color: globals.blue2,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Subject *",
                                  style: GoogleFonts.nunito(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                              SizedBox(height: 10,),
                              Dropdown2(),
                              SizedBox(height: 20,),
                              Text("Question *",
                                  style: GoogleFonts.nunito(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              SizedBox(height: 10,),
                              Container(
                                  width: 450,
                                  height:40,
                                  child: TextInput1(fillColor: Colors.white, hintText: 'Enter your question here',)),
                              SizedBox(height: 20,),
                              Text("Context of question *",
                                  style: GoogleFonts.nunito(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              SizedBox(height: 10,),
                              Container( width: 450,child: TextInput1(fillColor: Colors.white, hintText: 'Give some context...',)),
                              SizedBox(height: 100,),
                              Container(
                                width: 170,
                                height: 50,
                                child: AskQuestionButton(color1: globals.blue1, color2: Colors.blueGrey,text: 'Create post', onPressed: (){
                                  print('hii');
                                }, textcolor: globals.blue2,),
                              )
                            ],
                          ),
                    ),

                  ],
                ),
              ),

            ]),
          ),
        ));
  }
}



