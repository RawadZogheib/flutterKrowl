//import 'package:flutter/cupertino.dart'; //CupertinoIcons.checkmark_alt_circle,//Success Icon
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

ErrorPopup(BuildContext context, String? text) {
    if(text == globals.errorToken){
      Navigator.popUntil(context, ModalRoute.withName('/intro_page'));
    MotionToast(
      icon: Icons.error,
      primaryColor: globals.red2,
      secondaryColor: globals.red1,
      toastDuration: Duration(seconds: 3),
      backgroundType: BACKGROUND_TYPE.solid,
      title: Text(
        'Error',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(
        text != null ? text : 'Unexpected Error.',
      ),
      position: MOTION_TOAST_POSITION.bottom,
      animationType: ANIMATION.fromRight,
      height: 100,
    ).show(context);
  }else{
      MotionToast(
        icon: Icons.error,
        primaryColor: globals.red2,
        secondaryColor: globals.red1,
        toastDuration: Duration(seconds: 3),
        backgroundType: BACKGROUND_TYPE.solid,
        title: Text(
          'Error',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        description: Text(
          text != null ? text : 'Unexpected Error.',
        ),
        position: MOTION_TOAST_POSITION.bottom,
        animationType: ANIMATION.fromRight,
        height: 100,
      ).show(context);
    }
}

WarningPopup(BuildContext context, String? text) {
  MotionToast(
    icon: Icons.warning,
    primaryColor: globals.yellow2,
    secondaryColor: globals.yellow1,
    toastDuration: Duration(seconds: 3),
    backgroundType: BACKGROUND_TYPE.solid,
    title: Text(
      'Warning',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(
      text != null ? text : 'Unexpected Warning.',
    ),
    position: MOTION_TOAST_POSITION.bottom,
    animationType: ANIMATION.fromRight,
    height: 100,
  ).show(context);
}