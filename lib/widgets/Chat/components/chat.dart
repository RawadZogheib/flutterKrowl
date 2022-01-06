import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/widgets/Chat/modules/chat_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:stream_chat/stream_chat.dart';
var client;
var channel;
class ChatUsersList extends StatefulWidget{
  String text;
  String secondaryText;
  String image;
  String time;
  bool isMessageRead;
  ChatUsersList({required this.text,required this.secondaryText,required this.image,required this.time,required this.isMessageRead});
  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){




        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatDetailPage();
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.image),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.text),
                          SizedBox(height: 6,),
                          Text(widget.secondaryText,style: TextStyle(fontSize: 14,color: Colors.grey.shade500),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.time,style: TextStyle(fontSize: 12,color: widget.isMessageRead?Colors.blue.shade900:Colors.grey.shade500),),
          ],
        ),
      ),
    );
  }
  initChat() async {

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userTokenChat;
    var usernameChat;
    var data = {'version': globals.version, 'user_id': 1};

    var res = await CallApi().postData(data, '(Control)generateTokenChat.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    try {
      localStorage.setString('token', body[1]);
    } catch (e) {
      print('no token found');
    }
    if (body[0] == "success") {
      userTokenChat = body[2];
      usernameChat = body[3];

      const apiKey = "z5j34vkctqrq";
      //const userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiUmF3YWQifQ.zY0MNdMd9huVSk_eIqfMvoYVGA0urn-hpwKPbafYrjg"; //should be sent by the server
      var userToken = userTokenChat;
      //should be sent by the server
      print("ddddddddddddddddddddddddd" + userToken);

      client = StreamChatClient(apiKey, logLevel: Level.INFO);

      await client.connectUser(
        User(
          id: usernameChat,
          //name: 'Cool Shadow',
          // image:
          // 'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
        ),
        userToken,
      );

      channel = client.channel('messaging', id: 'godevs');

      await channel.watch();
    } else if (body[0] == "errorVersion") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              "Your version: " + globals.version + "\n" + globals.errorVersion),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "errorToken") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.errorToken),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "error7") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.error7),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
