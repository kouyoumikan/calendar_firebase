import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/auth.dart';
import 'package:flutter_firebase/model/authenticate.dart';
import 'package:flutter_firebase/model/constants.dart';
import 'package:flutter_firebase/model/datebase.dart';
import 'package:flutter_firebase/model/helperfunctions.dart';
import 'package:flutter_firebase/model/widget.dart';
import 'package:flutter_firebase/pages/chatPage/Conversation.dart';
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

  DatebaseMethods databaseMethods = DatebaseMethods(); // DatabaseMethodsをimportする

  late Stream chatRoomsStream; // チャットルームの文字列をチェックする設定

  // チャットルームのリスト設定
  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream, // chatRoomsStreamを呼び出す
      builder: (context, snapshot) {
        // タイルにユーザー名データを取得できているか判定(nullの場合はContainer()に移動してタイルにユーザー名を表示しない)
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            return ChatRoomsTile( // ChatRoomsTile関数の呼び出し
              // ChatRoomコレクション内にあるusersコレクションのchatroomIdフィールドのデータを取得
              snapshot.data!.documents[index].data["chatroomId"].toString()
                  .replaceAll("_", "").replaceAll(Constants.myName, ""), // アンダースコアの前のユーザー名は表示しない設定
              snapshot.data!.documents[index].data["chatroomId"], // チャットルームIdのデータを取得
            );
          },
        ) : Container();
      },
    );
  }

  @override
  void initState() { // 画面の初期起動時に実行する
    getUserInfo(); // サインアップで登録したユーザーデータを取得する
    super.initState();
  }

  getUserInfo() async {

    // Cloud FireStore内のユーザー名を取得する(サインアップで登録したデータを取得して使用)
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;

    databaseMethods.getChatRooms(Constants.myName).then((value) { // チャットルームのログインユーザー名を取得する

      setState(() { // データを更新する
        chatRoomsStream = value; // チャットルームのログインユーザー名をチェックするchatMessagesStreamの値を取得
      });
    });

    setState(() {
    });
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
      body: chatRoomList(), // ChatRoomsList関数の呼び出し
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

/*
*    チャットルームで表示するユーザー名のタイルリストの設定
* */

class ChatRoomsTile extends StatelessWidget {

  final String userName; // チャットルームで表示するユーザー名の変数設定
  final String chatRoomId; // チャットルームIdの変数設定
  ChatRoomsTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector( //タッチ検出をしたい親Widgetで使用し、PrimaryとSecondaryの2つのボタン入力をサポート
      onTap: () {
        Navigator.push(context, MaterialPageRoute ( // Conversationをimportする
            builder: (context) => Conversation(chatRoomId),
        ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center, // ボタンを画面中央の位置に設定
              decoration: BoxDecoration( // タイル内にボックス作成
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: mediaTextStyle(),
              ),
            ),
            SizedBox(width: 8,), // タイルリスト下のスペース作成
            Text(
              userName,
              style: mediaTextStyle(),
            ), // チャットルームで表示するユーザー名のテキスト表示
          ],
        ),
      ),
    );
  }
}
