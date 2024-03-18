import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskland/consts/colors.dart';
import 'package:taskland/consts/font_theme.dart';
import 'package:taskland/screens/home/home_screen.dart';
import 'package:taskland/screens/introduction/welcome_screen.dart';
import 'package:taskland/services/storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskland/services/version_fetching.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await VersionFetchingService.initialize();
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
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isWelcomeScreenPassed =
        StorageService.settingsBox.get("isWelcomeScreenPassed") == true;

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
          elevation: MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(m3SurfaceContainerHigh),
          padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
          surfaceTintColor: MaterialStatePropertyAll(Colors.transparent),
        ),
      ),
      home: isWelcomeScreenPassed ? const HomeScreen() : const WelcomeScreen(),
    );
  }
}
