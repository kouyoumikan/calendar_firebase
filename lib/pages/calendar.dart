import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/event.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents; // event.dartのimportを設定

  CalendarFormat format = CalendarFormat.month; // カレンダー右上ボタンでフォーマットを切り替え設定

  DateTime selectedDay = DateTime.now(); // 選択される日付の初期値を現在の日付に設定
  DateTime focusedDay = DateTime.now(); // 二番目に選択される日付の初期値を現在の日付に設定

  // タイトル用のテキストフィールドで使用するテキスト編集コントローラー
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() { // メールのようにevent.dartの要素を送受信する設定
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) { // データが空かどうか判定
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() { // タイトル用のテキストフィールドで使用する
    _eventController.dispose(); // ページの強制終了時にテキスト編集コントローラー内容を破棄する
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Calendar'),
        centerTitle: true, // タイトルを中央配置
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, "/home"),
          )
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            //locale: 'ja_JP', // カレンダーの言語を日本語で設定
            focusedDay: selectedDay, // 二番目に選択される日付を現在の日付に設定
            firstDay: DateTime(1990), // カレンダーの最初の年を設定
            lastDay: DateTime(2050), // カレンダーの最後の年を設定
            // カレンダー右上ボタンでフォーマットを変更できるように設定
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday, // 週の初めを日曜日に設定
            daysOfWeekVisible: true,

            // 1番目にフォーカスして選択される日付の設定
            onDaySelected: (DateTime selectDay, DateTime focuseDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focuseDay;
              });
              print(focusedDay);
            },

            // 2番目に選択される日付をフォーカスした日付に更新
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay, // メールのようにevent.dartの要素を送受信する設定

            calendarStyle: CalendarStyle(
              isTodayHighlighted: true, // 今日の日付を強調
              selectedDecoration: BoxDecoration( // 選択した日付のデザイン装飾
                color: Colors.blue, // 青色
                //shape: BoxShape.circle, // 円形
                shape: BoxShape.rectangle, // 四角形
                borderRadius: BorderRadius.circular(5.0), // 図形の半径を設定
              ),
              selectedTextStyle: TextStyle(color: Colors.white), // 選択した日付の文字色の設定
              // 現在日時のデザイン装飾
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent, // 明るい紫色
                //shape: BoxShape.circle, // 円形
                shape: BoxShape.rectangle, // 四角形
                borderRadius: BorderRadius.circular(5.0), // 図形の半径を設定
              ),

              // デフォルトのデザイン装飾（borderRadiusでエラーが発生しないようにデフォルト設定する必要がある）
              defaultDecoration: BoxDecoration( // 平日の日付のデザイン装飾
                //color: Colors.blue, // 青色
                shape: BoxShape.rectangle, // 四角形
                borderRadius: BorderRadius.circular(5.0), // 図形の半径を設定
              ),
              weekendDecoration: BoxDecoration( // 土日の日付のデザイン装飾
                //color: Colors.purpleAccent, // 明るい紫色
                shape: BoxShape.rectangle, // 四角形
                borderRadius: BorderRadius.circular(5.0), // 図形の半径を設定
              ),
            ),

            // 右上にあるカレンダー表示の切り替えボタンのカスタマイズ
            headerStyle: HeaderStyle(
              formatButtonVisible: true, // 右上にあるカレンダー表示の切り替えボタンを表示するかの設定
              titleCentered: true, // カレンダーの月を中央配置する設定
              formatButtonShowsNext: false, // 右上にあるカレンダー表示の切り替え設定
              formatButtonDecoration: BoxDecoration( // 右上にあるカレンダー表示の切り替えボタンのデザイン装飾
                color: Colors.blue, // 青色
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle( // 右上にあるカレンダー表示の切り替えボタンの文字色の装飾
                color: Colors.white,
              ),
//          leftChevronVisible: false, // 左上の矢印を非表示
//          rightChevronVisible: false, // 右上の矢印を非表示
//          headerPadding: EdgeInsets.symmetric( // 右上にあるの切り替えボタンの配置の設定
//              horizontal: 5.0,
//              vertical: 1.0
//          ),
            ),

            // カレンダーのイベント数を数字で表示するようにカスタマイズ
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return _buildEventsMarker(date, events);
                }
              },
            ),
          ),

          // AlertDialog内の内容をリストタイルに表示する
          ..._getEventsfromDay(selectedDay).map((Event event) => ListTile(
            title: Text(
                event.title
            ),
          )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // 現在選択しているアイコンの色をハイライト表示
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
            //Navigator.of(context).pushNamed("/calendar");
          } else if (index == 3) {
            Navigator.of(context).pushNamed("/setting");
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended( // 文字付きのボタンをextendedで設定
        label: Text('Add Event'),
        icon: Icon(Icons.add),
        //onPressed: _showAddDialog, // Dialogの表示
        onPressed: () => showDialog( // ボタン押下後、アラートDialogを表示
            context: context,
            builder:(context) => AlertDialog(
              title: Text('Add Event'),
              content: TextField( // タイトル用のテキストフィールド作成
                controller: _eventController,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if(_eventController.text.isEmpty) { // 空の場合
                      //Navigator.pop(context);
                      //return;
                    }else {
                      // 選択した日付にタイトルが追加されていない場合
                      if (selectedEvents[selectedDay] != null) {
                        selectedEvents[selectedDay]!.add(
                          Event(title: _eventController.text), // タイトルを追加する
                        );
                      } else {
                        // 選択した日付にタイトルが既に追加されている場合
                        selectedEvents[selectedDay] = [
                          Event(title: _eventController.text), // タイトルを表示する
                        ];
                      }
                    }
                    Navigator.pop(context);
                    _eventController.clear(); // テキストフィールド内をクリアする
                    setState((){}); // 設定状態の前に戻る
                    return;
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
        ),
        //onPressed: () => Navigator.pushNamed(context, '/add_event'),
        //onPressed: () => Navigator.of(context).pushNamed("/add_event"),
      ),
    );
  }
}


// カレンダーのイベント数を赤丸の数字で表示
Widget _buildEventsMarker(DateTime date, List events) {
  return Positioned(
    right: 5,
    bottom: 5,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red[300],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    ),
  );
}
