import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/datebase.dart';
import 'package:flutter_firebase/model/widget.dart';

/*
*    チャットルーム画面でユーザー名を検索する
* */

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  DatebaseMethods databaseMethods = DatebaseMethods(); // DatebaseMethodsをimportする
  // ユーザー名を検索するコントローラー設定
  TextEditingController searchTextEditingController = TextEditingController();

  late QuerySnapshot searchSnapshot; // ユーザー検索で表示されるprint(value.toString()の値

  initiateSearch(){ // ユーザー検索をこの内部で実行する
    // Cloud Firestore内のユーザー情報を取得して保存
    databaseMethods.getUsersByUsername(searchTextEditingController.text).then((value){
      //print(value.toString()); // 取得したユーザー情報を印刷してprintに表示する

      setState(() { // データを更新する
        searchSnapshot = value; // ユーザー検索で表示されるprint(value.toString()の値を取得
      });
    });
  }

  Widget searchList() { // ユーザー検索リストを画面に表示する
    return searchSnapshot != null ?  ListView.builder( // searchSnapshotのデータがnull出ないか判定
      //itemCount: searchSnapshot.document.length,
      itemCount: searchSnapshot.docs.length, // ユーザー検索で表示される値のアイテム数を取得
        shrinkWrap: true,
        itemBuilder: (context, index) {
        return SearchTile(
          //userName: searchSnapshot.document[index].data["name"],
          userName: searchSnapshot.docs[index].data["name"],
          //userName: searchSnapshot.document[index].data["email"],
          userEmail: searchSnapshot.docs[index].data["email"],
        );
      }
    ) : Container(); // nullの場合はContainer()のみでリストタイルを表示しない
  }

  @override
  void initState() { // 画面を更新
    //initiateSearch();
    super.initState();
  }

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
            searchList();
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {

  // ユーザー検索で表示されたしたユーザーデータを取得
  final String userName;
  final String userEmail;
  SearchTile({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
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
               // ボタン送信機能でのテキストフォームに入力した文字列の内容を判定
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
}
