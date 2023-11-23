import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode? themeMode;

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isDarkTheme = prefs.getBool('isDarkTheme') ?? true;
    prefs.setBool('isDarkTheme', isDarkTheme);
    themeMode = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  // Theme.of(context).colorScheme.<color>

  static final lightTheme = ThemeData(
    fontFamily: "NotoSans",
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff44BE6E), // Button color
      onPrimary: Color(0xff202838), // Textfields color
      secondary: Color(0x85ffffff), // Textfields prefix icon color
      onSecondary: Color(0xffffffff), // Textfields text color
      tertiary: Color(0x85000000), // Textfields hint text color
      onTertiary: Color(0xff000000), // Black color
      error: Color(0xffffffff),
      onError: Color(0xffffffff),
      background: Color(0xff50FFF5), // Background color 1
      onBackground: Color(0xFFffffff), // Background color 2
      surface: Color(0xffffffff), // White color
      onSurface: Color(0xff000000), // Black color
      inverseSurface: Color(0xffffffff), // White color
      onInverseSurface: Color(0xff000000), // Black color
    ),
  );

  static final darkTheme = ThemeData( 
    fontFamily: "NotoSans",
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff44BE6E), // Button color
      onPrimary: Color(0xffffffff), // Texfields color
      secondary: Color(0xff202838), // Textfields prefix icon color
      onSecondary: Color(0xff000000), // Textfields text color
      tertiary: Color(0x85000000), // Textfields hint text color
      onTertiary: Color(0xffffffff), // White color
      error: Color(0xff000000),
      onError: Color(0xff000000),
      background: Color(0xff1E4D61), // Background color 1
      onBackground: Color(0xFF2C958F), // Background color 2
      surface: Color(0xffffffff), // White color
      onSurface: Color(0xff000000), // Black color
      inverseSurface: Color(0xff000000), // Black color
      onInverseSurface: Color(0xffffffff), // White color
    ),
  );
}
