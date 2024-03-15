import 'package:flutter/material.dart';
import 'package:taskland/consts/colors.dart';
import 'package:taskland/consts/font_theme.dart';
import 'package:taskland/screens/introduction/welcome_screen.dart';
import 'package:taskland/services/storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await StorageService.initialize();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskland',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
      ],
      locale: const Locale('tr'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
        useMaterial3: true,
        textTheme: fontTheme,
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        searchBarTheme: const SearchBarThemeData(
          elevation: MaterialStatePropertyAll(4),
          backgroundColor: MaterialStatePropertyAll(m3SurfaceContainerHigh),
          padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
          surfaceTintColor: MaterialStatePropertyAll(Colors.transparent),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
