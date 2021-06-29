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
              snapshot.data!.documents[index].data["message"],
              // テキストメッセージ送信者がログインユーザーと等しい
              snapshot.data!.documents[index].data["sendBy"] == Constants.myName,
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
    );
  }
}

/*
*    チャットルームでのユーザーのリストタイル会話の設定
* */

class MessageTile extends StatelessWidget {

  final String message; // テキストメッセージの変数設定
  final bool isSendByMe; // ログインユーザーのテキストメッセージ色を強調する変数設定
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      // テキストメッセージ送信者がログインユーザーの場合はテキストメッセージ左のスペースを0、右のスペースを24に設定
      // テキストメッセージ送信者がログインユーザーではない場合はテキストメッセージ左のスペースを24、右のスペースを0に設定
      padding: EdgeInsets.only(left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8), // 要素周りのスペース設定
      width: MediaQuery.of(context).size.width, // テキストメッセージの表示高さをアプリの高さに設定
      // テキストメッセージ送信者がログインユーザーの場合はテキストメッセージを右に表示、違う場合はテキストメッセージを左に表示
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16), // 要素内の周りのスペース設定
        decoration: BoxDecoration(
          gradient: LinearGradient( // テキスト周りの色設定
            colors: isSendByMe ? [ // テキストメッセージ送信者がログインユーザーの場合
              const Color(0xff007EF4),
              const Color(0xff2A75BC)
            ] : [ // テキストメッセージ送信者がログインユーザーではない場合
              const Color(0x1AFFFFFF),
              const Color(0x1AFFFFFF)
            ],
          ),
          borderRadius: isSendByMe ? BorderRadius.only( // テキストメッセージ送信者がログインユーザーの場合
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(23),
          ) :
          BorderRadius.only( // テキストメッセージ送信者がログインユーザーではない場合
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomRight: Radius.circular(23),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
              color: Colors.white,
              fontSize: 17
          ),
        ), // テキストメッセージの表示
      ),
    );
  }
}
