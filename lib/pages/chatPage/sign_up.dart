import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/auth.dart';
import 'package:flutter_firebase/model/datebase.dart';
import 'package:flutter_firebase/model/helperfunctions.dart';
import 'package:flutter_firebase/model/widget.dart';
import 'package:flutter_firebase/pages/chatPage/ChatRoom.dart';

/*
*    サインアップ画面　（アカウントを持っている場合のログイン画面）
* */

class SignUp extends StatefulWidget {
  // ユーザーがサインアップしている状態か判定
  late final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // ボタン押下後にデータを読み込んでいるか判定するフラグの設定（初期はデータを読み込んでいない状態なのでfalse）
  bool isLoading = false;

  AuthMethods authMethods = AuthMethods(); // AuthMethodsをimportする
  DatebaseMethods datebaseMethods = DatebaseMethods(); // DatebaseMethodsをimportする
  HelperFunctions helperFunctions = HelperFunctions(); // HelperFunctionsをimportする

  final formkey = GlobalKey<FormState>(); // Form内(テキストフォーム用ウィジェット)にformkeyを作成
  // firebaseで使用する変数
  TextEditingController userNameTextEditingController = TextEditingController(); // ユーザー名編集
  TextEditingController emailTextEditingController = TextEditingController(); // メールアドレス編集
  TextEditingController passwordTextEditingController = TextEditingController(); // パスワード編集

  signMeUp() { // テキストフォームでサインアップできているかの判定
    if(formkey.currentState!.validate()) { // formkeyのデータでテキストフォームに入力した文字列の内容を判定

      // Cloud Firestoreのルールタブ内をallow read, write: if true;にして「公開」しないとコレクションに追加できない
      // Cloud Firestore内のコレクションデータをサインアップ画面の認証結果で受け取るメールアドレスのデータに設定
      Map<String, String> userInfoMap = { // ボタン押下後、Cloud Firestore内にユーザー情報を追加
        "name": userNameTextEditingController.text,
        "email": emailTextEditingController.text
      };

      // HelperFunctions.dartにアクセスする
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);

      setState(() {
        isLoading = true; // ボタン押下後にデータを読み込んでいる状態なのでtrue
      });

      // サインアップ画面の認証結果で受け取るメールアドレスのデータを取得して確認する
      authMethods.signUpWithEmailAndPassword(
          emailTextEditingController.text, passwordTextEditingController.text).then( (value) {
            //print("${value.uid}"); // メールアドレスのユーザーデータを印刷してprintに表示する

          datebaseMethods.uploadUserInfo(userInfoMap); // Cloud Firestore内のユーザー情報をアップデートする

          // チャットルーム画面にサインアップ画面のユーザーデータ情報を送信する
          Navigator.pushReplacement(context, MaterialPageRoute ( // ChatRoomをimportする
                  builder: (context) => ChatRoom()
          ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),
      body: isLoading ? Container( // ボタン押下後にbody内のデータを読み込んでいるか判定
        child: Center(
          child: CircularProgressIndicator( // データのロード中に画面に表示する円形のアートデザイン

          ),
        ),
      ) : SingleChildScrollView(
        child: Container(
          // 要素を縦の高さ- 100の位置に配置する
          height: MediaQuery.of(context).size.height - 100,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form( // テキストフォーム用ウィジェットを作成
                  key: formkey, // formkeyを使用する宣言
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) { // 特定の文字列が入力されている場合、ボタン送信が機能しない設定にする
                          if (value!.isEmpty || value.length < 2) { // 空か2文字以下の場合null
                            return 'Please Provide a UserName'; // エラー文の表示
                          }
                          return null;
                        },
//                        validator(val) { // 特定の文字列が入力されている場合、ボタン送信が機能しない設定にする
//                          // 空か2文字以下の場合null
//                          return val.isEmpty || val.length < 2 ? "Please Provide a UserName" : null;
//                        },
                        controller: userNameTextEditingController, // ユーザー名編集コントローラーの設定
                        style: simpleTextStyle(), // widget.dartからデザイン呼び出し
                        decoration: textFieldInputDecoration("username"), // widget.dartからデザイン呼び出し
                      ),
                      TextFormField(
                        validator: (value) { // 特定の文字列が入力されている場合、ボタン送信が機能しない設定にする
                          // 正しいメールアドレスの値ではない場合
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!) ?
                          null : "Enter correct email"; // エラー文の表示
                        },
                        controller: emailTextEditingController, // メールアドレス編集コントローラーの設定
                        style: simpleTextStyle(), // widget.dartからデザイン呼び出し
                        decoration: textFieldInputDecoration("email"), // widget.dartからデザイン呼び出し
                      ),
                      TextFormField(
                        validator:  (value) { // 特定の文字列が入力されている場合、ボタン送信が機能しない設定にする
                          // 6文字以下の場合nullにしてエラー文の表示
                          return value!.length < 6 ? "Enter Password 6+ characters" : null;
                        },
                        obscureText: true, // 入力したパスワードを見えなくするために黒丸にする
                        controller: passwordTextEditingController, // パスワード編集コントローラーの設定
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                GestureDetector( //タッチ検出をしたい親Widgetで使用し、PrimaryとSecondaryの2つのボタン入力をサポート
                  onTap: () {
                    signMeUp(); // ボタン送信機能でのテキストフォームに入力した文字列の内容を判定
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Forgot Password ?",
                        style: simpleTextStyle(),
                      ),
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
                    GestureDetector( //タッチ検出をしたい親Widgetで使用し、PrimaryとSecondaryの2つのボタン入力をサポート
                      onTap: () { // ユーザーがサインアップしている状態とデータ送信
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text( // アカウントを持っていない場合
                          "SignIn now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline
                          ),
                        ),
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
