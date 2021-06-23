/*
*    テーマカラーの切り替え　ライト/ダーク
* */

import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/themes.dart';

class Setting extends StatefulWidget {
  Setting({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            //color: Theme.of(context).accentColor, // アプリバーのみアクセントカラーの色変更
            color: theme.accentColor, // 上記の簡略化バージョン
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4_rounded),
            onPressed: () {
              currentTheme.toggleTheme(); // ボタン押下後、テーマカラーの切り替え
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Fluter Themes Sample',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3, // 現在選択しているアイコンの色をハイライト表示
        items: [
          // BottomNavigationBarItemに表示するリスト
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("ホーム"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            title: Text("入力"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("カレンダー"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("設定"),
          ),
        ],
        // ナビゲーションバーのアイコンをタップしたときの処理
        onTap: (int index) {
          print(index); // デバッグ用に出力（タップされたボタンによって数値がかわる）
          if (index == 0) {
            // First Icon が押されたときは前の画面に戻る
            // Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/home");
          } else if (index == 1) {
            Navigator.of(context).pushNamed("/view_event");
          } else if (index == 2) {
            Navigator.of(context).pushNamed("/calendar");
          } else if (index == 3) {
            //Navigator.of(context).pushNamed("/setting");
          }
        },
      ),
    );
  }
}

class ThemeColors extends StatefulWidget {
  ThemeColors({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ThemeColorsState createState() => _ThemeColorsState();
}

class _ThemeColorsState extends State<ThemeColors> {

  @override
  void initState() { // themes.dartのimportを呼び出し、アプリを更新する設定
    super.initState();
    currentTheme.addListener(() {
      setState(() { // // アプリを更新する

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Setting(
          title: 'ThemeColors Sample',
      ),
      title: 'ThemeColors Sample',
      theme: CustomTheme.lightTheme, // デフォルトのテーマはライトテーマ
      darkTheme: CustomTheme.darkTheme, // ダークテーマの設定
      themeMode: currentTheme.currentTheme, // 現在のテーマモードをテェックする設定
    );
  }
}