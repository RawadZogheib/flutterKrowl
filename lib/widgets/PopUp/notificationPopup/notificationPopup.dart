import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/PopUp/notificationPopup/notificationPopupChildren.dart';

class ShapedWidget extends StatelessWidget {
  ShapedWidget({this.onlyTop = false});

  final double padding = 4.0;
  final bool onlyTop;

  @override
  Widget build(BuildContext context) {
    return Center(
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
            padding: EdgeInsets.all(padding).copyWith(bottom: padding * 2),
            child: onlyTop
                ? SizedBox(
                    width: 250.0,
                    height: 400.0,
                  )
                : SizedBox(
                    width: 250.0,
                    height: 400.0,
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          NotificationPopupChildren(),
                          NotificationPopupChildren(),
                          NotificationPopupChildren(),
                          NotificationPopupChildren(),
                          NotificationPopupChildren(),
                          NotificationPopupChildren(),
                        ],
                      ),
                    ),
                  ),
          )),
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
