/*
*    テーマカラーの切り替え　ライト/ダーク
* */

import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme(); // 現在のテーマモードの設定

class CustomTheme with ChangeNotifier { // テーマカラーの切り替え
  //static bool _isDarkTheme = false; // 初期値はライトテーマにフラグ設定
  static bool _isDarkTheme = true; // 初期値はダークテーマにフラグ設定

  // ThemeModeがライト/ダークか判定し、falseの時にダークテーマに設定
  ThemeMode get currentTheme =>
      _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() { // ThemeModeの値の変更
    _isDarkTheme = !_isDarkTheme; // ダークテーマが等しいか判定
    notifyListeners(); // テーマカラーの変更の知らせを受け取る
  }

  // ライトテーマの静的オブジェクト
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.lightBlue, // アプリの基本色は明るい青
      accentColor: Colors.deepPurple, // アクセントカラーは緑
      backgroundColor: Colors.white, // アプリの背景色は白
      scaffoldBackgroundColor: Colors.white, // Scaffold Widgetの背景色は白
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black), // ヘッダー色1
        headline2: TextStyle(color: Colors.black), // ヘッダー色2
        bodyText1: TextStyle(color: Colors.black), // body本文のテキスト1
        bodyText2: TextStyle(color: Colors.black), // body本文のテキスト2
      ),
    ); // ライトテーマのデータを返す
  }

  // ダークテーマの静的オブジェクト
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.black, // アプリの基本色は明るい青
      accentColor: Colors.red, // アクセントカラーは赤
      backgroundColor: Colors.grey, // アプリの背景色は白
      scaffoldBackgroundColor: Colors.grey, // Scaffold Widgetの背景色は白
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white), // ヘッダー色1
        headline2: TextStyle(color: Colors.white), // ヘッダー色2
        bodyText1: TextStyle(color: Colors.white), // body本文のテキスト1
        bodyText2: TextStyle(color: Colors.white), // body本文のテキスト2
      ),
    ); // ダークテーマのデータを返す
  }
}