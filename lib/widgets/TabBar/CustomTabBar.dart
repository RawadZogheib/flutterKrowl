import 'dart:convert';

import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Buttons/myButton.dart';
import 'package:Krowl/widgets/PopUp/ProfilePopUp.dart';
import 'package:Krowl/widgets/PopUp/notificationPopup/notificationPopup.dart';
import 'package:Krowl/widgets/PopUp/notificationPopup/notificationPopupChildren.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class CustomTabBar extends StatefulWidget {
  int notifNBR;
  Color color;
  bool isBellHidden;
  Function() onTap;

  CustomTabBar({
    Key? key,
    this.notifNBR = 0,
    required this.color,
    this.isBellHidden = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  AnimationController? animationController2;
  bool _menuShown = false;
  bool _profileIsClicked = false;
  int _k = 0;
  List<NotificationPopupChildren> _children1 = [];
  List<Widget> _children2 = [];
  bool _isEmpty = false;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double _height = MediaQuery.of(context).size.height;
    Animation<double> opacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController!);
    if (_menuShown) {
      animationController!.forward();
    } else {
      animationController!.reverse();
    }
    Animation<double> opacityAnimation2 =
        Tween(begin: 0.0, end: 1.0).animate(animationController2!);
    if (_profileIsClicked)
      animationController2!.forward();
    else
      animationController2!.reverse();
    return Stack(
      // clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: globals.blue2,
            border: Border(
              bottom: BorderSide(width: 4, color: widget.color),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    'Assets/krowl_logo2.png',
                    scale: 2.0,
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        if (globals.currentPage != 'Library') {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/Library', (route) => false);
                        }
                      },
                      child: Text("Library",
                          style: TextStyle(
                            color: globals.blue1,
                            fontFamily: 'Rubik',
                            fontSize: 15,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        if (globals.currentPage != 'Chat') {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/MainChat', (route) => false);
                        }
                      },
                      child: Text("Chat",
                          style: TextStyle(
                            color: globals.blue1,
                            fontFamily: 'Rubik',
                            fontSize: 15,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        if (globals.currentPage != 'Forum') {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/Forum1', (route) => false);
                        }
                      },
                      child: Text("Forum",
                          style: TextStyle(
                            color: globals.blue1,
                            fontFamily: 'Rubik',
                            fontSize: 15,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        if (globals.currentPage != 'Students') {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/Students1', (route) => false);
                        }
                      },
                      child: Text("Students",
                          style: TextStyle(
                            color: globals.blue1,
                            fontFamily: 'Rubik',
                            fontSize: 15,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        if (globals.currentPage != 'Reminders') {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/Reminders', (route) => false);
                        }
                      },
                      child: Text("Reminders",
                          style: TextStyle(
                            color: globals.blue1,
                            fontFamily: 'Rubik',
                            fontSize: 15,
                          )),
                    ),
                  ),
                  widget.isBellHidden == false
                      ? widget.notifNBR > 0
                          ? Badge(
                              position: BadgePosition.topEnd(top: -8, end: 4),
                              badgeContent: Text(
                                widget.notifNBR.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.notifications_none_outlined,
                                  ),
                                  onPressed: () async {
                                    if (_menuShown == false) {
                                      setState(() {
                                        widget.onTap();
                                      });
                                      // setState(() {
                                      //   _isCLickedNotif = true;
                                      // });
                                      //CustomTabBar(key: ValueKey(_k1), notifNBR: 0, color: globals.blue1,);
                                      await _loadNotifications();
                                    }
                                    setState(() {
                                      if (_profileIsClicked == true)
                                        _profileIsClicked = false;
                                      _menuShown = !_menuShown;
                                    });
                                  }),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.notifications_none_outlined,
                              ),
                              onPressed: () async {
                                if (_menuShown == false) {
                                  await _loadNotifications();
                                  // setState(() {
                                  //   _k++;
                                  // });
                                }
                                setState(() {
                                  if (_profileIsClicked == true)
                                    _profileIsClicked = false;
                                  _menuShown = !_menuShown;
                                });
                              })
                      : SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (_menuShown == true) _menuShown = false;
                          _profileIsClicked = !_profileIsClicked;
                        });
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('Assets/userImage6.jpeg'),
                        maxRadius: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IgnorePointer(
          ignoring: !_menuShown,
          child: Padding(
            padding: const EdgeInsets.only(top: 83.0),
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                FadeTransition(
                  opacity: opacityAnimation,
                  child: ShapedWidget(
                      key: ValueKey(_k),
                      children1: _children1,
                      children2: _children2,
                      isEmpty: _isEmpty),
                ),
                SizedBox(
                  width: 12,
                )
              ],
            ),
          ),
        ),
        IgnorePointer(
          ignoring: !_profileIsClicked,
          child: Padding(
            padding: const EdgeInsets.only(top: 83.0),
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                FadeTransition(
                  opacity: opacityAnimation2,
                  child: ShapedWidgetProfile(),
                ),
                SizedBox(
                  width: 12,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _loadNotifications() async {
    var account_Id = await SessionManager().get('account_Id');
    var data = {
      'version': globals.version,
      'account_Id': account_Id,
      'currentPage': 1,
      'notif_nbr': widget.notifNBR
    };
    var res = await CallApi()
        .postData(data, 'Notification/(Control)loadNotifications.php');
    print(res.body);
    _children1.clear();
    List<dynamic> body = json.decode(res.body);
    if (body[0] == "success") {
      setState(() {
        _isEmpty = false;
      });
      for (var i = 0; i < body[1].length; i++) {
        _children1.add(NotificationPopupChildren(
          notification_id: int.parse(body[1][i][0]),
          sender_id: int.parse(body[1][i][1]),
          sender_name: body[1][i][2],
          notification_type: int.parse(body[1][i][3]),
          notification_status: int.parse(body[1][i][4]),
          notification_params: body[1][i][5],
        ));
      }
      setState(() {
        _k++;
        _children1;
      });
    } else if (body[0] == "empty") {
      setState(() {
        _isEmpty = true;
      });
      _children2.clear();
      _children2.add(
        Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 50),
          child: Column(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.075,
                  child: Image(image: AssetImage('Assets/ring1.png'))),
              SizedBox(height: 13),
              Text(
                textAlign: TextAlign.center,
                'No notifications yet.',
                style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                    fontFamily: 'Rubik'),
              ),
              SizedBox(height: 3),
              Text(
                textAlign: TextAlign.center,
                'When you get notifications, theyll show up here ',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    color: Colors.grey,
                    fontFamily: 'Rubik'),
              ),
              SizedBox(height: 10),
              myBtn2(
                  btnText: Text("Refresh"),
                  height: 40,
                  width: 95,
                  onPress: () {
                    _loadNotifications();
                  },
                  color1: globals.blue2,
                  color2: globals.blue1),
            ],
          ),
        ),
      );
      setState(() {
        _k++;
        _children2;
      });
    }
  }
}
