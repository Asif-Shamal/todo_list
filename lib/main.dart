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
    return MaterialApp(
      title: 'Flutter Demo',
      home: const HomePage(),
    );
  }
}
