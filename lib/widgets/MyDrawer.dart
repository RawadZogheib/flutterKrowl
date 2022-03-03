import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/hexColor/hexColor.dart';
import 'package:flutter_app_backend/page/Responsive.dart';

class myDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: Material(
          color: HexColor('#002756'), //globals.blue1,
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
                        text: 'Settings',
                        icon: Icons.settings,
                        color: globals.white,
                        onClicked: () => selectedItem(context, 6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0: // My Courses
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => const Scaffold(), // Page 1
        // ));
        break;
      case 1: // Liked Courses
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => const Scaffold(), // Page 2
        // ));
        break;
      case 2: // Liked Teachers
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => const Scaffold(), // Page 3
        // ));
        break;
      case 3: // Updates
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => const Scaffold(), // Page 4
        // ));
        break;
      case 4: // Notifications
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => const Scaffold(), // Page 5
        // ));
        break;
      case 5: // Settings
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => const Scaffold(), // Page 6
        // ));
        break;
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
