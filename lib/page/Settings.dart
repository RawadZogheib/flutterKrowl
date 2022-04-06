import 'package:Krowl/widgets/Settings/SettingsContainer.dart';
import 'package:flutter/material.dart';
import '../widgets/TabBar/CustomTabBar.dart';



void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Settings()));

class Settings extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  String _firstName = "Clara";
  String _lastName = "Zeidan";
  String _username = "ClaraZ1";
  String _emailAddress = "Clarazeidan@outlook.com";
  String _bio = "Graduated from McGill University. Currently working as a software engineer for Le Wagon - Co-founder of Krowl";
  // String _firstName = "Clara";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 130,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SettingsContainer(FirstName: _firstName, LastName: _lastName, Username: _username, EmailAddress: _emailAddress, Bio: _bio,)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                CustomTabBar(color: Colors.black,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
