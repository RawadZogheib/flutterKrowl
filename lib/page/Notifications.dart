import 'dart:convert';

import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Buttons/myButton.dart';
import 'package:Krowl/widgets/Notification/NotificationContainer.dart';
import 'package:Krowl/widgets/PopUp/notificationPopup/notificationPopupChildren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../api/my_api.dart';
import '../widgets/TabBar/CustomTabBar.dart';

void main() => runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: Notifications()));

class Notifications extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var _children = <Widget>[];

  @override
  void initState() {
    _loadNotifications();
    _onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 130,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            children: _children, // My Children
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )),
              CustomTabBar(
                color: Colors.black,
                isBellHidden: true,
                onTap: () => _onNotifTap(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onInitState() async {
    if (await SessionManager().get('isLoggedIn') == true) {
      globals.currentPage = 'Notifications';
      //_loadNewPage();
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/intro_page', (route) => false);
    }
  }

  Future<void> _loadNotifications() async {
    var account_Id = await SessionManager().get('account_Id');
    var data = {
      'version': globals.version,
      'account_Id': account_Id,
      'currentPage': 1,
      'notif_nbr': ""
    };
    var res = await CallApi()
        .postData(data, 'Notification/(Control)loadNotifications.php');
    print(res.body);
    _children.clear();
    List<dynamic> body = json.decode(res.body);
    if (body[0] == "success") {
      for (var i = 0; i < body[1].length; i++) {
        _children.add(NotificationContainer(
          notification_id: int.parse(body[1][i][0]),
          sender_id: int.parse(body[1][i][1]),
          sender_name: body[1][i][2],
          notification_type: int.parse(body[1][i][3]),
          notification_status: int.parse(body[1][i][4]),
          notification_params: body[1][i][5],
        ));
      }
      setState(() {
        _children;
      });
    } else if (body[0] == "empty") {
      _children.add(
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
        _children;
      });
    }
  }
  void _onNotifTap() {
  }
}
