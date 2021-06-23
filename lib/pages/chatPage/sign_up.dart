import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/widget.dart';

/*
*    サインアップ画面　（アカウントを持っている場合のログイン画面）
* */

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          // 要素を縦の高さ- 100の位置に配置する
          height: MediaQuery.of(context).size.height - 100,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: simpleTextStyle(), // widget.dartからデザイン呼び出し
                  decoration: textFieldInputDecoration("user name"), // widget.dartからデザイン呼び出し
                ),
                TextField(
                  style: simpleTextStyle(), // widget.dartからデザイン呼び出し
                  decoration: textFieldInputDecoration("email"), // widget.dartからデザイン呼び出し
                ),
                TextField(
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("password"),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Forgot Password ?",
                      style: simpleTextStyle(),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff007EF4),
                        Color(0xff2A75BC)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sign Up",
                    style: biggerTextStyle(),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sign Up with Google",
                    style: mediaTextStyle(),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account ? ",
                      style: biggerTextStyle(),
                    ),
                    Text( // アカウントを持っていない場合
                      "SignIn now",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
              ],
            ),
          ),
        ),
      ),,
    );
  }
}
