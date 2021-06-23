import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/chatPage/sign_up.dart';
import 'package:flutter_firebase/pages/chatPage/signin.dart';

class ChatHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatHome Sample',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E), // アプリの基本色
        scaffoldBackgroundColor: Color(0xff1F1F1F), // ScaffoldWidgetの背景色
        accentColor: Color(0xff007EF4), // アクセントカラー
        fontFamily: "OverpassRegular",
        // デスクトッププラットフォームの場合はコントロールが小さくなり、モバイルプラットフォームより密度が高くなる
        visualDensity: VisualDensity.adaptivePlatformDensity, // 視覚的な詰まり具合(密度)を調整
      ),
      //home: SignIn(),
      home: SignUp(),
    );
  }
}
