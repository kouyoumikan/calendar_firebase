import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/user.dart';

/*
*    firebaseのAuthenticationログイン設定
* */

class AuthMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance; // firebase_authをimportする

  User _userFromFirebaseUser(FirebaseUser user) { // firebaseユーザーを取得
    // CONDITION ? TRUE : FALSE 受け取ったユーザーデータがnullではないか判定
    return user != null ? User(userID: user.uid) : null;
  }

  // メールアドレスでサインインする機能
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      // サインイン画面の認証結果で受け取るメールアドレスのデータ
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user; // firebaseからユーザー名を取得
      return _userFromFirebaseUser(firebaseUser); // firebaseユーザーを取得して呼び出す
    }
    catch(e) { // エラー発生時の動作
      print(e.toString()); // エラー文を印刷してprintに表示する
    }
  }

  // メールアドレスでサインアップする機能
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      // サインアップ画面の認証結果で受け取るのメールアドレスのデータ
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user; // firebaseからユーザー名を取得
      return _userFromFirebaseUser(firebaseUser); // firebaseユーザーを取得して呼び出す
    }
    catch(e) { // エラー発生時の動作
      print(e.toString()); // エラー文を印刷してprintに表示する
    }
  }

  // パスワードをリセットする
  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email); // パスワードリセット用のメールを取得
    }
    catch(e) { // エラー発生時の動作
      print(e.toString()); // エラー文を印刷してprintに表示する
    }
  }

  // サインアウト
  Future signOut() async {
    try {
      return await _auth.signOut(); // サインアウトが完了
    }
    catch(e) { // エラー発生時の動作
      print(e.toString()); // エラー文を印刷してprintに表示する
    }
  }
}