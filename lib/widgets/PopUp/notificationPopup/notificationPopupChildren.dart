import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;

class NotificationPopupChildren extends StatefulWidget {
  const NotificationPopupChildren({Key? key}) : super(key: key);

  @override
  _NotificationPopupChildrenState createState() =>
      _NotificationPopupChildrenState();
}

class _NotificationPopupChildrenState extends State<NotificationPopupChildren> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {print('aaaaaa');}, // onTapDown
      onPointerUp: (_) {print('fffffff');}, // onTapUp
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: globals.blue1,
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
        ),
      ),
    );
  }
}
