import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/PopUp/notificationPopup/notificationPopup.dart';

class CustomTabBar extends StatefulWidget {
  CustomTabBar({
    this.text,
  });

  var text;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  bool _menuShown = false;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Animation<double> opacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController!);
    if (_menuShown)
      animationController!.forward();
    else
      animationController!.reverse();
    return Column(
      // clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: globals.blue2,
            border: Border(
              bottom: BorderSide(width: 4, color: globals.blue1),
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
                      onTap: () {},
                      child: Text("Reminders",
                          style: TextStyle(
                            color: globals.blue1,
                            fontFamily: 'Rubik',
                            fontSize: 15,
                          )),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.notifications_none_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _menuShown = !_menuShown;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('Assets/userImage6.jpeg'),
                      maxRadius: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(child: SizedBox()),
            IgnorePointer(
              ignoring: !_menuShown,
              child: FadeTransition(
                opacity: opacityAnimation,
                child: ShapedWidget(),
              ),
            ),
            SizedBox(
              width: 12,
            )
          ],
        ),
      ],
    );
  }
}
