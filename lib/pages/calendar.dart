import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month; // カレンダー右上ボタンでフォーマットを切り替え設定

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
      body: TableCalendar(
        focusedDay: DateTime.now(), // 現在の日付に設定
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
      ),
//      body: SingleChildScrollView(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            TableCalendar(
//              locale: 'ja_JP', // カレンダーの言語を日本語で設定
//              weekendDays: [7], //
//              focusedDay: selectedDay,
//              firstDay: DateTime(1990),
//              lastDay: DateTime(2050),
//              calendarFormat: format,
//              // フォーマット変更のボタン押下時の処理
//              onFormatChanged: (CalendarFormat _format) {
//                setState(() {
//                  format = _format;
//                });
//              },
//              startingDayOfWeek: StartingDayOfWeek.sunday,
//              daysOfWeekVisible: true,
//
//              //Day Changed
//              onDaySelected: (DateTime selectDay, DateTime focusDay) {
//                setState(() {
//                  selectedDay = selectDay;
//                  focusedDay = focusDay;
//                });
//                print(focusedDay);
//              },
//              selectedDayPredicate: (DateTime date) {
//                return isSameDay(selectedDay, date);
//              },
//
//              //eventLoader: _getEventsfromDay,
//
//              //To style the Calendar
//              calendarStyle: CalendarStyle(
//                isTodayHighlighted: true,
//                selectedDecoration: BoxDecoration(
//                  color: Colors.blue,
//                  shape: BoxShape.rectangle,
//                  borderRadius: BorderRadius.circular(5.0),
//                ),
//                selectedTextStyle: TextStyle(color: Colors.white),
//                todayDecoration: BoxDecoration(
//                  color: Colors.purpleAccent,
//                  shape: BoxShape.rectangle,
//                  borderRadius: BorderRadius.circular(5.0),
//                ),
//                defaultDecoration: BoxDecoration(
//                  shape: BoxShape.rectangle,
//                  borderRadius: BorderRadius.circular(5.0),
//                ),
//                weekendDecoration: BoxDecoration(
//                  shape: BoxShape.rectangle,
//                  borderRadius: BorderRadius.circular(5.0),
//                ),
//              ),
//              //右上にあるカレンダー表示の切り替えボタンのカスタマイズ
//              headerStyle: HeaderStyle(
//                formatButtonVisible: true,
//                titleCentered: true,
//                formatButtonShowsNext: false,
//                formatButtonDecoration: BoxDecoration(
//                  color: Colors.blue,
//                  borderRadius: BorderRadius.circular(5.0),
//                ),
//                formatButtonTextStyle: TextStyle(
//                  color: Colors.white,
//                ),
////                leftChevronVisible: false, // 左上の矢印を非表示
////                rightChevronVisible: false, // 右上の矢印を非表示
//                headerPadding: EdgeInsets.symmetric(
//                    horizontal: 5.0,
//                    vertical: 1.0
//                ),
//              ),
//              // カレンダーのイベント数を数字で表示するようにカスタマイズ
//              calendarBuilders: CalendarBuilders(
//                markerBuilder: (context, date, events) {
//                  if (events.isNotEmpty) {
//                    return _buildEventsMarker(date, events);
//                  }
//                },
//              ),
//            ),
//          ],
//        ),
//      ),
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
            //Navigator.of(context).pushNamed("/home");
          } else if (index == 1) {
            Navigator.of(context).pushNamed("/view_event");
          } else if (index == 2) {
            //Navigator.of(context).pushNamed("/calendar");
          } else if (index == 3) {
            Navigator.of(context).pushNamed("/setting");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add_event');
          //Navigator.pushNamed(context, AppRoutes.addEvent, arguments: selectedDay);
        },
        //onPressed: () => Navigator.pushNamed(context, '/add_event'),
        //onPressed: () => Navigator.of(context).pushNamed("/add_event"),
      ),
    );
  }
}

//// カレンダーのイベント数を赤丸の数字で表示
//Widget _buildEventsMarker(DateTime date, List events) {
//  return Positioned(
//    right: 5,
//    bottom: 5,
//    child: AnimatedContainer(
//      duration: const Duration(milliseconds: 300),
//      decoration: BoxDecoration(
//        shape: BoxShape.circle,
//        color: Colors.red[300],
//      ),
//      width: 16.0,
//      height: 16.0,
//      child: Center(
//        child: Text(
//          '${events.length}',
//          style: TextStyle().copyWith(
//            color: Colors.white,
//            fontSize: 12.0,
//          ),
//        ),
//      ),
//    ),
//  );
//}
