import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import '../hexColor/hexColor.dart';
Color type1 = HexColor('#dfe2e6');
Color type2 = HexColor('#dfe2e6');
Color type3 = HexColor('#dfe2e6');

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Test()));

class Test extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 6.0,
                  left: 3.0,
                  right: 3.0,
                  bottom: 3.0),
              child: myBtn2(
                height: 25,
                width: 150,
                color1: type1,

                color2: Colors.black,
                btnText: const Text(
                  'RED',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                onPress: () {
                  _cleanColorType();
                  if (mounted) {
                    setState(() {
                      type1 = globals.blue1;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: myBtn2(
                height: 25,
                width: 150,
                color1: type2,
                color2: Colors.black,
                btnText: const Text(
                  'YELLOW',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                onPress: () {
                  _cleanColorType();
                  if (mounted) {
                    setState(() {
                      type2 = Colors.yellowAccent;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: myBtn2(
                height: 25,
                width: 150,
                color1: type3,
                color2: Colors.black,
                btnText: const Text(
                  'GREEN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                onPress: () {
                  _cleanColorType();
                  if (mounted) {
                    setState(() {
                      type3 = Colors.yellowAccent;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  _cleanColorType() {
    if (mounted) {
      setState(() {
        type1 = HexColor('#dfe2e6');
        type2 = HexColor('#dfe2e6');
        type3 = HexColor('#dfe2e6');
      });
    }
  }
}
class myBtn2 extends StatelessWidget {
  var btnText;
  double? height;
  double? width;
  var onPress;
  var color1,color2;

  myBtn2({this.btnText, this.height, this.width, this.onPress, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color1,
          onPrimary: color2,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: btnText,
        onPressed: () {
          onPress();
          //print("Submitted2");
        },
      ),
    );
  }
}
