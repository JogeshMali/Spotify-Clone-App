import 'package:flutter/material.dart';
import 'package:spotify/core/configs/theme/app_color.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      primaryColor: Appcolor.primary,
      scaffoldBackgroundColor: Appcolor.lightBackground,
      fontFamily: 'Satoshi',
      brightness: Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(20),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black,width: 1)
          ),
          enabledBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black,width: 1)
          ),
          focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black,width: 1)
          ),
          hintStyle: TextStyle(fontSize: 18,color:Color(0xff383838) ,fontWeight: FontWeight.w500)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.primary,
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))));

  static final darkTheme = ThemeData(
      primaryColor: Appcolor.primary,
      scaffoldBackgroundColor: Appcolor.darkbackground,
      fontFamily: 'Satoshi',
      brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white,width: 1)
        ),
        enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white,width: 1)
        ),
        focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white,width: 1)
        ),
        hintStyle: TextStyle(fontSize: 18,color: Color(0xffA7A7A7),fontWeight: FontWeight.w500)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.primary,
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))));
}
