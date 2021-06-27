import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
*    cloud_firebaseの共有設定データを保存する関数
*    search.dartで、ユーザーがアプリに再ログイン時、ユーザーが既にログインしていることを確認する
* */

class HelperFunctions {
  // 現在ログインしているユーザーのログインキー設定
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  // 現在ログインしているユーザーのユーザー名キー設定
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  // 現在ログインしているユーザーのメールアドレスキー設定
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  // 保存したユーザーのログインキーを参照する関数
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  // 保存したユーザーのユーザー名キーを参照する関数
  static Future<bool> saveUserNameSharedPreference(String userName) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  // 保存したユーザーのメールアドレスキーを参照する関数
  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  // 保存したユーザーのログインキーを取得する関数
  static Future<bool> getUserLoggedInSharedPreference() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  // 保存したユーザーのユーザー名キーを取得する関数
  static Future<String> getUserNameSharedPreference() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserNameKey);
  }

  // 保存したユーザーのメールアドレスキーを取得する関数
  static Future<String> getUserEmailSharedPreference() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserEmailKey);
  }
}