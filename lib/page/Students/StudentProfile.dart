import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/Students/StudentProfile/ProfileQuestions&Replies.dart';
import 'package:Krowl/widgets/Students/StudentProfile/ProfileQuestions.dart';
import 'package:Krowl/widgets/Students/StudentProfile/ProfileReplies.dart';
import 'package:Krowl/widgets/Students/StudentProfile/StudentDetailedProfileContainer.dart';
import 'package:Krowl/widgets/TabBar/CustomTabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/MyDrawer.dart';

class StudentProfile extends StatefulWidget {
  String userId;
  String username;
  String universityName;
  String description;
  int nbrOfFriends;
  String isFriend;

  StudentProfile({
    required this.userId,
    required this.username,
    required this.universityName,
    required this.description,
    this.nbrOfFriends = 0,
    required this.isFriend,
  });

  // This widget is the root of your application.
  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  Timer? timer;

  //ProfileQuestions
  List<ProfileQuestions> children1 = [];

  // List<String> TheQuestion = [];
  // List<String> contextQuestion = [];
  // List<String> dateOfQuestion = [];
  //int questionsNbr = 0;

  //ProfileReplies
  List<ProfileReplies> children2 = [];

  // List<String> TheAskedQuestion = [];
  // List<String> reply = [];
  // List<String> DateOfReply = [];
  //int repliesNbr = 0;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    globals.currentPage = 'StudentProfile';
    _loadNewPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _back(),
      child: Scaffold(
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
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 130,
                      ),
                      StudentDetailedProfile(
                        userId: widget.userId,
                        username: widget.username,
                        universityName: widget.universityName,
                        description: widget.description,
                        isFriend: widget.isFriend,
                        nbrOfFriends: widget.nbrOfFriends,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      StudentQuestionsReplies(
                        children1: children1,
                        children2: children2,
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  )
                ],
              ),
            ),
            CustomTabBar(
              color: globals.blue1,
            ),
          ],
        ),
      ),
    );
  }

  _loadProfile() async {
    if (globals.loadStudentProfile == false) {
      globals.loadStudentProfile = true;
      while (globals.loadButtonStudentProfile == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload studentPage");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }

      try {
        print('load studentPage');
        //globals.occupenTable.clear();
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var account_Id = localStorage.getString("account_Id");

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'userId': widget.userId,
        };

        var res = await CallApi().postData(data, '(Control)loadProfiles.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        if (body[0] == "success") {
          if (mounted) {
            setState(() {
              widget.username = body[1][0] + ' ' + body[1][1];
              widget.universityName = body[1][2];
              widget.description = body[1][3];
              widget.nbrOfFriends = int.parse(body[1][4]);
              widget.isFriend = body[1][5];

              children1.clear();
              for (int i = 0; i < body[2].length; i++) {
                Color _color;
                Color _color2;
                if (int.parse(body[2][i][4]) == 0) {
                  _color = Colors.grey.shade600;
                  _color2 = Colors.grey.shade600;
                } else if (int.parse(body[2][i][4]) == 1) {
                  _color = globals.blue1;
                  _color2 = Colors.grey.shade600;
                } else if (int.parse(body[2][i][4]) == -1) {
                  _color = Colors.grey.shade600;
                  _color2 = globals.blue1;
                } else {
                  _color = Colors.transparent;
                  _color2 = Colors.transparent;
                }
                children1.add(
                  ProfileQuestions(
                    Id: body[2][i][0],
                    firstLastName: body[2][i][1],
                    Post_tag: body[2][i][2],
                    Post_val: int.parse(body[2][i][3]),
                    color: _color,
                    color2: _color2,
                    TheQuestion: body[2][i][5],
                    contextQuestion: body[2][i][6],
                    nbrOfReplies: body[2][i][7],
                    dateOfQuestion: 'on ' + body[2][i][8],
                  ),
                );
              }

              children2.clear();
              for (int j = 0; j < body[3].length; j++) {
                Color _color;
                Color _color2;
                if (int.parse(body[3][j][5]) == 0) {
                  _color = Colors.grey.shade600;
                  _color2 = Colors.grey.shade600;
                } else if (int.parse(body[3][j][5]) == 1) {
                  _color = globals.blue1;
                  _color2 = Colors.grey.shade600;
                } else if (int.parse(body[3][j][5]) == -1) {
                  _color = Colors.grey.shade600;
                  _color2 = globals.blue1;
                } else {
                  _color = Colors.transparent;
                  _color2 = Colors.transparent;
                }

                children2.add(
                  ProfileReplies(
                    postId: body[3][j][0],
                    Id: body[3][j][1],
                    userName: body[3][j][2],
                    firstLastName: body[1][0] + ' ' + body[1][1],
                    Post_tag: body[3][j][3],
                    Post_val: int.parse(body[3][j][4]),
                    color: _color,
                    color2: _color2,
                    TheAskedQuestion: body[3][j][6],
                    Post_context: body[3][j][7],
                    post_date: body[3][j][8],
                    reply: body[3][j][9],
                    DateOfReply: 'on ' + body[3][j][10],
                  ),
                );
              }
            });
          }
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          ErrorPopup(context, globals.error4);
        } else if (body[0] == "error7") {
          WarningPopup(context, globals.warning7);
        } else {
          globals.loadStudentProfile = false;
          ErrorPopup(context, globals.errorElse);
        }

        globals.loadStudentProfile = false;
        print('load studentPage end!!!');
        print(
            '=========<<======================================================<<==================================================<<=========');
      } catch (e) {
        print(e);
        globals.loadStudentProfile = false;
        ErrorPopup(context, globals.errorException);
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    }
  }

  _loadNewPage() {
    timer?.cancel();
    _loadProfile(); //0
    _loadPage(); //1 -> INFINI
  }

  _loadPage() {
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      print("30sec gone!!");
      if (mounted) {
        print("30sec gone,and _loadChildrenOnline!!");
        _loadProfile();
      }
    });
  }

  _back() {
    //Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, '/Library', (route) => false);
  }
}
