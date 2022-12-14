import 'package:flutter/material.dart';

class LighTheme {
  final _lightColor = _LightColor();

  late ThemeData theme;

  LighTheme() {
    theme = ThemeData(
        cardTheme: CardTheme(
          color: _lightColor.yellow,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          //foregroundColor: Colors.black12,
          backgroundColor: Colors.black,
          primary: Colors.green,
        )),
        appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: const TextStyle().copyWith(fontSize: 22, color: _lightColor.mint),
            shadowColor: _lightColor.hotPink,
            color: _lightColor.hotPink,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)))),
        scaffoldBackgroundColor: _lightColor.hotPink.withOpacity(0.7),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: _lightColor.hotPink),
        buttonTheme: ButtonThemeData(colorScheme: ColorScheme.light(onPrimary: Colors.purple, onSecondary: _lightColor.blueMenia)),
        colorScheme: const ColorScheme.light(),
        checkboxTheme: CheckboxThemeData(fillColor: MaterialStateProperty.all(Colors.green), side: const BorderSide(color: Colors.green)),
        textTheme: ThemeData.light().textTheme.copyWith(subtitle1: TextStyle(fontSize: 20, color: _lightColor._textColor)));
  }
}

class _LightColor {
  final Color _textColor = Color.fromARGB(255, 0, 0, 0);
  final Color blueMenia = const Color.fromARGB(95, 188, 248, 1);
  final Color hotPink = Color.fromARGB(255, 255, 11, 255);
  final Color mint = const Color(0xFFB4F8C8);
  final Color tiffanyBlue = const Color(0xFFBA9B8E);
  final Color yellow = const Color(0xFFFBE7C6);
}
