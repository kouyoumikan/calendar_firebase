import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/*
*    Databaseを使用して、Search画面でユーザー名を検索する
* */

// 事前準備　FireStore Database内のCloud FireStoreを作成する(本番モード)
class DatebaseMethods {
  getUsersByUsername(String username) async { // Cloud FireStore内のコレクションにあるユーザーデータを取得
    // usersコレクション内にあるnameフィールドのデータを取得
    return await Firestore.instance.collection("users")
        .where("name", isEqualTo: username ).getDocuments();
//    return await FirebaseFireStore.instance.collection("users")
//        .where("name", isEqualTo: username ).get();
  }

  getUsersByUserEmail(String userEmail) async { // Cloud FireStore内のコレクションにあるユーザーデータを取得
    // usersコレクション内にあるemailフィールドのデータを取得
    return await Firestore.instance.collection("users")
        .where("email", isEqualTo: userEmail ).getDocuments();
  }

  uploadUserInfo(userMap) { // Cloud FireStore内のユーザー情報をアップデートする関数
    // usersコレクション内にあるフィールドのデータを取得
    Firestore.instance.collection("users").add(userMap).catchError((e) {
      // Cloud FireStore内のエラー情報を印刷してprintに表示する
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) { // チャットルームで使用する複数のユーザーのデータをCloud Firestore内から取得
    // ChatRoomコレクション内にあるchatRoomIdフィールドのデータを取得
    Firestore.instance.collection("ChatRoom").document(chatRoomId).setData(chatRoomMap).catchError((e) {
      // Cloud FireStore内のエラー情報を印刷してprintに表示する
      print(e.toString());
    });

//    FirebaseFireStore.instance.collection("ChatRoom")
//        .doc(chatRoomId).get(chatRoomMap).catchError((e) {
//      // Cloud FireStore内のエラー情報を印刷してprintに表示する
//      print(e.toString());
//    });
  }

  // Conversation.dartで使用するテキスト会話のユーザーデータの追加
  addConversationMessages(String chatRoomId, messageMap) {
    // ChatRoomコレクション内にあるchatsコレクションのフィールドのデータの追加
    Firestore.instance.document(chatRoomId).collection("chats").add(messageMap).catchError((e) {
      // Cloud FireStore内のエラー情報を印刷してprintに表示する
      print(e.toString());
    });
  }

  // Conversation.dartで使用するテキスト会話のユーザーデータの取得
  getConversationMessages(String chatRoomId) async {
    // ChatRoomコレクション内にあるchatsコレクションのフィールドのデータを取得
    return await Firestore.instance.document(chatRoomId).collection("chats")
        .orderBy("time", descending: false).snapshots(); // descending:false = 最新時間のテキストメッセージを下に表示する機能
  }

}