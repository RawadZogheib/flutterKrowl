import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/hexColor/hexColor.dart';
import 'package:Krowl/widgets/MyCustomScrollBehavior.dart';
import 'package:Krowl/widgets/Students/StudentProfile/MyProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShapedWidgetProfile extends StatelessWidget {
  //ShapedWidgetProfile();

  final double padding = 4.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Center(
        child: Material(
            color: HexColor('#002756'),
            //globals.blue1,
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
                height: 350.0,
                child: ScrollConfiguration(
                  behavior: MyCustomScrollBehavior(),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              MenuItem(
                                  text: 'My Profile',
                                  icon: Icons.person,
                                  color: Colors.white,
                                  onClicked: () async {
                                    if (globals.currentPage != 'MyProfile') {
                                      int _account_Id = await SessionManager()
                                          .get('account_Id');
                                      String _username = await SessionManager()
                                          .get('username');
                                      // String _universityName =
                                      //     await SessionManager()
                                      //         .get('universityName');
                                      String _description =
                                          await SessionManager().get('bio').toString();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyProfile(
                                                userId: _account_Id,
                                                username: _username,
                                                universityName: "Savannah College of Art and Design",
                                                description: _description,
                                                profilePath: globals.initialProfilePath),
                                          ));
                                    }
                                  }),
                              const SizedBox(height: 5),
                              MenuItem(
                                text: 'Upgrade Plan',
                                icon: Icons.map_outlined,
                                color: Colors.white,
                                onClicked: () => selectedItem(context, 1),
                              ),
                              const SizedBox(height: 5),
                              MenuItem(
                                text: 'Billing',
                                icon: Icons.payments_outlined,
                                color: Colors.white,
                                onClicked: () => selectedItem(context, 2),
                              ),
                              const SizedBox(height: 5),
                              MenuItem(
                                text: 'Communication',
                                icon: Icons.forum_outlined,
                                color: Colors.white,
                                onClicked: () => selectedItem(context, 3),
                              ),
                              const SizedBox(height: 8),
                              const Divider(color: Colors.white),
                              const SizedBox(height: 8),
                              MenuItem(
                                text: 'Settings',
                                icon: Icons.settings,
                                color: globals.white,
                                onClicked: () => selectedItem(context, 4),
                              ),
                              MenuItem(
                                text: 'Logout',
                                icon: Icons.logout,
                                color: globals.white,
                                onClicked: () => selectedItem(context, 5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  selectedItem(BuildContext context, int index) async {
    switch (index) {
      case 0: // My Profile
        if (globals.currentPage != 'MyProfile') {
          // int _account_Id = await SessionManager().get('account_Id');
          // String _username = await SessionManager().get('username');
          // String _universityName = await SessionManager().get('universityName');
          // String _description = await SessionManager().get('bio');
          // String _profilePath = await SessionManager().get('photo');

          // Navigator.pushNamedAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => MyProfile(
          //           userId: _account_Id,
          //           username: _username,
          //           universityName: _universityName,
          //           description: _description,
          //           profilePath: _profilePath),
          //     ),
          //     (route) => false);
        }
        print('0');
        break;
      case 1: // Upgrade Plan
        // if (globals.currentPage != 'Chat') {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, '/MainChat', (route) => false);
        // }
        print('1');
        break;
      case 2: // Billing
        // if (globals.currentPage != 'Forum') {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, '/Forum1', (route) => false);
        // }
        print('2');
        break;
      case 3: // Communication
        // if (globals.currentPage != 'Students') {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, '/Students1', (route) => false);
        // }
        print('3');
        break;
      case 4: // Settings
        if (globals.currentPage != 'Settings') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/Settings', (route) => false);
        }
        print('4');
        break;
      case 5: // Logout
        _logout();
        Navigator.pushNamedAndRemoveUntil(
            context, '/intro_page', (route) => false);
        print('5');
        break;
    }
  }

  Future<void> _logout() async {
    if (await SessionManager().get('rememberMe') == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      String _email = (await localStorage.getString('email')).toString();
      String _password = (await localStorage.getString('password')).toString();

      await SessionManager().destroy();

      if (_email.toUpperCase() != 'NULL' && _password.toUpperCase() != 'NULL') {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        await localStorage.setString('email', _email);
        await localStorage.setString('password', _password);
      }
    } else {
      await SessionManager().destroy();
    }
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
      ..moveTo(rect.width - 10.3, rect.top)
      ..lineTo(rect.width - 22.25, rect.top - 16.0)
      ..lineTo(rect.width - 33.3, rect.top)
      ..addRRect(borderRadius.resolve(textDirection).toRRect(Rect.fromLTWH(
          rect.left, rect.top, rect.width, rect.height - padding)));
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback? onClicked;

  const MenuItem({
    required this.text,
    required this.icon,
    required this.color,
    this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Color color = globals.whiteBlue;//Colors.white;
    Color hoverColor = Colors.transparent.withOpacity(1); //Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
