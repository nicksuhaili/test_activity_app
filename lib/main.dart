import 'package:flutter/material.dart';
import 'package:test_activity_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activity App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.teal,
          secondary: Colors.amberAccent,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
