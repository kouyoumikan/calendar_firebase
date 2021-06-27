import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/constants.dart';
import 'package:flutter_firebase/model/datebase.dart';
import 'package:flutter_firebase/model/helperfunctions.dart';
import 'package:flutter_firebase/model/widget.dart';
import 'package:flutter_firebase/pages/chatPage/Conversation.dart';

/*
*    チャットルーム画面でユーザー名を検索する
* */

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  late String _myName; // ユーザーがログインした時のユーザー名の設定

  DatebaseMethods databaseMethods = DatebaseMethods(); // DatebaseMethodsをimportする
  // ユーザー名を検索するコントローラー設定
  TextEditingController searchTextEditingController = TextEditingController();

  late QuerySnapshot searchSnapshot; // ユーザー検索で表示されるprint(value.toString()の値

  Widget searchList() { // ユーザー検索リストを画面に表示する
    return searchSnapshot != null ?  ListView.builder( // searchSnapshotのデータがnull出ないか判定
        itemCount: searchSnapshot.documents.length,
        //itemCount: searchSnapshot.docs.length, // ユーザー検索で表示される値のアイテム数を取得
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SearchTile(
            userName: searchSnapshot.documents[index].data["name"],
            //userName: searchSnapshot.docs[index].data["name"],
            userEmail: searchSnapshot.documents[index].data["email"],
            //userEmail: searchSnapshot.docs[index].data["email"],
          );
        }
    ) : Container(); // nullの場合はContainer()のみでリストタイルを表示しない
  }

  initiateSearch(){ // ユーザー検索をこの内部で実行する
    // Cloud Firestore内のユーザー情報を取得して保存
    databaseMethods.getUsersByUsername(searchTextEditingController.text).then((value){
      //print(value.toString()); // 取得したユーザー情報を印刷してprintに表示する

      setState(() { // データを更新する
        searchSnapshot = value; // ユーザー検索で表示されるprint(value.toString()の値を取得
      });
    });
  }

  // チャットルームに遷移時、ユーザーデータを送信中のデータ読み込み中はスキップする
  // 送信するチャットルームを作成して、ユーザーデータを送信する
//  createChatRoomAndStartConverstation(BuildContext context, String userName) {
//
//    String chatRoomId = getChatRoomId(userName, Constants.myName); // getChatRoomIdの呼び出し
//
//    List<String> users = [userName, Constants.myName]; // サインインしたユーザーのチャットデータを取得
//
//    // Cloud Firestore内のChatRoomコレクションデータのユーザ名をチャットルーム画面に提供して使用
//    Map<String, dynamic> chatRoomMap = {
//      "users" : users,
//      "chatroomId" : chatRoomId
//    };
//
//    // ユーザーがアプリを閉じて再ログインした時、アプリに再ログインしてユーザーがログインしていることを確認する
//    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
//    // チャットルームの会話画面に移動する
//    Navigator.push(context, MaterialPageRoute ( // ChatRoomをimportする
//        builder: (context) => Conversation()
//    ));
//  }

  createChatRoomAndStartConverstation({required String userName}) {

    print("${Constants.myName}"); // ログインしたユーザー名データをprintに表示

    if(userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName); // getChatRoomIdの呼び出し

      List<String> users = [userName, Constants.myName]; // サインインしたユーザーのチャットデータを取得

      // Cloud Firestore内のChatRoomコレクションデータのユーザ名をチャットルーム画面に提供して使用
      Map<String, dynamic> chatRoomMap = {
        "users" : users,
        "chatroomId" : chatRoomId
      };

      // ユーザーがアプリを閉じて再ログインした時、アプリに再ログインしてユーザーがログインしていることを確認する
      databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      // チャットルームの会話画面に移動する
      Navigator.push(context, MaterialPageRoute ( // ChatRoomをimportする
          builder: (context) => Conversation()
      ));
    }
    else {
      print("you cannot send message to yourself");
    }
  }

  // 検索結果を表示するリストタイル
  Widget SearchTile({required String userName, required String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( // ユーザーの名前を表示
                userName,
                style: simpleTextStyle(),
              ),
              Text( // ユーザーのメールアドレスを表示
                userEmail,
                style: simpleTextStyle(),
              ),
            ],
          ),
          Spacer(),
          GestureDetector( //タッチ検出をしたい親Widgetで使用し、PrimaryとSecondaryの2つのボタン入力をサポート
            onTap: () {
//              createChatRoomAndStartConverstation(
//                userName :  userName
//              );
            },
            child: Container( // メッセージボタン
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                "Message",
                style: biggerTextStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() { // 画面を更新
    //getUserInfo();
    super.initState();
  }

//  getUserInfo() async {
//    // Cloud FireStore内のユーザー名を取得する(サインアップで登録したデータを取得して使用)
//    _myName = (await HelperFunctions.getUserNameSharedPreference())!;
//    setState(() {
//
//    });
//    print("{$_myName}");
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController, // ユーザー名を検索するコントローラーの設置
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "search username ...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector( //タッチ検出をしたい親Widgetで使用し、PrimaryとSecondaryの2つのボタン入力をサポート
                    onTap: () {
//                      // Cloud Firestore内のユーザー情報を取得して保存
//                      databaseMethods.getUsersByUsername(searchTextEditingController.text).then((value){
//                        print(value.toString()); // 取得したユーザー情報を印刷してprintに表示する
//                      });
                      initiateSearch();
                    },
                    child: Container( // 検索する虫眼鏡アイコン
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0x36FFFFFF),
                            Color(0x0FFFFFFF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Image.asset("assets/images/search_white.png")
                    ),
                  ),
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}

//class SearchTile extends StatelessWidget {
//
//  // ユーザー検索で表示されたしたユーザーデータを取得
//  final String userName;
//  final String userEmail;
//  SearchTile({required this.userName, required this.userEmail});
//
//  @override
//  Widget build(BuildContext context) {
//
//  }
//}

// 取得したChatRoomIdをアンダースコア前後でidを分ける（a_b）
getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}