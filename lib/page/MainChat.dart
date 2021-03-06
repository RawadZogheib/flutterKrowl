import 'dart:async';
import 'dart:convert';

import 'package:Krowl/api/my_api.dart';
import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/page/Responsive.dart';
import 'package:Krowl/widgets/Chat/components/streamChatContacts.dart';
import 'package:Krowl/widgets/MyDrawer.dart';
import 'package:Krowl/widgets/TabBar/CustomTabBar.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../widgets/Chat/modules/chat_page.dart';

var client = StreamChatClient(globals.apiKey, logLevel: Level.INFO);

class MainChat extends StatefulWidget {
  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  bool initBool = false;
  Timer? timer;

  int _notifNBR=0;
  String _profilePath =globals.initialProfilePath;

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    await client.disconnectUser();
    timer?.cancel();
    super.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState

    _onInitState();
    super.initState();
  }

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    StreamExampleTest(client: client),
    // ChatPage(),
    ChatPage2(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _back(),
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     await initChat();
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => StreamExample(
        //           client: client,
        //           channel: channel,
        //         ),
        //       ),
        //     );
        //   },
        //   backgroundColor: Colors.green,
        //   child: const Icon(Icons.navigation),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue.shade900,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: "Friends",
            ),
          ],
        ),
        drawer: MyDrawer(),
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
        body: Responsive(
          mobile: Center(
            child: initBool == true
                ? _widgetOptions.elementAt(_selectedIndex)
                : Center(
                    child: Image(
                      image: AssetImage('Assets/krowl_logo.gif'),
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                    ),
                  ),
          ),
          tablet: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Center(
                      child: initBool == true
                          ? _widgetOptions.elementAt(_selectedIndex)
                          : Center(
                              child: Image(
                                image: AssetImage('Assets/krowl_logo.gif'),
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              CustomTabBar(
                color: globals.blue1,
                notifNBR: _notifNBR,
                onTap: () => _onNotifTap(),
                profilePath:_profilePath,
              ),
            ],
          ),
          desktop: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Center(
                      child: initBool == true
                          ? _widgetOptions.elementAt(_selectedIndex)
                          : Center(
                              child: Image(
                                image: AssetImage('Assets/krowl_logo.gif'),
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              CustomTabBar(
                color: globals.blue1,
                notifNBR: _notifNBR,
                onTap: () => _onNotifTap(),
                profilePath:_profilePath,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  _loadNewPage() {
    print(
        '=========>>======================================================>>==================================================>>=========');
    timer?.cancel();
    _loadNotifications(); //0
    _loadPage(); //1 -> INFINI
  }

  _loadPage() {
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) async {
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("30sec gone!!");
      if (mounted) {
        print("30sec gone,and _loadChildrenOnline!!");
         await _loadNotifications();
      } else {
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    });
  }
  initChat() async {
    var usernameChat = await SessionManager().get('username');
    var userToken = await SessionManager().get('userTokenChat');
    print("ddddddddddddddddddddddddd" + userToken.toString());

    await client
        .connectUser(
          User(id: usernameChat.toString(), extraData: {
            "name": usernameChat,
            // image:
            // 'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
          }),
          userToken.toString(),
        )
        .then((value) => {
              setState(() {
                initBool = true;
              })
            });
  }

  Future<void> _onInitState() async {
    if (await SessionManager().get('isLoggedIn') == true) {
      globals.currentPage = 'Chat';
      initChat();
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

 _loadNotifications() async {
    var account_Id = await SessionManager().get('account_Id');
    var data = {
      'version': globals.version,
      'account_Id': account_Id,
    };
    var res = await CallApi().postData(data, 'Notification/(Control)countNotifications.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    if (body[0] == "success") {
      setState((){
        _notifNBR = int.parse(body[1][0]);
        _profilePath=body[1][1];
      });}

  }
  void _onNotifTap() {
    setState(() {
      _notifNBR = 0;
    });
  }
}
