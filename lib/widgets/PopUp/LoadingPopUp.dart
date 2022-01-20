import 'package:flutter/material.dart';

LoadingPopUp(context) {
  showDialog<Image>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      content: Container(
        height: 250,
        width: 250,
        child: Column(
          children: [
            Expanded(
              child: Image(
                image: AssetImage('Assets/krowl_logo.png'),
              ),
            ),
            Text("Loading ..."),
          ],
        ),
      ),
    ),
  );
}
