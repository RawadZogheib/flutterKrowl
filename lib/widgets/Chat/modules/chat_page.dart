import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Chat/components/chat.dart';
import 'package:flutter_app_backend/widgets/Chat/components/streamChatFriends.dart';
import 'package:flutter_app_backend/widgets/Chat/models/chat_users.dart';
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat/stream_chat.dart';

class ChatPage2 extends StatefulWidget {
  @override
  _ChatPage2State createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
  var client;
  var channel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Chats",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                      EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: globals.blue2,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: globals.blue1,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "New",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: globals.children2.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatUsersList(
                  id: globals.children2[index].account_Id,
                  text: globals.children2[index].text,
                  secondaryText: globals.children2[index].secondaryText,
                  image: globals.children2[index].image,
                  time: globals.children2[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                  ontap: () =>
                      _goToChat(
                        globals.children2[index].friendShipId,
                        globals.children2[index].text,
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _loadFriends() async {
    globals.children2.clear();

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var account_Id = localStorage.getString("account_Id");

    var data = {
      'version': globals.version,
      'account_Id': account_Id,
    };

    var res = await CallApi().postData(data, '(Control)loadFriends.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

    if (body[0] == "success") {
      for (var i = 0; i < body[1].length; i++) {
        globals.children2.add(
          ChatUsers(
              text: body[1][i][1],
              secondaryText: "will update you in evening",
              image: "Assets/userImage6.jpeg",
              time: "17 Mar",
              account_Id: body[1][i][0],
              friendShipId: body[1][i][2]),
        );
      };
      if (mounted) {
        setState(() {
          globals.children2;
        });
      }
    } else if (body[0] == "empty") {
      WarningPopup(context, globals.warningEmptyFriends);
    } else if (body[0] == "errorVersion") {
      ErrorPopup(context, globals.errorVersion);
    } else if (body[0] == "errorToken") {
      ErrorPopup(context, globals.errorToken);
    } else if (body[0] == "error7") {
      WarningPopup(context, globals.warning7);
    }
  }

  _goToChat(var channelId, var channelName) async {
    await initChat(channelId,channelName);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StreamExample(
              client: client,
              channel: channel,
              //name: channelName,
            ),
      ),
    );
  }

  initChat(var channelId,var channelName) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var usernameChat = localStorage.getString("username");
    var userToken = localStorage.getString("userTokenChat");
    print("ddddddddddddddddddddddddd" + userToken.toString());

    client = StreamChatClient(globals.apiKey, logLevel: Level.INFO);
    await client.connectUser(
      User(
        id: usernameChat.toString(),
     extraData: {
       "name": usernameChat,
       // image:
       // 'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
     }
      ),
      userToken,
    );

    channel = client.channel('messaging',
      extraData: {
      "members": [usernameChat,channelName],
    },);
    await channel.watch();
  }

}