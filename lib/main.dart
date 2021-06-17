import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'View/ToDoList_View.dart';

void main() {
  //Now we use SystemChrome

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDoList',
      theme: ThemeData( //ADADAD
        primaryColor: Color(0xFF2643C4), //1
        primaryColorLight: Colors.white, //2
        primaryColorDark: Color(0xFFE6FFFB), //3
        backgroundColor: Color(0xFFF4F6FD), //4
        splashColor: Colors.white, //5
        errorColor: Color(0xFFFF6272), //6
        cardColor: Colors.white, //7
        accentColor: Colors.white, //8
        buttonColor: Color(0xFFE6FFFB), //9
        focusColor: Color(0xFF979DB0), //10

        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF000000), //11
          focusColor: Color(0xFF020417),//12

          hoverColor: Color(0xFFF4F6FD),

                                                                ),
        canvasColor: Color(0xFFF53948),//13
        dividerColor: Color(0xFF9D9AFF),//14
        bottomAppBarColor:Color(0xFF707070),//15



        primaryColorBrightness: Brightness.light,



      ),
      darkTheme: ThemeData(
        primaryColor: Color(0xFF93A1E2), //1
        primaryColorLight: Color(0x17FFFFFF), //2
        primaryColorDark: Color(0xFF121212), //3
        backgroundColor: Color(0xFF121212), //4
        //primarySwatch: Colors.black, //5
        splashColor: Colors.black,
        errorColor: Color(0xFFFF4A5D), //6
        cardColor: Color(0xFF121212), //7
        accentColor: Color(0x1FFFFFFF), //8
        buttonColor: Color(0x12FFFFFF), //9
        focusColor: Color(0xFFE6FFFB), //10

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFADADAD), //11
          focusColor: Color(0xDEFFFFFF),//12
          hoverColor: Color(0xFF262626),

        ),
        canvasColor: Color(0xFFF99FA6),//13
        dividerColor: Color(0xFFB5B3FF),//14
        bottomAppBarColor:Color(0x99FFFFFF),//15



        primaryColorBrightness: Brightness.dark,



      ),
      themeMode: ThemeMode.system,
      home: Home(),
    );
  }
}
