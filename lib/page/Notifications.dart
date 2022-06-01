import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../api/my_api.dart';
import '../widgets/Notification/NotificationContainer.dart';
import '../widgets/TabBar/CustomTabBar.dart';
import 'package:Krowl/globals/globals.dart' as globals;


void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Notifications()));

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
                      SizedBox(height: 130,),
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
                  )
              ),
              CustomTabBar(color: Colors.black,),
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
    var data = {'version': globals.version, 'account_Id': account_Id,'currentPage':1};
    var res = await CallApi()
        .postData(data, 'Notification/(Control)loadNotifications.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    _children.clear();
    if (body[0] == "success") {
      for (var i = 0; i < body[1].length; i++) {
        _children.add(
          NotificationContainer(
              notification_id: int.parse(body[1][i][0]),
              sender_id: int.parse(body[1][i][1]),
              sender_name: body[1][i][2],
              notification_type: int.parse(body[1][i][3]),
              notification_status: int.parse(body[1][i][4]),
              notification_params: body[1][i][5]),
        );
      }
      setState(() {
        _children;
      });
    }
  }
}