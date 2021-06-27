import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/authenticate.dart';
import 'package:flutter_firebase/model/helperfunctions.dart';
import 'package:flutter_firebase/pages/chatPage/ChatRoom.dart';
import 'package:flutter_firebase/pages/chatPage/search.dart';
import 'package:flutter_firebase/pages/chatPage/sign_up.dart';
import 'package:flutter_firebase/pages/chatPage/sign_in.dart';

//class ChatHome extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'ChatHome Sample',
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primaryColor: Color(0xff145C9E), // アプリの基本色
//        scaffoldBackgroundColor: Color(0xff1F1F1F), // ScaffoldWidgetの背景色
//        accentColor: Color(0xff007EF4), // アクセントカラー
//        fontFamily: "OverpassRegular",
//        // デスクトッププラットフォームの場合はコントロールが小さくなり、モバイルプラットフォームより密度が高くなる
//        visualDensity: VisualDensity.adaptivePlatformDensity, // 視覚的な詰まり具合(密度)を調整
//      ),
//      //home: SignIn(),
//      home: Authenticate(),
//      //home: Search(),
//    );
//  }
//}

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {

  // ユーザーがログインしているかのフラグ設定 (初期値はログインしていない値にfalseで設定)
  bool userIsLoggedIn = false;

  @override
  void initState() { // 画面を更新
    getLoggedInState(); // ユーザーのログイン状態の確認
    super.initState();
  }

  getLoggedInState() async { // ユーザーのログイン状態の確認
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value!; // ユーザーのログイン状態の値を取得
      });
    });
  }

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
      // ログインしている場合はチャットルームに移動、していない場合はサインイン/アップの認証画面へ移動
        home: userIsLoggedIn ? ChatRoom() : Authenticate(),
//      home: userIsLoggedIn != null ? userIsLoggedIn ? ChatRoom()
//          : Authenticate() : Container(
//        child: Center(
//          child: Authenticate(),
//        ),
//      ),
      //home: Search(),
    );
  }
}

