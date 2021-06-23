/*
*    テーマカラーの切り替え　ライト/ダーク
* */

import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/themes.dart';

class Setting extends StatefulWidget {
  Setting({required Key key, required this.title}) : super(key: key);
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
              'Fluter Themes Demo',
            ),
          ],
        ),
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
      home: ThemeColors(
          title: 'ThemeColors Sample'
      ),
      title: 'ThemeColors Sample',
      theme: CustomTheme.lightTheme, // デフォルトのテーマはライトテーマ
      darkTheme: CustomTheme.darkTheme, // ダークテーマの設定
      themeMode: currentTheme.currentTheme, // 現在のテーマモードをテェックする設定
    );
  }
}