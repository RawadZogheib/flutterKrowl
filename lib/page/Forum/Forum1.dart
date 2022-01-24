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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    globals.currentPage = 'Forum';
    _loadNewPage();
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: globals.white,
        body: Responsive(
          mobile: SingleChildScrollView(
            reverse: false,
            child: Column(
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
                SearchBar(),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: children, // My Children
                ),
              ],
            ),
          ),
          tablet: SingleChildScrollView(
            reverse: false,
            child: Row(
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
                          width: MediaQuery.of(context).size.width * 0.2,
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
                    SearchBar(),
                    SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: children, // My Children
                    ),
                  ],
                ),
              ],
            ),
          ),
          desktop: SingleChildScrollView(
            reverse: false,
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTabBar(),
                ],
              ),
              SizedBox(
                height: 50,
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
                            width: MediaQuery.of(context).size.width * 0.35,
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
                      SearchBar(),
                      SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: children, // My Children
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Contributors(),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  _loadPosts() async {
    children.clear();
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

    if (body[0] == "success") {
      for (var i = 0; i < body[1].length; i++) {
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
              val: int.parse(body[1][0][4]),
              // post_val
              date: body[1][i][5],
              // post_date
              question_context: body[1][i][6],
              //context of the question
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
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              "Your version: " + globals.version + "\n" + globals.errorVersion),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "errorToken") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.errorToken),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "error7") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.error7),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  _loadNewPage() {
    timer?.cancel();
    _loadPosts(); //0
    _loadPage(); //1 -> INFINI
  }

  _loadPage() {
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      print("30sec gone!!");
      if (mounted) {
        print("30sec gone,and _loadChildrenOnline!!");
        _loadPosts();
      }
    });
  }
}
