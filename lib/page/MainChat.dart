
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Chat/components/streamChatContacts.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
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


  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    super.dispose();
    await client.disconnectUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initChat();
    globals.currentPage = 'Chat';
  }

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    StreamExampleTest(client: client),
    // ChatPage(),
    ChatPage2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Stack(
          children: [
            Center(
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
          ],
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  initChat() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var usernameChat = localStorage.getString("username");
    var userToken = localStorage.getString("userTokenChat");
    print("ddddddddddddddddddddddddd" + userToken.toString());

     await client.connectUser(
          User(
            id: usernameChat.toString(),
              extraData: {
                "name": usernameChat,
                // image:
                // 'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
              }
          ),
          userToken.toString(),
        )
        .then((value) => {
              setState(() {
                initBool = true;
              })
            });
  }
}
