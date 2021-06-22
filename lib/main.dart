import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/calendar.dart';
import 'package:flutter_firebase/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      // デフォルトのルーティング
      //home: HomePage(), // initialRouteと同じ
      initialRoute: '/home', // アプリを開いた時にロードする最初のルート
      // ルーティングの一覧を設定
      routes: {
        //'/': (context) => MainPage(), // ホーム画面
        '/home': (context) => Home(), // ホーム画面
        '/calendar': (context) => Calendar(), // カレンダー画面
//        '/add_event': (context) => AddEvent(), // カレンダー入力画面
//        '/view_event': (context) => ViewEvent(), // カレンダー入力画面
//        '/setting': (context) => Setting(), // 設定画面
      },
    );
  }
}

//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key? key, required this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.headline4,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
