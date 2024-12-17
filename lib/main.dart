import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/home_page.dart';
import 'theme_provider.dart'; // Import the ThemeProvider class

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), // Initialize ThemeProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness:
            themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
        colorScheme:
            themeProvider.isDarkMode ? ColorScheme.dark() : ColorScheme.light(),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
