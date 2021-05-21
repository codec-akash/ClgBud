import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData dark = ThemeData(
  primaryColor: Color(0xff94A4B4),
  accentColor: Color(0xff50C2C9),
  backgroundColor: Color(0xff94A4B4),
  textTheme: GoogleFonts.anticSlabTextTheme().apply(displayColor: Colors.black),
);

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green[400],
  accentColor: Colors.deepOrangeAccent,
  backgroundColor: Colors.blue[200],
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  SharedPreferences prefs;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _savePrefs();
    notifyListeners();
  }

  initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _savePrefs() async {
    await initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
