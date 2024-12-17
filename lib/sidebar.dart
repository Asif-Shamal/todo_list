import 'package:flutter/material.dart';
import 'package:todo_list/pages/home_page.dart';
import 'package:todo_list/pages/settings.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Tasks'),
            onTap: () {
              // Close the drawer and navigate to the Home screen
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Close the drawer and navigate to the Settings screen
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ));
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Close the drawer and navigate to the Profile screen
              Navigator.pop(context);
              // You can navigate to another page here
            },
          ),
        ],
      ),
    );
  }
}
