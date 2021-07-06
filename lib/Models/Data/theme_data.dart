import 'package:flutter/material.dart';

class ThemeDataClass{
  static final ThemeDataClass _singleton = ThemeDataClass._internal();
  factory ThemeDataClass() {
    return _singleton;
  }
  ThemeDataClass._internal();
  ThemeData lightMode(){
    return ThemeData(
      primaryColor: Color(0xFF2643C4),

      primaryColorLight: Colors.white,

      primaryColorDark: Color(0xFFE6FFFB),

      backgroundColor: Color(0xFFF4F6FD),

      splashColor: Colors.white,

      errorColor: Color(0xFFFF6272),

      cardColor: Colors.white,

      accentColor: Colors.white,

      buttonColor: Color(0xFFE6FFFB),

      focusColor: Color(0xFF979DB0),


      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF000000),
        focusColor: Color(0xFF020417),
        foregroundColor:Color(0xFF2643C4),
        hoverColor: Color(0xFFF4F6FD),

      ),
      canvasColor: Color(0xFFF53948),

      dividerColor: Color(0xFF9D9AFF),

      bottomAppBarColor: Color(0xFF707070),

      primaryColorBrightness: Brightness.light,


    );
  }
  ThemeData darkMode(){
    return ThemeData(
      primaryColor: Color(0xFF93A1E2),

      primaryColorLight: Color(0x17FFFFFF),

      primaryColorDark: Color(0xFF121212),

      backgroundColor: Color(0xFF121212),

      splashColor: Colors.black,
      errorColor: Color(0xFFFF4A5D),

      cardColor: Color(0xFF121212),

      accentColor: Color(0x1FFFFFFF),

      buttonColor: Color(0x12FFFFFF),

      focusColor: Color(0xFFE6FFFB),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFADADAD), //11
          focusColor: Color(0xDEFFFFFF), //12
          hoverColor: Color(0xFF262626),
          foregroundColor: Color(0xFF2643C4)

      ),
      canvasColor: Color(0xFFF99FA6),

      dividerColor: Color(0xFFB5B3FF),

      bottomAppBarColor: Color(0x99FFFFFF),

      primaryColorBrightness: Brightness.dark,


    );
  }
}