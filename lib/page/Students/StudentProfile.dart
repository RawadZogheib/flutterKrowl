import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_app_backend/widgets/Students/StudentProfile/ProfileQuestions&Replies.dart';
import 'package:flutter_app_backend/widgets/Students/StudentProfile/StudentDetailedProfileContainer.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> TheQuestion = [];
  List<String> contextQuestion = [];
  List<String> dateOfQuestion = [];
  int questionsNbr = 0;

  //ProfileReplies
  List<String> TheAskedQuestion = [];
  List<String> reply = [];
  List<String> DateOfReply = [];
  int repliesNbr = 0;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    globals.currentPage = 'StudentCard';
    _loadNewPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      TheQuestion: TheQuestion,
                      contextQuestion: contextQuestion,
                      dateOfQuestion: dateOfQuestion,
                      TheAskedQuestion: TheAskedQuestion,
                      reply: reply,
                      DateOfReply: DateOfReply,
                      nbrOfQuestions: questionsNbr,
                      nbrOfReplies: repliesNbr,
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
          CustomTabBar(),
        ],
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

              questionsNbr = body[2].length;
              for (int i = 0; i < body[2].length; i++) {
                //ProfileQuestions
                TheQuestion.add(body[2][i][0]);
                contextQuestion.add(body[2][i][1]);
                dateOfQuestion.add(body[2][i][2]);
              }
              repliesNbr = body[3].length;
              for (int i = 0; i < body[3].length; i++) {
                //ProfileReplies
                TheAskedQuestion.add(body[3][i][0]);
                reply.add(body[3][i][1]);
                DateOfReply.add(body[3][i][2]);
              }
              print('dfdsfdsfdsf' + TheAskedQuestion.toString());
            });
          }
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          ErrorPopup(context, globals.error4);
        }  else if (body[0] == "error7") {
          WarningPopup(context, globals.warning7);
        } else {
          globals.loadStudentProfile = false;
          ErrorPopup(context, globals.errorElse);
        }

      globals.loadStudentProfile = false;
      print('load studentPage end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
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
}
