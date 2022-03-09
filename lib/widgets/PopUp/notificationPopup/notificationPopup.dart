import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/MyCustomScrollBehavior.dart';
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_app_backend/widgets/PopUp/notificationPopup/notificationPopupChildren.dart';

class ShapedWidget extends StatelessWidget {
  ShapedWidget();

  final double padding = 4.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Center(
        child: Material(
            clipBehavior: Clip.antiAlias,
            shape: _ShapedWidgetBorder(
                borderRadius: BorderRadius.all(Radius.circular(padding)),
                padding: padding),
            elevation: 4.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250.0,
                height: 400.0,
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: ListView(
                    controller: ScrollController(),
                    children: [
                      NotificationPopupChildren(),
                      NotificationPopupChildren(),
                      NotificationPopupChildren(),
                      NotificationPopupChildren(),
                      NotificationPopupChildren(),
                      NotificationPopupChildren(),
                      GestureDetector(
                        onTap: () => print('Show More'),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Show More',
                            style: TextStyle(color: globals.blue1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class _ShapedWidgetBorder extends RoundedRectangleBorder {
  _ShapedWidgetBorder({
    required this.padding,
    side = BorderSide.none,
    borderRadius = BorderRadius.zero,
  }) : super(side: side, borderRadius: borderRadius);
  final double padding;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.width - 65.0, rect.top)
      ..lineTo(rect.width - 78.0, rect.top - 16.0)
      ..lineTo(rect.width - 89.0, rect.top)
      ..addRRect(borderRadius.resolve(textDirection).toRRect(Rect.fromLTWH(
          rect.left, rect.top, rect.width, rect.height - padding)));
  }
}

class ShapedWidget2 extends StatelessWidget {
  final double padding = 4.0;

  List<dynamic> getIdsPrivet = ['', '', '', '', '', '', '', ''];
  List<dynamic> getUsersPrivet = ['', '', '', '', '', '', '', ''];
  List<dynamic> getImgsPrivet = ['', '', '', '', '', '', '', ''];

  ShapedWidget2({
    required this.getIdsPrivet,
    required this.getUsersPrivet,
    required this.getImgsPrivet,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Material(
                clipBehavior: Clip.antiAlias,
                elevation: 4.0,
                child: Container(
                  width: 170,
                  height: 300,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: globals.blue1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Table Participants',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: MyCustomScrollBehavior()
                              .copyWith(scrollbars: false),
                          child: ListView.builder(
                            controller: ScrollController(),
                            itemCount: getIdsPrivet.length,
                            itemBuilder: (context, index) {
                              return Member(
                                index: index,
                                idsPrivet: getIdsPrivet[index],
                                usersPrivet: getUsersPrivet[index],
                                imgsPrivet: getImgsPrivet[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class Member extends StatelessWidget {
  int index;
  String idsPrivet;
  String usersPrivet;
  String imgsPrivet;

  Member({
    required this.index,
    required this.idsPrivet,
    required this.usersPrivet,
    required this.imgsPrivet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('aaaaaa');
      }, // onTapUp
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: globals.blue1,
                    backgroundImage: NetworkImage(imgsPrivet),
                    maxRadius: 22,
                  ),
                ),
                index == 0
                    ? Positioned(
                        top: -5,
                        left: 0,
                        child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(-10 / 360),
                          child: Image.asset(
                            'Assets/crown.PNG',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              usersPrivet,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class ShapedWidget3 extends StatelessWidget {
  final double padding = 4.0;
  String tableId;

  ShapedWidget3({
    required this.tableId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Material(
                clipBehavior: Clip.antiAlias,
                elevation: 4.0,
                child: Container(
                  width: 315,
                  height: 200,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: globals.blue1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: ScrollConfiguration(
                    behavior:
                        MyCustomScrollBehavior().copyWith(scrollbars: false),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Table Id: ',
                              style: TextStyle(
                                fontSize: 16,
                                color: globals.blue1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: tableId))
                                    .then((value) {
                                  print('copy');
                                });
                              },
                              child: Text(
                                tableId,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'or',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                    text:
                                        'Krowl.io/addToTable/code=' + tableId))
                                .then((value) {
                              SuccessPopup(context, 'Link copied successfully.');
                              print('copy');
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: globals.blue2,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Link: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: globals.blue1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Krowl.io/addToTable/code=' + tableId,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
