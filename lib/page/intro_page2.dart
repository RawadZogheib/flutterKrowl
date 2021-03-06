
import 'package:flutter/material.dart';
import 'package:Krowl/widgets/Buttons/NextButton.dart';
import 'package:sizer/sizer.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Intro2()));

class Intro2 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Intro2> createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.blue[900],
        body: Container(
          margin: EdgeInsets.all(25.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'all done :)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Rubik',
                    fontSize: 72,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25),
                alignment: Alignment.center,
                child: Text(
                  'Welcome to Krowl',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Rubik',
                    fontSize: 72,
                  ),
                ),
              ),


              /*
              InkWell(//For Test Only   (add:     $json = file_get_contents('php://input');
                                               // $data = json_decode($json);
                                     //  to the php file "(Control)tokenCheck.php")
                child: Container(
                  child: Text(
                    "test",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                onTap: () async {
                  SharedPreferences localStorage =
                      await SharedPreferences.getInstance();

                  var data = {'account_Id': 69};

                  var res =
                      await CallApi().postData(data, '(Control)tokenCheck.php');
                  print(res.body);
                  List<dynamic> body = json.decode(res.body);
                  if (body[0] == "true") {
                    SharedPreferences localStorage =
                        await SharedPreferences.getInstance();
                    localStorage.setString('token', body[1]);
                    print(body[1]);
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
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text(globals.errorElse),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
               */




              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70,
                        margin: EdgeInsets.only(left: 100.sp),
                        child: InkWell(
                            child: NextButton(
                          text: "next",
                          color: Colors.white,
                          icon: Icons.arrow_forward,
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/intro_page', (route) => false);
                          },
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
