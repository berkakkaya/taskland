import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskland/consts/colors.dart';
import 'package:taskland/consts/font_theme.dart';
import 'package:taskland/screens/introduction/welcome_screen.dart';

void main() {
  Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskland',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
        useMaterial3: true,
        textTheme: fontTheme,
      ),
      home: const WelcomeScreen(),
    );
  }
}
