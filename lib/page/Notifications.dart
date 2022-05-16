import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
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

  @override
  void initState() {
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
                            NotificationContainer(username: "Michoo"),
                            NotificationContainer(username: "Michoo"),
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
}
