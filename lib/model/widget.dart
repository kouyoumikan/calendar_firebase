import 'package:flutter/material.dart';

/*
*    アプリバーのカスタマイズ
* */

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/logo.png", // アプリバーのロゴ画像
      height: 40,
    ),
    elevation: 0.0,
    centerTitle: false,
  );
}

/*
*    サインインのテキストフィールドのカスタマイズ
* */

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white54
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white
      ),
    ),
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16
  );
}

TextStyle biggerTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17
  );
}

//TextStyle mediaTextStyle() {
//  return TextStyle(color: Colors.black87, fontSize: 17);
//}

TextStyle mediaTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17
  );
}