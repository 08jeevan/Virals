import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      accentColor: Color(0xff3a0ca3),
      dialogTheme: isDarkTheme
          ? DialogTheme(backgroundColor: Color(0xFF151515))
          : DialogTheme(backgroundColor: Colors.white),
      textTheme: isDarkTheme
          ? Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )
          : Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
                displayColor: Colors.black,
              ),
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      cardTheme: isDarkTheme
          ? CardTheme(
              color: Color(0xff3B3B3B),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            )
          : CardTheme(
              color: Colors.white,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: isDarkTheme
          ? AppBarTheme(
              elevation: 0.0,
              color: Color(0xFF303030),
            )
          : AppBarTheme(
              elevation: 0.0,
              color: Color(0xfffafafa),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
      tabBarTheme: isDarkTheme
          ? TabBarTheme(
              unselectedLabelColor: Colors.grey.withOpacity(0.9),
              labelColor: Colors.white,
            )
          : TabBarTheme(
              unselectedLabelColor: Colors.grey.withOpacity(0.9),
              labelColor: Colors.black,
            ),
    );
  }
}
