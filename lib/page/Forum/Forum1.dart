import 'dart:convert';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/Contributors.dart';
import 'package:flutter_app_backend/widgets/Forum/QuestionContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/SearchBar.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Responsive.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Forum1()));

class Forum1 extends StatefulWidget {
  // This widget is the root of your application.
  var children = <Widget>[]; // Posts

  @override
  State<Forum1> createState() => _Forum1State();
}

class _Forum1State extends State<Forum1> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: globals.white,
        body: Responsive(
          mobile: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.center,
              child: Column(),
            ),
          ),
          tablet: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.center,
              child: Column(),
            ),
          ),
          desktop: SingleChildScrollView(
            reverse: true,
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTabBar(),
                ],
              ),
              SizedBox(
                height: 50,
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
                            width: 430,
                          ),
                          AskQuestionButton(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SearchBar(),
                      SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: widget.children, // My Children
                        // children: [
                        //   Question(
                        //     text:
                        //     'Hey everyone! Quick question about COVID and the antibodies. I just read an article stating that even if you have the antibodies, you can still catch a different strain... What do you think about this?',
                        //     val: -32,
                        //   ),
                        //   SizedBox(
                        //     height: 20,
                        //   ),
                        //   Question(
                        //     text:
                        //     'Hey everyone! Quick question about COVID and the antibodies. I just read an article stating that even if you have the antibodies, you can still catch a different strain... What do you think about this?',
                        //     val: 6,
                        //   ),
                        //   SizedBox(
                        //     height: 20,
                        //   ),
                        //   Question(
                        //     text:
                        //     'Hey everyone! Quick question about COVID and the antibodies. I just read an article stating that even if you have the antibodies, you can still catch a different strain... What do you think about this?',
                        //     val: 33,
                        //   ),
                        //   SizedBox(
                        //     height: 20,
                        //   ),
                        //   Question(
                        //     text:
                        //     'Hey everyone! Quick question about COVID and the antibodies. I just read an article stating that even if you have the antibodies, you can still catch a different strain... What do you think about this?',
                        //     val: 22,
                        //   ),
                        //   SizedBox(
                        //     height: 20,
                        //   ),
                        // ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Contributors(),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  Future<void> _loadPosts() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = localStorage.getString("user_id");
    var user_uni = localStorage.getString("user_uni");

    var data = {
      'version': globals.version,
      'user_id': user_id,
      'user_uni': user_uni,
    };

    var res = await CallApi().postData(data, '(Control)loadPosts.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    try {
      localStorage.setString('token', body[1]);
    } catch (e) {
      print('no token found');
    }

    if (body[0] == "success") {
      for (var i = 0; i < body[2].length; i++) {
        widget.children.addAll(
          [
            Question(
              id: body[2][i][0],
              // post_id
              username: body[2][i][1],
              // username
              text: body[2][i][2],
              // post_data
              val: int.parse(body[2][0][3]),
              // post_val
              date: DateTime.parse(body[2][0][4]),
              // post_date
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      }
      setState(() {
        widget.children;
      });
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
    } else if (body[0] == "error11") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.error11),
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
