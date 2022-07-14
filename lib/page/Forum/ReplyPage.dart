import 'dart:async';
import 'dart:convert';

import 'package:Krowl/widgets/MyCustomScrollBehavior.dart';
import 'package:flutter/material.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Forum/Forum2/Contributors.dart';
import 'package:Krowl/widgets/Forum/ReplyPage/DetailedReplyContainer.dart';
import 'package:Krowl/widgets/Forum/ReplyPage/RepliesWidget.dart';
import 'package:Krowl/widgets/Forum/ReplyPage/UnansweredQuestions.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/TabBar/CustomTabBar.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/MyDrawer.dart';

class ReplyPage extends StatefulWidget {
  String id;
  String question;
  String subject;
  String username;
  int val;
  String contextQuestion;
  var date;
  Color color;
  Color color2;
  String? reply_id;

  ReplyPage({
    required this.id,
    required this.question,
    required this.subject,
    required this.username,
    required this.val,
    required this.contextQuestion,
    required this.date,
    required this.color,
    required this.color2,
    this.reply_id
  });

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage>
    with SingleTickerProviderStateMixin {
  var children = <Widget>[]; //Replies
  var children2 = <Widget>[];
  Timer? timer;
  int _currentPage = 1;
  int _totalPages = 999;
  int _totalReplies = 11988;
  int _maxReplies = 20;
  bool _load = true;

  Timer? timer2;
  AnimationController? animationController;
  final int _animationDuration = 4;
  int _k = 0;

  int _notifNBR =0;

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
    // TODO: implement initState
    _distAnimation();
    _onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          builder: (BuildContext context, Widget) {
            return Scaffold(
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
              body: Stack(
                children: [
                  Column(children: [
                    SizedBox(
                      height: 130,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScrollConfiguration(
                            behavior: MyCustomScrollBehavior(),
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Wrap(
                                      direction: Axis.vertical,
                                      children: children2.toList(), // My Children
                                    ),

                                    // DetailedReplyContainer(
                                    //   id: widget.id,
                                    //   question: widget.question,
                                    //   subject: widget.subject,
                                    //   username: widget.username,
                                    //   val: widget.val,
                                    //   color: widget.color,
                                    //   color2: widget.color2,
                                    //   contextQuestion: widget.contextQuestion,
                                    //   date: widget.date,
                                    //   onTap: (id, date) => _addReply(id, date),
                                    // ),

                                    SizedBox(
                                      height: 30,
                                    ),
                                    ScrollConfiguration(
                                      behavior: MyCustomScrollBehavior(),
                                      child: SingleChildScrollView(
                                        controller: ScrollController(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 110.0, bottom: 15),
                                          child: _load == true
                                              ? Text("Replies (Loading...)",
                                                  // this is the number of replies
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black))
                                              : Text("Replies ($_totalReplies)",
                                                  // this is the number of replies
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black)),
                                        ),
                                      ),
                                    ),
                                    _load == true
                                        ? Center(
                                            child: Image(
                                              image: AssetImage(
                                                  'Assets/krowl_logo.gif'),
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: 150,
                                            ),
                                          )
                                        : Wrap(
                                            direction: Axis.vertical,
                                            children:
                                                children.toList(), // My Children
                                          ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      padding: const EdgeInsets.all(8.0),
                                      child: _load == true
                                          ? null
                                          : NumberPaginator(
                                              numberPages: _totalPages,
                                              onPageChange: (int index) {
                                                setState(() {
                                                  _currentPage = index + 1;
                                                  print(index + 1);
                                                });
                                                _loadNewPage();
                                              },
                                              // initially selected index
                                              initialPage: _currentPage - 1,
                                              // default height is 48
                                              buttonShape: BeveledRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              buttonSelectedForegroundColor:
                                                  globals.blue2,
                                              buttonUnselectedForegroundColor:
                                                  globals.blue1,
                                              buttonUnselectedBackgroundColor:
                                                  globals.blue2,
                                              buttonSelectedBackgroundColor:
                                                  globals.blue1,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 385,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior(),
                                  child: SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: distAnimation.value,
                                        ),
                                        Contributors(
                                          height: double.parse(
                                              (220 + distAnimation.value)
                                                  .toString()),
                                          width: double.parse(
                                              (350 + distAnimation.value)
                                                  .toString()),
                                        ),
                                        SizedBox(
                                          height: distAnimation.value,
                                        ),
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                        UnansweredQuestions(
                                          username: 'idotalia',
                                          question:
                                              ' Anyone here have experience with Pytorch?',
                                          contextofquestion:
                                              'dsngujbnuydfvhngysdnbvugfndugn',
                                          NbrReplies: 1,
                                          height: double.parse(
                                              (270 + distAnimation.value)
                                                  .toString()),
                                          width: double.parse(
                                              (350 + distAnimation.value)
                                                  .toString()),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  CustomTabBar(
                    color: globals.blue1,
                    notifNBR: _notifNBR,
                    onTap: () => _onNotifTap(),
                  ),
                ],
              ),
            );
          }),
    );
  }

  _loadReplies() async {
    if (globals.loadReplyPage == false) {
      globals.loadReplyPage = true;
      while (globals.loadLikeDislikeReplyPage == true ||
          globals.loadCreateReplyPage == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload replyPage");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
      try {
        print('load replyPage');
        // if (mounted) {
        //   setState(() {
        //     children.clear();
        //     load = true;
        //   });
        // }

        var account_Id = await SessionManager().get('account_Id');

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'post_id': widget.id,
          'currentPage': _currentPage,
        };

        var res = await CallApi().postData(data, '(Control)loadReplies.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        children.clear();
        children2.clear();

        if (mounted) {
          setState(() {
            _load = false;
          });
        }
        if (body[0] == "success") {
          if (mounted) {
            setState(() {
              _notifNBR = int.parse(body[1]);
              _totalReplies = int.parse(body[2]);
              _totalPages = (_totalReplies / _maxReplies).ceil();
            });
          }

          for (var i = 0; i < body[4].length; i++) {
            Color _color;
            Color _color2;
            if (int.parse(body[4][i][5]) == 0) {
              _color = Colors.grey.shade600;
              _color2 = Colors.grey.shade600;
            } else if (int.parse(body[4][i][5]) == 1) {
              _color = globals.blue1;
              _color2 = Colors.grey.shade600;
            } else if (int.parse(body[4][i][5]) == -1) {
              _color = Colors.grey.shade600;
              _color2 = globals.blue1;
            } else {
              _color = Colors.transparent;
              _color2 = Colors.transparent;
            }
            children.add(
              new Replies(
                id: body[4][i][0],
                // reply_date
                postId: widget.id,
                // replyPageId
                username: body[4][i][1],
                // username
                reply: body[4][i][2],
                // reply_data
                val: int.parse(body[4][i][3]),
                // reply_like
                date: body[4][i][4],
                // reply_date
                color: _color,
                //
                color2: _color2,
              ),
            );
          }

          Color _color;
          Color _color2;
          if (int.parse(body[3][6]) == 0) {
            _color = Colors.grey.shade600;
            _color2 = Colors.grey.shade600;
          } else if (int.parse(body[3][6]) == 1) {
            _color = globals.blue1;
            _color2 = Colors.grey.shade600;
          } else if (int.parse(body[3][6]) == -1) {
            _color = Colors.grey.shade600;
            _color2 = globals.blue1;
          } else {
            _color = Colors.transparent;
            _color2 = Colors.transparent;
          }

          children2.add(
            DetailedReplyContainer(
              id: widget.id,
              question: body[3][2],
              subject: body[3][1],
              username: body[3][0],
              val: int.parse(body[3][3]),
              color: _color,
              color2: _color2,
              contextQuestion: body[3][5],
              date: body[3][4],
              onTap: (id, date) => _addReply(id, date),
            ),
          );

          if (mounted) {
            setState(() {
              // widget.username = ;
              // widget.subject = ;
              // widget.question = ;
              // widget.val = ;
              // widget.date = ;
              // widget.contextQuestion = ;
              // widget.color = ;
              // widget.color2 = ;
              children2;
              children;
            });
          }
        } else if (body[0] == "empty") {
         _notifNBR = int.parse(body[1]);
          if (_currentPage != 1) {
            setState(() {
              _currentPage = 1;
            });
            _loadNewPage();
          } else {
            warningPopup(context, globals.warningEmptyReplyPage);
          }
        } else if (body[0] == "errorVersion") {
          errorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          errorPopup(context, globals.errorToken);
        } else if (body[0] == "error7") {
          warningPopup(context, globals.warning7);
        } else {

          if (mounted) {
            setState(() {
              _load = true;
            });
          }
          globals.loadReplyPage = false;
          errorPopup(context, globals.errorElse);
        }
        globals.loadReplyPage = false;
        print('load replyPage end!!!');
        print(
            '=========<<======================================================<<==================================================<<=========');
      } catch (e) {
        print(e);
        globals.loadReplyPage = false;
        if (mounted) {
          setState(() {
            _load = true;
          });
        }
        errorPopup(context, globals.errorException);
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    }
  }

  _loadNewPage() {
    print(
        '=========>>======================================================>>==================================================>>=========');
    timer?.cancel();
    _loadReplies(); //0
    _loadPage(); //1 -> INFINI
  }

  _loadPage() {
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("30sec gone!!");
      if (mounted) {
        print("30sec gone,and _loadChildrenOnline!!");
        _loadReplies();
      } else {
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    });
  }

  _addReply(id, date) async {
    print(id);

    String? username = await SessionManager().get('username');

    if (mounted) {
      setState(() {
        _totalReplies++;
        _totalPages = (_totalReplies / _maxReplies).ceil();
        if (_currentPage != 1) {
          _currentPage = 1;
          _loadNewPage();
        } else {
          if (children.length == _maxReplies) children.removeLast();
          children.insert(
            0,
            Replies(
              id: id,
              postId: widget.id,
              username: username,
              reply: globals.reply_data,
              val: 0,
              date: date,
              color: Colors.grey.shade600,
              color2: Colors.grey.shade600,
            ),
          );
        }

        //globals.occupenTable.add('0');
      });
    }

    // if (mounted) {
    //   setState(() {
    //     children.insert(
    //       0,
    //       Replies(
    //         id: id,
    //         postId: widget.id,
    //         username: username,
    //         reply: globals.reply_data,
    //         val: 0,
    //         date: date,
    //         color: Colors.grey.shade600,
    //         color2: Colors.grey.shade600,
    //       ),
    //     );
    //   });
    // }
  }

  void _distAnimation() {
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: _animationDuration));
    timer2 =
        Timer.periodic(Duration(seconds: _animationDuration), (Timer t) async {
      setState(() {
        _k++;
        print('$_animationDuration Second');
      });
    });
  }

  Future<void> _onInitState() async {
    if (await SessionManager().get('isLoggedIn') == true) {
      globals.currentPage = 'ForumReply';
      children2.add(
        DetailedReplyContainer(
          id: widget.id,
          question: widget.question,
          subject: widget.subject,
          username: widget.username,
          val: widget.val,
          color: widget.color,
          color2: widget.color2,
          contextQuestion: widget.contextQuestion,
          date: widget.date,
          onTap: (id, date) => _addReply(id, date),
        ),
      );
      _loadNewPage();
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/intro_page', (route) => false);
    }
  }

  _back() {
    //Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, '/Library', (route) => false);
  }

  void _onNotifTap() {
    setState(() {
      _notifNBR = 0;
    });
  }

}
