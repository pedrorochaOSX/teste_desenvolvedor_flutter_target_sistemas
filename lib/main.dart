import 'package:flutter/material.dart';

// Dependencies
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

// Files
import 'package:teste_desenvolvedor_flutter_target_sistemas/ui/theme_provider.dart';

// Pages
import 'package:teste_desenvolvedor_flutter_target_sistemas/ui/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadSettings();

  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final Brightness systemBrightness =
        MediaQuery.of(context).platformBrightness;

    ThemeData appTheme;
    if (systemBrightness == Brightness.dark) {
      appTheme = MyThemes.darkTheme;
    } else {
      appTheme = MyThemes.lightTheme;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: systemBrightness == Brightness.dark
          ? MyThemes.darkTheme.colorScheme.background
          : MyThemes.lightTheme.colorScheme.background,
      statusBarIconBrightness: systemBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarColor: systemBrightness == Brightness.dark
          ? MyThemes.darkTheme.colorScheme.background
          : MyThemes.lightTheme.colorScheme.background,
      systemNavigationBarIconBrightness: systemBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: appTheme,
      darkTheme: MyThemes.darkTheme,
      home: LoginPage(),
    );
  }
}