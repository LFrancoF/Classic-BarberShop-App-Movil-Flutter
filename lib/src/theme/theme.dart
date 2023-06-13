import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{
  
  bool _darkTheme = false;
  bool _customTheme = false;

  final ThemeData _lightThemeCustomed = ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            color: Colors.indigo
          ),
          primaryColor: Colors.indigo
        );

  final ThemeData _darkThemeCustomed = ThemeData.dark().copyWith(
    primaryColor: const Color.fromARGB(255, 248, 139, 37),
    primaryColorLight: Colors.white,
    appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 1, 1, 27)),
    scaffoldBackgroundColor:const Color(0xff16202B),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white)
    )
  );

  ThemeData _currentTheme = ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            color: Colors.indigo
          ),
          primaryColor: Colors.indigo
        );

  bool get darkTheme => _darkTheme;
  bool get customTheme => _customTheme;
  ThemeData get currentTheme => _currentTheme;

  ThemeChanger(int theme){
    switch (theme) {
      case 1: //light
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = _lightThemeCustomed;
      break;

      case 2: //dark
        _darkTheme = true;
        _customTheme = false;
        _currentTheme = _darkThemeCustomed;
      break;

      case 3: //custom
        _darkTheme = false;
        _customTheme = true;
      break;

      default:
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = _lightThemeCustomed;
    }
  }

  set darkTheme(bool value){
    _customTheme = false;
    _darkTheme = value;
    if (value) {
      _currentTheme = _darkThemeCustomed;
    }else{
      _currentTheme = _lightThemeCustomed;
    }
    notifyListeners();
  }

  set customTheme(bool value){
    _customTheme = value;
    _darkTheme = false;
    if (value) {
      _currentTheme = _lightThemeCustomed;
    }else{
      _currentTheme = _lightThemeCustomed;
    }
    notifyListeners();
  }

}