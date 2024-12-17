// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_list/sidebar.dart';

// class Setting extends StatelessWidget {
//   const Setting({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Settings"),
//         ),
//         drawer: Sidebar(),
//         body: Text("data"));
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/theme_provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch the theme provider
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: themeProvider.isDarkMode,
            onChanged: (bool value) {
              themeProvider.toggleTheme();
            },
            secondary: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ],
      ),
    );
  }
}
