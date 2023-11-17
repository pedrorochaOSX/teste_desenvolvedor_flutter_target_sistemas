import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode? themeMode;

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    prefs.setBool('isDarkTheme', isDarkTheme);
    themeMode = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }
}

class MyThemes {
  // Theme.of(context).colorScheme.<color>

  static final lightTheme = ThemeData(
    fontFamily: "NotoSans",
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff44BE6E), // Button color
      onPrimary: Color(0xffffffff), // Textfields color
      secondary: Color(0xff202838), // Textfields prefix icon color
      onSecondary: Color(0xff000000), // Textfields text color
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      error: Color(0xffffffff),
      onError: Color(0xffffffff),
      background: Color(0xff2C958F), // Light background color
      onBackground: Color(0xff1E4E62), // Dark background color
      surface: Color(0xffffffff), // White color
      onSurface: Color(0xff000000), // Black color
    ),
  );

  static final darkTheme = ThemeData( 
    fontFamily: "NotoSans",
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff44BE6E), // Button color
      onPrimary: Color(0xff202838), // Texfields color
      secondary: Color(0xffffffff), // Textfields prefix icon color
      onSecondary: Color(0xffffffff), // Textfields text color
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      error: Color(0xff000000),
      onError: Color(0xff000000),
      background: Color(0xff1E4E62), // Dark background color
      onBackground: Color(0xff2C958F), // Light background color
      surface: Color(0xffffffff), // White color
      onSurface: Color(0xff000000), // Black color
    ),
  );
}
