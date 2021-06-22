import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // 背景色
      appBar: AppBar(
        title: Text("ホーム Pages"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue, // アプリバーの背景色
      ),
      body: Center(
        child: Text(
          "カレンダー TEST",
          style: TextStyle(color: Colors.grey[800], fontSize: 13),
        ),
      ),
      // 下部ナビゲーションバーでスクロール
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // 現在選択しているアイコンの色をハイライト表示
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
            //Navigator.of(context).pushNamed("/home");
          } else if (index == 1) {
            Navigator.of(context).pushNamed("/view_event");
          } else if (index == 2) {
            Navigator.of(context).pushNamed("/calendar");
          } else if (index == 3) {
            Navigator.of(context).pushNamed("/setting");
          }
        },
      ),
    );
  }
}
