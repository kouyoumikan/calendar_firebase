import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/widget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //appBar: appBarMain(context), // widget.dartをimportする
      appBar: AppBar(
        title: Text("サインイン Pages"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue, // アプリバーの背景色
      ),
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
//              style: TextStyle(
//                color: Colors.white
//              ),
                  decoration: textFieldInputDecoration("email"), // widget.dartからデザイン呼び出し
//              decoration: InputDecoration(
//                hintText: 'email',
//                hintStyle: TextStyle(
//                  color: Colors.white54,
//                ),
//                focusedBorder: UnderlineInputBorder(
//                  borderSide: BorderSide(
//                    color: Colors.white
//                  ),
//                ),
//                enabledBorder: UnderlineInputBorder(
//                  borderSide: BorderSide(
//                      color: Colors.white
//                  ),
//                ),
//              ),
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
                      "Sign In",
                      style: biggerTextStyle(),
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 17
//                      ),
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
                    "Sign In with Google",
                    style: mediaTextStyle(),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account ? ",
                      style: biggerTextStyle(),
                    ),
                    Text(
                      "Resister now",
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
      ),
    );
  }
}
