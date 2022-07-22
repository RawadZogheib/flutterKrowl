import 'dart:async';
import 'dart:convert';
import 'dart:math';

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
import 'package:eeffects/eEffect/effects/colorShift.dart';
import 'package:eeffects/eEffect/effects/gradient.dart';
import 'package:eeffects/eEffect/effects/light/lightBeam.dart';
import 'package:eeffects/eEffect/effects/light/radialLight.dart';
import 'package:eeffects/eEffect/math/relative.dart';
import 'package:eeffects/eEffect/math/relativePos.dart';
import 'package:eeffects/eEffect/math/vector2D.dart';
import 'package:eeffects/eEffect/scene/scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:imageview360/imageview360.dart';
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
  final int _animationDuration = 4;

  var children = <Widget>[]; // List of Posts
  List<int> tmpID = [];
  List<ImageProvider> imageList = <ImageProvider>[];

  Timer? timer;
  Timer? timer2;

  AnimationController? animationController;

  RotationDirection rotationDirection = RotationDirection.anticlockwise;

  int _k = 0;
  int _notifNBR = 0;
  int _count = 2;
  int rotationCount = 1000;
  int swipeSensitivity = 3;
  int rndm=1;

  bool displayIcon = true; //it's true on error/empty
  bool loader = false; //it's true when there's new data to load in the end of the page
  bool newPosts = false; //it's true when on loading every 30 seconds there's new posts
  bool autoRotate = true;
  bool allowSwipeToRotate = true;
  bool imagePrecached = false;

  String _profilePath =globals.initialProfilePath;

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    timer2?.cancel();
    animationController?.stop();
    _scrollController.dispose();
    tmpID.clear();
    super.dispose();
  }
    EScene? scene = EScene(
      width: 0,
      height: 0,
      effects: [
        // ERadialLight(
        //     ERelativePos(0.4, 0.4),
        //     ERelative(100, ERelative.absolute),
        //     EGradient([
        //       EColorShift([Color.fromARGB(100, 255, 180, 0)], 0)
        //     ]),
        //     0,
        //     0,
        //     ERelative(30, ERelative.absolute),
        //     ERelative(10, ERelative.absolute),
        //     0.1,
        //     1),
        ELightBeam(
            ERelativePos(0.5, 0.6),
            EVector2D(0, -100),
            ERelative(42, ERelative.widthAndHeightRelative),
            ERelative(24, ERelative.absolute),
            ERelative(0, ERelative.absolute),
            EGradient([
              EColorShift([Color.fromARGB(170,192,192,192)], 0),
              //EColorShift([Color.fromARGB(120, 255, 220, 100)], 0),
              //EColorShift([Color.fromARGB(120, 255, 190, 0)], 0),
            ]),
            30,
            0,
            ERelative(15, ERelative.absolute),
            ERelative(2, ERelative.absolute),
            1,
            1,
            name: "Example Beam")
      ],
      darkness: EColorShift([Color.fromARGB(0, 0, 0, 0)], 0),
      afterUpdate: () {
      },
      beforeUpdate: () {},
    );



  @override
  void initState() {
    _distAnimation();
    _onInitState();
    //* To load images from assets after first frame build up.
    WidgetsBinding.instance.addPostFrameCallback((_) => updateImageList(context));
    _scrollToEnd();

    super.initState();
  }

  Widget build(BuildContext context) {
    scene!.resize(320, 300);
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
            backgroundColor: Colors.white,
            //Colors.grey.shade50.withOpacity(0.98),
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
                    profilePath: _profilePath,
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
                              width: MediaQuery.of(context).size.width * 0.02,
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
                                                  controller: _scrollController,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return children[index];
                                                  },
                                                  itemCount: children.length),
                                              if (loader) ...[
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
                                                        child: LoadingAnimationWidget
                                                            .flickr(
                                                                leftDotColor:
                                                                    globals
                                                                        .blue1,
                                                                rightDotColor:
                                                                    Colors.pink,
                                                                size: 60)),
                                                  ),
                                                ),
                                              ],
                                              newPosts
                                                  ? Positioned(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      top: 0,
                                                      child: Center(
                                                        child: ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      globals
                                                                          .blue),
                                                              shadowColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      globals
                                                                          .blue_1),
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                      RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              19.0),
                                                                  //shadowColor: Colors.transparent,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .arrow_upward,
                                                                  color: globals
                                                                      .blue1,
                                                                  size: 20,
                                                                ),
                                                                SizedBox(
                                                                    width: 3),
                                                                Text(
                                                                  "New Posts",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontFamily:
                                                                          'Rubik',
                                                                      color: globals
                                                                          .blue1),
                                                                ),
                                                              ],
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              _scrollController.animateTo(
                                                                  1,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              2),
                                                                  curve: Curves
                                                                      .ease);
                                                              //_scrollController.jumpTo(1);
                                                              newPosts = false;
                                                              print(
                                                                  "NEEEEEWW POSTSS BUTTTONNNNNNN PRESSEDDDDDDDDDDDDDDD");
                                                              _count = 2;
                                                              tmpID.clear();
                                                              await _loadPosts(
                                                                  1, 3);
                                                            }),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        );
                                        // }
                                        // } else {
                                        //   return SizedBox(
                                        //     width: MediaQuery.of(context)
                                        //             .size
                                        //             .width *
                                        //         0.57,
                                        //     child: Center(
                                        //       child: Image(
                                        //         image: AssetImage(
                                        //             'Assets/krowl_logo.gif'),
                                        //         fit: BoxFit.cover,
                                        //         height: 150,
                                        //         width: 150,
                                        //       ),
                                        //     ),
                                        //   );
                                        // }
                                      }),
                              ],
                            ),
                            SizedBox(
                              child:Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 54,
                                      ),
                                      SizedBox(
                                        height: distAnimation.value,
                                      ),
                                      Contributors(
                                        height: double.parse(
                                            (170 + distAnimation.value)
                                                .toString()),
                                        width: double.parse(
                                            (300 + distAnimation.value)
                                                .toString()),
                                      ),
                                      SingleChildScrollView(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 32.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                (imagePrecached == true)
                                                    ? ImageView360(
                                                  key: ValueKey(rndm),
                                                  imageList: imageList,
                                                  autoRotate: autoRotate,
                                                  rotationCount: rotationCount,
                                                  rotationDirection: RotationDirection.anticlockwise,
                                                  frameChangeDuration: Duration(milliseconds: 1000),
                                                  swipeSensitivity: swipeSensitivity,
                                                  allowSwipeToRotate: allowSwipeToRotate,
                                                  onImageIndexChanged: (currentImageIndex) {
                                                    print("currentImageIndex: $currentImageIndex");
                                                  },
                                                )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:200,
                                        child:scene,
                                      ),
                                    ],
                                  ),

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
                    profilePath: _profilePath,
                    onTap: () => _onNotifTap(),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _loadPosts(int currentPage, int state) async {
    // State : 1 -> NewPage, 2 -> Timer, 3 -> NewPosts Button Clicked, 4 -> ScrollToEnd

    if (globals.loadForm1 == false) {
      globals.loadForm1 = true;
      while (globals.loadLikeDislikeForm1 == true) {
        await Future.delayed(Duration(seconds: 1));
        // print(
        //     '=========>>======================================================>>==================================================>>=========');
        // print("reload forum");
        // print(
        //     '=========<<======================================================<<==================================================<<=========');
      }

      try {
        print("TMP ID:" + tmpID.toString());
        var account_Id = await SessionManager().get('account_Id');
        var user_uni = await SessionManager().get('user_uni');

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'user_uni': user_uni,
          'currentPage': currentPage
        };
        print(data);
        var res = await CallApi().postData(data, '(Control)loadPosts.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        if (mounted && state == 4) {
          setState(() {
            loader = true;
            displayIcon = false;
          });
        } else if (mounted) {
          setState(() {
            displayIcon = false;
          });
        }

        if (body[0] == "success") {
          await Future.delayed(Duration(milliseconds: 1000));
          _notifNBR = int.parse(body[1][0]);
          setState((){
            _profilePath=body[1][1];
          });
          if (state == 3 || state == 1) {
            children.clear();
          }

          for (var i = 0; i < body[2].length; i++) {
            Color _color;
            Color _color2;
            if (int.parse(body[2][i][8]) == 0) {
              _color = Colors.grey.shade600;
              _color2 = Colors.grey.shade600;
            } else if (int.parse(body[2][i][8]) == 1) {
              _color = globals.blue1;
              _color2 = Colors.grey.shade600;
            } else if (int.parse(body[2][i][8]) == -1) {
              _color = Colors.grey.shade600;
              _color2 = globals.blue1;
            } else {
              _color = Colors.transparent;
              _color2 = Colors.transparent;
            }
            if (state == 2) {
              if (!tmpID.contains(int.parse(body[2][i][0]))) {
                newPosts = true;
                tmpID.add(int.parse(
                    body[2][i][0])); //make new post expired after 30 seconds
              }
            }
            if (state == 1 || state == 3 || (state == 4 && currentPage > 1)) {
              if (state == 1 || state == 4) {
                if (!tmpID.contains(int.parse(body[2][i][0]))) {
                  tmpID.add(int.parse(body[2][i][0]));
                } else {
                  continue;
                }
              }
              if (state == 3) {
                tmpID.add(int.parse(body[2][i][0]));
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

                    //profile picture
                    color: _color,
                    // like color
                    color2: _color2,
                    // dislike color
                    profilePath: body[2][i][7],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            }
          }

          setState(() {
            children;
            loader = false;
          });
          if (state == 4) {
            setState(() {
              _count++;
            });
          }
        }
        if (body[0] == "errorVersion") {
          errorPopup(context, globals.errorVersion);
        }
        if (body[0] == "errorToken") {
          errorPopup(context, globals.errorToken);
        }
        if (body[0] == "error7") {
          warningPopup(context, globals.warning7);
        }
        if (body[0] == "empty" && state == 4) {
          _notifNBR = int.parse(body[1][0]);
          setState(() {
            loader = false;
            _profilePath = body[1][1];
          });
        } else if (body[0] == "empty") {
          _notifNBR = int.parse(body[1][0]);
          if (mounted) {
            setState(() {
              displayIcon = true;
              _profilePath = body[1][1];
            });
            warningPopup(context, globals.warningEmptyPostPage);
          }
          globals.loadForm1 = false;
        }
        // else {
        //   if (mounted) {
        //     setState(() {
        //       displayIcon = true;
        //     });
        //     errorPopup(context, globals.errorElse);
        //   }
        //
        //   globals.loadForm1 = false;
        // }

        // print('load forum1 end!!!');
        // print(
        //     '=========<<======================================================<<==================================================<<=========');
      } catch (e) {
        print("EROROOROOOORRR");
        print(e);
        if (mounted) {
          setState(() {
            displayIcon = true;
          });
          errorPopup(context, globals.errorException);
        }
        globals.loadForm1 = false;
        // print(
        //     '=========<<======================================================<<==================================================<<=========');
      }
      globals.loadForm1 = false;
    }
  }

  _loadNewPage(){
    // print(
    //     '=========>>======================================================>>==================================================>>=========');
    timer?.cancel();
    _loadPosts(1, 1); //0
    _loadPage(); //1 -> INFINI
  }

  _loadPage() {
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) async {
      // print(
      //     '=========>>======================================================>>==================================================>>=========');
      // print("30sec gone!!");
      if (mounted) {
        //print("30sec gone,and _loadChildrenOnline!!");
        print("TIMERRRRRRRRRRRRRRR");
        //displayIcon = false;
        await _loadPosts(1, 2);
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
          //print('$_animationDuration Second');
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

  void _scrollToEnd() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          displayIcon == false) {
        print("SCROLLLLLLLLLLLLLLLLLL DOWNNNNNN !");
        _loadPosts(_count, 4);
      }
    });
  }

  void updateImageList(BuildContext context) async {
    rndm = Random().nextInt(1);
    for (int i = 1; i <= 8; i++) {
      imageList.add(AssetImage('Assets/$i.jpg'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('Assets/$i.jpg'), context);
    }
    setState(() {
      imagePrecached = true;
    });
  }
}
