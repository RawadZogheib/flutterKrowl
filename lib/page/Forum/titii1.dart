import 'dart:async';
import 'dart:convert';

import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/page/Responsive.dart';
import 'package:Krowl/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:Krowl/widgets/Forum/Forum1/QuestionContainer.dart';
import 'package:Krowl/widgets/Forum/Forum1/SearchBar.dart';
import 'package:Krowl/widgets/Forum/Forum2/Contributors.dart';
import 'package:Krowl/widgets/MyCustomScrollBehavior.dart';
import 'package:Krowl/widgets/MyDrawer.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/TabBar/CustomTabBar.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Forum1()));

class Forum1 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Forum1> createState() => _Forum1State();
}

class _Forum1State extends State<Forum1> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  var children = <Widget>[]; // Posts

  Timer? timer;
  Timer? timer2;

  AnimationController? animationController;

  final int _animationDuration = 3;
  int _k = 0, _notifNBR = 0, _count = 1;

  bool displayIcon = true, loading = false, moreData=true;
  // displayIcon ->  if it's true, there's error
  // loading -> if it's true, we will show a loader than new data
  // moreData -> When i'm in the end of the page and there's no more data to fetch so i will stop counting
  // infiniteScroll = false;

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    timer2?.cancel();
    animationController?.stop();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _distAnimation();
    _onInitState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent &&
          displayIcon == false) {
        // setState(() {
        //   infiniteScroll = true;
        // });

        _loadPosts();
        if(moreData){
          setState(() {
            _count++;

          });
        }


      }
    });
    super.initState();

  }

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
              mobile: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  reverse: false,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
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
                      displayIcon == true
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
              ),
              tablet: Stack(
                children: [
                  ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
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
                                  displayIcon == true
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
                  ),
                  CustomTabBar(
                    color: globals.blue1,
                    notifNBR: _notifNBR,
                    onTap: () => _onNotifTap(),
                  ),
                ],
              ),
              desktop: Stack(
                clipBehavior: Clip.none,
                children: [
                  ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
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
                                displayIcon == true
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
                                  ),
                                )
                                    : LayoutBuilder(
                                    builder: (context, constraints) {
                                      if (children.isNotEmpty) {
                                        return SizedBox(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              1.64,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height /
                                              1.55,
                                          child: Stack(
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  controller:
                                                  _scrollController,
                                                  itemBuilder:
                                                      (context, index) {
                                                    // if (msg) {
                                                    //   return Container(
                                                    //     width: MediaQuery.of(
                                                    //                 context)
                                                    //             .size
                                                    //             .width /
                                                    //         1.64,
                                                    //     height: 50,
                                                    //     child: Center(
                                                    //         child: Text(
                                                    //             "No More Data")),
                                                    //   );
                                                    // } else {

                                                    return children[index];
                                                    // }
                                                  },
                                                  itemCount: children.length),
                                              if (loading) ...[
                                                Positioned(
                                                  left: 0,
                                                  bottom: 0,
                                                  child: Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        1.64,
                                                    height: 80,
                                                    child: Center(
                                                        child:
                                                        LoadingAnimationWidget.flickr(leftDotColor: globals.blue_2, rightDotColor: globals.blue, size: 70)
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        );
                                      }
                                      else {
                                        return SizedBox(
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
                                          ),
                                        );
                                      }
                                    }),
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
                                            (220 + distAnimation.value)
                                                .toString()),
                                        width: double.parse(
                                            (350 + distAnimation.value)
                                                .toString()),
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
                  ),
                  CustomTabBar(
                    color: globals.blue1,
                    notifNBR: _notifNBR,
                    onTap: () => _onNotifTap(),
                  ),
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

        var account_Id = await SessionManager().get('account_Id');
        var user_uni = await SessionManager().get('user_uni');

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'user_uni': user_uni,
          'currentPage': _count
        };
        print(data);
        var res = await CallApi().postData(data, '(Control)loadPosts.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        //children.clear();
        if (mounted) {
          setState(() {
            loading = true;
            displayIcon = false;
          });
        }
        if (body[0] == "success") {
          await Future.delayed(Duration(milliseconds: 1000));
          _notifNBR = int.parse(body[1]);
          for (var i = 0; i < body[2].length; i++) {
            Color _color;
            Color _color2;
            if (int.parse(body[2][i][7]) == 0) {
              _color = Colors.grey.shade600;
              _color2 = Colors.grey.shade600;
            } else if (int.parse(body[2][i][7]) == 1) {
              _color = globals.blue1;
              _color2 = Colors.grey.shade600;
            } else if (int.parse(body[2][i][7]) == -1) {
              _color = Colors.grey.shade600;
              _color2 = globals.blue1;
            } else {
              _color = Colors.transparent;
              _color2 = Colors.transparent;
            }
            children.addAll(
              [
                Question(
                  id: body[2][i][0],
                  // post_id
                  username: body[2][i][1],
                  // username
                  tag: body[2][i][2],
                  // tag
                  text: body[2][i][3],
                  // post_data
                  val: int.parse(body[2][i][4]),
                  // post_val
                  date: body[2][i][5],
                  // post_date
                  question_context: body[2][i][6],
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
            moreData = true;
            //_count++;
            loading = false;
            //infiniteScroll = false;
          });
        } else if (body[0] == "errorVersion") {
          errorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          errorPopup(context, globals.errorToken);
        } else if (body[0] == "error7") {
          warningPopup(context, globals.warning7);
        } else if (body[0] == "empty" && _count > 0) {
          setState(() {
            moreData=false;
            loading = false;

          });
        } else { //if it's empty or there's an error
          if (mounted) {
            setState(() {
              displayIcon = true;
              moreData=false;
            });
            errorPopup(context, globals.errorElse);
          }
          globals.loadForm1 = false;
        }

        print('load forum1 end!!!');
        print(
            '=========<<======================================================<<==================================================<<=========');
      } catch (e) { //if try throw an error
        print(e);
        if (mounted) {
          setState(() {
            displayIcon = true;
            moreData=false;
          });
          errorPopup(context, globals.errorException);
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
    timer = Timer.periodic(const Duration(seconds: 6), (Timer t) async {
      print(
          '=========>>======================================================>>==================================================>>=========');

      print("HOLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA:   "
        //+infiniteScroll.toString()
      );
      print("30sec gone!!");
      if (mounted
      // && !infiniteScroll
      ) {

        print("30sec gone,and _loadChildrenOnline!!");

        _count = 1;
        children.clear();
        displayIcon =false;
        _loadPosts();
      } else {
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    });
  }

  _distAnimation() {
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: _animationDuration));
    timer2 =
        Timer.periodic(Duration(seconds: _animationDuration), (Timer t) async {
          if (mounted) {
            setState(() {
              _k++;
              print('$_animationDuration Second');
            });
          } else {
            print("errorTimer");
          }
        });
  }

  Future<void> _onInitState() async {
    if (await SessionManager().get('isLoggedIn') == true) {
      globals.currentPage = 'Forum';
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
