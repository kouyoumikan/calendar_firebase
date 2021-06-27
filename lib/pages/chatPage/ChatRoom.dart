import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/auth.dart';
import 'package:flutter_firebase/model/authenticate.dart';
import 'package:flutter_firebase/model/constants.dart';
import 'package:flutter_firebase/model/helperfunctions.dart';
import 'package:flutter_firebase/pages/chatPage/search.dart';
import 'package:flutter_firebase/pages/chatPage/sign_in.dart';

/*
*    チャットルーム画面
* */

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = AuthMethods(); // AuthMethodsをimportする

  @override
  void initState() { // 画面の初期起動時に実行する
    getUserInfo(); // サインアップで登録したユーザーデータを取得する
    super.initState();
  }

  getUserInfo() async {
    // Cloud Firestore内のユーザー名を取得する(サインアップで登録したデータを取得して使用)
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Image.asset(
////          "assets/images/logo.png", // アプリバーのロゴ画像
////          height: 40,
////        ),
        actions: [
          GestureDetector( //タッチ検出をしたい親Widgetで使用し、PrimaryとSecondaryの2つのボタン入力をサポート
            onTap: () {
              //authMethods.signOut(); // ユーザのログイン状態でサインアウトするかを判定
              // チャットルーム画面のユーザーがサインインしているか
              Navigator.pushReplacement(
                  context, MaterialPageRoute ( // Authenticateをimportする
                      //builder: (context) => SignIn();
                      builder: (context) => Authenticate()
                  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search), // ユーザー名を検索するボタン
        onPressed: () {
          // チャットルーム画面にチャットルーム画面のユーザー名を検索する
          Navigator.pushReplacement(
              context, MaterialPageRoute ( // Searchをimportする
              builder: (context) => Search()
          ));
        },
      ),
    );
  }
}
