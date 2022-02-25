import 'package:flutter/material.dart';

LoadingRequestAddUnFriendPopUp(String text, BuildContext context) {
  showDialog<Image>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      content: Container(
        height: 150,
        width: 150,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Image(
                image: AssetImage('Assets/krowl_logo.gif'),
              ),
            ),
            Text(text),
          ],
        ),
      ),
    ),
  );
}
