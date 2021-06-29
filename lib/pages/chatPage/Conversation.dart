import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/constants.dart';
import 'package:flutter_firebase/model/datebase.dart';
import 'package:flutter_firebase/model/widget.dart';

/*
*    チャットルームでのユーザー2人同志の会話画面
* */

class Conversation extends StatefulWidget {
  // チャットルームIDの変数設定
  final String chatRoomId;
  Conversation(this.chatRoomId);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {

  DatebaseMethods databaseMethods = DatebaseMethods(); // DatabaseMethodsをimportする
  // テキストメッセージを送信するコントローラー設定
  TextEditingController messageController = TextEditingController();

  late Stream chatMessagesStream; // メッセージの文字列をチェックする設定

  Widget ChatMessageList() { // チャット画面で表示する会話リストの設定
    return StreamBuilder(
      stream: chatMessagesStream, // メッセージの文字列をチェック
      builder: (context, snapshot) {
        // テキストメッセージを取得できているか判定(nullの場合はContainer()に移動してテキストメッセージを表示しない)
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data!.documents.length,
          itemBuilder: (context, index) {
            return MessageTile( // テキストメッセージ関数の呼び出し
              snapshot.data!.documents[index].data["message"]
            );
          }
        ) : Container();
      }
    );
  }

  sendMessage() { // テキストメッセージを送信する機能

    if(messageController.text.isNotEmpty) { // テキストメッセージが空でないか判定

      Map<String, dynamic> messageMap = { // ChatRoomコレクション内にあるchatsコレクションのフィールドのデータの設定
        "message": messageController.text, // テキストフィールドに入力したメッセージを設定
        "sendBy": Constants.myName, // ログウインしているユーザー名に設定
        "time" : DateTime.now().microsecondsSinceEpoch, // テキストメッセージの表示時間を現在の時刻に設定
      };

      // Cloud FireStore内のユーザー情報を取得して保存
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() { // 画面を更新する(Widget初期化時に最初に一度だけ呼ばれるメソッド)
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      //print(value.toString()); // 取得したユーザー情報を印刷してprintに表示する

      setState(() { // データを更新する
        chatMessagesStream = value; // メッセージの文字列をチェックするchatMessagesStreamの値を取得
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),
      body: Container(
        child: Stack( // ボックスの端を基準にして子を配置するウィジェット(複数の要素を重ねたい場合に使用する)
          children: [
            ChatMessageList(), // チャット画面で表示する会話リストの呼び出し
            Container( // メッセージを入力するボックススペース
              alignment: Alignment.bottomCenter, // ボタンを一番下の位置に設定(floatingActionButtonの位置)
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController, // テキストメッセージを送信するコントローラーの設置
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Message ...",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector( //タッチ検出をしたい親Widgetで使用し、PrimaryとSecondaryの2つのボタン入力をサポート
                      onTap: () {
                        sendMessage(); // テキストメッセージを送信する機能の呼び出し
                      },
                      child: Container( // メッセージを入力する入力アイコン
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
                          child: Image.asset("assets/images/send.png"), // 入力アイコン
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

/*
*    チャットルームでのユーザーのリストタイル会話の設定
* */

class MessageTile extends StatelessWidget {
  // テキストメッセージの変数設定
  final String message;
  MessageTile(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        message,
        style: TextStyle(
            color: Colors.white,
            fontSize: 17
        ),
      ), // テキストメッセージの表示
    );
  }
}
