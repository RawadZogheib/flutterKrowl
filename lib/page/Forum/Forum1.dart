import 'dart:async';
import 'dart:convert';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/QuestionContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/SearchBar.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum2/Contributors.dart';
import 'package:flutter_app_backend/widgets/MyDrawer.dart';
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Forum1()));

class Forum1 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Forum1> createState() => _Forum1State();
}

class _Forum1State extends State<Forum1> with SingleTickerProviderStateMixin {
  @override
  var children = <Widget>[]; // Posts
  Timer? timer;
  bool load = true;

  Timer? timer2;
  AnimationController? animationController;
  final int _animationDuration = 4;
  int _k = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    timer2?.cancel();
    animationController?.stop();
    super.dispose();
  }

  @override
  void initState() {
    globals.currentPage = 'Forum';
    _loadNewPage();
    _distAnimation();
    super.initState();
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    Animation distAnimation = Tween(begin: 4.0, end: 20.0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.easeIn));
    if (_k % 2 == 0) {
      animationController!.forward();
    } else {
      animationController!.reverse();
    }
    return WillPopScope(
      onWillPop: () async => _back(),
      child: AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget) => Scaffold(
              drawer: MyDrawer(),
            resizeToAvoidBottomInset: true,
              appBar: MediaQuery.of(context).size.width < 700
                  ? AppBar(
                backgroundColor: globals.blue1,
                title: Center(
                  child: Text('Krowl'),
                ),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      _back();
                    }),
                actions: [
                  Builder(
                    builder: (context) => IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      icon: Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ],
              )
                  : null,
              backgroundColor: globals.white,
                body: Responsive(
                  mobile: SingleChildScrollView(
                    reverse: false,
                    child: Column(
                      children: [
                        SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BouncingWidget(
                              duration: Duration(milliseconds: 100),
                              scaleFactor: 1.5,
                              onPressed: () {
                                print("onPressed");
                              },
                              child: Text(
                                "Forum",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            AskQuestionButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Forum2');
                              },
                              text: 'Ask a question',
                              color1: globals.blue2,
                              color2: Colors.blueGrey,
                              textcolor: globals.blue1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SearchBar(hintText: "Search a subject..."),
                        SizedBox(
                          height: 20,
                        ),
                        load == true
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.57,
                                child: Center(
                                  child: Image(
                                    image: AssetImage('Assets/krowl_logo.gif'),
                                    fit: BoxFit.cover,
                                    height: 150,
                                    width: 150,
                                  ),
                                ))
                            : Wrap(
                                direction: Axis.vertical,
                                children: children, // My Children
                              ),
                      ],
                    ),
                  ),
                  tablet: Stack(
                    children: [
                      SingleChildScrollView(
                        reverse: false,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 130,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        BouncingWidget(
                                          duration: Duration(milliseconds: 100),
                                          scaleFactor: 1.5,
                                          onPressed: () {
                                            print("onPressed");
                                          },
                                          child: Text(
                                            "Forum",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.2,
                                        ),
                                        AskQuestionButton(
                                          onPressed: () {
                                            // Navigator.pushNamed(
                                            //     context, '/Forum2');
                                          },
                                          text: 'Ask a question',
                                          color1: globals.blue2,
                                          color2: Colors.blueGrey,
                                          textcolor: globals.blue1,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SearchBar(hintText: "Search a subject..."),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    load == true
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.57,
                                            child: Center(
                                              child: Image(
                                                image: AssetImage(
                                                    'Assets/krowl_logo.gif'),
                                                fit: BoxFit.cover,
                                                height: 150,
                                                width: 150,
                                              ),
                                            ))
                                        : Wrap(
                                            direction: Axis.vertical,
                                            children: children, // My Children
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CustomTabBar(color: globals.blue1,),
                    ],
                  ),
                  desktop: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SingleChildScrollView(
                        reverse: false,
                        child: Column(children: [
                          SizedBox(
                            height: 130,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BouncingWidget(
                                        duration: Duration(milliseconds: 100),
                                        scaleFactor: 1.5,
                                        onPressed: () {
                                          print("onPressed");
                                        },
                                        child: Text(
                                          "Forum",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.35,
                                      ),
                                      AskQuestionButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/Forum2');
                                        },
                                        text: 'Ask a question',
                                        color1: globals.blue2,
                                        color2: Colors.blueGrey,
                                        textcolor: globals.blue1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SearchBar(
                                    hintText: "Search a subject...",
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  load == true
                                      ? SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.57,
                                          child: Center(
                                            child: Image(
                                              image: AssetImage(
                                                  'Assets/krowl_logo.gif'),
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: 150,
                                            ),
                                          ))
                                      : Wrap(
                                          direction: Axis.vertical,
                                          children: children, // My Children
                                        ),
                                ],
                              ),
                              SizedBox(
                                width: 385,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: distAnimation.value,
                                        ),
                                        Contributors(
                                          height: double.parse(
                                              (220 + distAnimation.value).toString()),
                                          width: double.parse(
                                              (350 + distAnimation.value).toString()),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(
                                    //   width: 20,
                                    // ),
                                    // Contributors(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                            ],
                          ),
                        ]),
                      ),
                      CustomTabBar(color: globals.blue1,),
                    ],
                  ),
                )),
          ),
    );
  }

  _loadPosts() async {
    if (globals.loadForm1 == false) {
      globals.loadForm1 = true;
      while (globals.loadLikeDislikeForm1 == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload forum");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }

      try {
        print('load forum1');

        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var account_Id = localStorage.getString("account_Id");
        var user_uni = localStorage.getString("user_uni");

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'user_uni': user_uni,
        };

        var res = await CallApi().postData(data, '(Control)loadPosts.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        children.clear();
        if (mounted) {
          setState(() {
            load = false;
          });
        }
        if (body[0] == "success") {
          for (var i = 0; i < body[1].length; i++) {
            Color _color;
            Color _color2;
            if (int.parse(body[1][i][7]) == 0) {
              _color = Colors.grey.shade600;
              _color2 = Colors.grey.shade600;
            } else if (int.parse(body[1][i][7]) == 1) {
              _color = globals.blue1;
              _color2 = Colors.grey.shade600;
            } else if (int.parse(body[1][i][7]) == -1) {
              _color = Colors.grey.shade600;
              _color2 = globals.blue1;
            } else {
              _color = Colors.transparent;
              _color2 = Colors.transparent;
            }
            children.addAll(
              [
                Question(
                  id: body[1][i][0],
                  // post_id
                  username: body[1][i][1],
                  // username
                  tag: body[1][i][2],
                  // tag
                  text: body[1][i][3],
                  // post_data
                  val: int.parse(body[1][i][4]),
                  // post_val
                  date: body[1][i][5],
                  // post_date
                  question_context: body[1][i][6],
                  // context of the question
                  color: _color,
                  // like color
                  color2: _color2,
                  // dislike color
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          }
          setState(() {
            children;
          });
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "error7") {
          WarningPopup(context, globals.warning7);
        } else {
          if (mounted) {
            setState(() {
              load = true;
            });
            ErrorPopup(context, globals.errorElse);
          }
          globals.loadForm1 = false;
        }

        print('load forum1 end!!!');
        print(
            '=========<<======================================================<<==================================================<<=========');
      } catch (e) {
        print(e);
        if (mounted) {
          setState(() {
            load = true;
          });
          ErrorPopup(context, globals.errorException);
        }
        globals.loadForm1 = false;
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
      globals.loadForm1 = false;
    }
  }

  _loadNewPage() {
    print(
        '=========>>======================================================>>==================================================>>=========');
    timer?.cancel();
    _loadPosts(); //0
    _loadPage(); //1 -> INFINI
  }

  _loadPage() {
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) async {
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("30sec gone!!");
      if (mounted) {
        print("30sec gone,and _loadChildrenOnline!!");
        await _loadPosts();
      } else {
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    });
  }

  _distAnimation() {
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: _animationDuration));
    timer2 = Timer.periodic(Duration(seconds: _animationDuration), (Timer t) async {
      if(mounted) {
        setState(() {
          _k++;
       print('$_animationDuration Second');
        });
      }else{
        print("errorTimer");
      }
    });

  }

  _back() {
    //Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(
        context, '/Library', (route) => false);
  }
}