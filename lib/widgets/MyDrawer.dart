import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/hexColor/hexColor.dart';
import 'package:Krowl/widgets/MyCustomScrollBehavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Students/StudentProfile/MyProfile.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 700 &&
        Scaffold.of(context).isDrawerOpen) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        //Scaffold.of(context).closeDrawer();
      });
    }
    return MediaQuery.of(context).size.width < 700
        ? Drawer(
            child: Material(
              color: HexColor('#002756'), //globals.blue1,
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Image.asset(
                            'Assets/krowl_logo.gif',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            const SearchFieldDrawer(),
                            const SizedBox(height: 12),
                            MenuItem(
                              text: 'Library',
                              icon: Icons.menu_book,
                              color: Colors.white,
                              onClicked: () => selectedItem(context, 0),
                            ),
                            const SizedBox(height: 5),
                            MenuItem(
                              text: 'Chat',
                              icon: Icons.message_outlined,
                              color: Colors.white,
                              onClicked: () => selectedItem(context, 1),
                            ),
                            const SizedBox(height: 5),
                            MenuItem(
                              text: 'Forum',
                              icon: Icons.forum_outlined,
                              color: Colors.white,
                              onClicked: () => selectedItem(context, 2),
                            ),
                            const SizedBox(height: 5),
                            MenuItem(
                              text: 'Students',
                              icon: Icons.people,
                              color: Colors.white,
                              onClicked: () => selectedItem(context, 3),
                            ),
                            const SizedBox(height: 5),
                            MenuItem(
                              text: 'Reminders',
                              icon: Icons.alarm,
                              color: Colors.white,
                              onClicked: () => selectedItem(context, 4),
                            ),
                            const SizedBox(height: 8),
                            const Divider(color: Colors.white),
                            const SizedBox(height: 8),
                            MenuItem(
                              text: 'Notifications',
                              icon: Icons.notifications_outlined,
                              color: globals.white,
                              onClicked: () => selectedItem(context, 5),
                            ),
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
    }

                            ),

                            MenuItem(
                              text: 'Settings',
                              icon: Icons.settings,
                              color: globals.white,
                              onClicked: () => selectedItem(context, 6),
                            ),
                            MenuItem(
                              text: 'Logout',
                              icon: Icons.logout,
                              color: globals.white,
                              onClicked: () => selectedItem(context, 7),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0: // Library
        if (globals.currentPage != 'Library') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/Library', (route) => false);
        }
        break;
      case 1: // Chat
        if (globals.currentPage != 'Chat') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/MainChat', (route) => false);
        }
        break;
      case 2: // Forum
        if (globals.currentPage != 'Forum') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/Forum1', (route) => false);
        }
        break;
      case 3: // Students
        if (globals.currentPage != 'Students') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/Students1', (route) => false);
        }
        break;
      case 4: // Reminders
        if (globals.currentPage != 'Reminders') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/Reminders', (route) => false);
        }
        break;
      case 5: // Notifications
        if (globals.currentPage != 'Notifications') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/Notifications', (route) => false);
        }
        break;
      case 6: // Settings
        if (globals.currentPage != 'Settings') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/Settings', (route) => false);
        }
        print('6');
        break;
      case 7: // Logout
        _logout();
        Navigator.pushNamedAndRemoveUntil(
            context, '/intro_page', (route) => false);
        print('7');
        break;
      case 8: // My Profile
        if (globals.currentPage != 'MyProfile') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/Test', (route) => false);
        }
        print('0');
        break;
    }
  }

  Future<void> _logout() async {
    if (await SessionManager().get('rememberMe') == true) {
      SharedPreferences localStorage =
      await SharedPreferences.getInstance();
      String _email = (await localStorage.getString('email')).toString();
      String _password =
      (await localStorage.getString('password')).toString();

      await SessionManager().destroy();

      if (_email.toUpperCase() != 'NULL' &&
          _password.toUpperCase() != 'NULL') {
        SharedPreferences localStorage =
        await SharedPreferences.getInstance();
        await localStorage.setString('email', _email);
        await localStorage.setString('password', _password);
      }
    } else {
      await SessionManager().destroy();
    }
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

class SearchFieldDrawer extends StatelessWidget {
  const SearchFieldDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    return TextField(
      style: const TextStyle(color: color, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(
          Icons.search,
          color: color,
          size: 20,
        ),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }
}
