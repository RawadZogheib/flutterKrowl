import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/MyCustomScrollBehavior.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/PopUp/notificationPopup/notificationPopupChildren.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShapedWidget extends StatelessWidget {
  //ShapedWidget();

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
  bool isAdmin;
  List<dynamic> getIdsPrivet = ['', '', '', '', '', '', '', ''];
  List<dynamic> getUsersPrivet = ['', '', '', '', '', '', '', ''];
  List<dynamic> getImgsPrivet = ['', '', '', '', '', '', '', ''];

  ShapedWidget2({
    required this.isAdmin,
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
                  width: 220,
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
                                isAdmin: isAdmin,
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
  bool isAdmin;
  String idsPrivet;
  String usersPrivet;
  String imgsPrivet;

  Member({
    required this.index,
    required this.isAdmin,
    required this.idsPrivet,
    required this.usersPrivet,
    required this.imgsPrivet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isAdmin == true
              ? Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 15),
                  ],
                )
              : SizedBox(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: globals.blue1,
                  backgroundImage: NetworkImage(imgsPrivet),
                  maxRadius: 20,
                ),
              ),
              index == 0
                  ? Positioned(
                      top: -9.5,
                      left: 0,
                      child: RotationTransition(
                        turns: new AlwaysStoppedAnimation(-12 / 360),
                        child: Image.asset(
                          'Assets/crown.PNG',
                          height: 25,
                          width: 25,
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
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class ShapedWidget3 extends StatelessWidget {
  final double padding = 4.0;
  String tableCode;

  ShapedWidget3({
    required this.tableCode,
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
                                Clipboard.setData(
                                        ClipboardData(text: tableCode))
                                    .then((value) {
                                  print('copy');
                                });
                              },
                              child: Text(
                                tableCode,
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
                                        'krowl.dataflow.com.lb:8070/#/?private=' +
                                            tableCode))
                                .then((value) {
                              SuccessPopup(
                                  context, 'Link copied successfully.');
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
                                    fontSize: 15,
                                    color: globals.blue1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'krowl.dataflow.com.lb:8070/#/?private=' +
                                      tableCode,
                                  style: TextStyle(
                                    fontSize: 10,
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
