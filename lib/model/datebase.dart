import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/*
*    Datebaseを使用して、Search画面でユーザー名を検索する
* */

// 事前準備　Firestore Datebase内のCloud Firestoreを作成する(本番モード)
class DatebaseMethods {
  getUsersByUsername(String username) async { // Cloud Firestore内のコレクションにあるユーザーデータを取得
    return await Firestore.instance.collection("users")
        .where("name", isEqualTo: username ).getDocuments();
//    return await FirebaseFirestore.instance.collection("users")
//        .where("name", isEqualTo: username ).get();
  }

  getUsersByUserEmail(String userEmail) async { // Cloud Firestore内のコレクションにあるユーザーデータを取得
    return await Firestore.instance.collection("users")
        .where("email", isEqualTo: userEmail ).getDocuments();
  }

  uploadUserInfo(userMap) { // Cloud Firestore内のユーザー情報をアップデートする関数
    Firestore.instance.collection("users").add(userMap).catchError((e) {
      // Cloud Firestore内のエラー情報を印刷してprintに表示する
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) { // チャットルームで使用する複数のユーザーのデータをCloud Firestore内から取得
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId).setData(chatRoomMap).catchError((e) {
      // Cloud Firestore内のエラー情報を印刷してprintに表示する
      print(e.toString());
    });

//    FirebaseFirestore.instance.collection("ChatRoom")
//        .doc(chatRoomId).get(chatRoomMap).catchError((e) {
//      // Cloud Firestore内のエラー情報を印刷してprintに表示する
//      print(e.toString());
//    });
  }
}