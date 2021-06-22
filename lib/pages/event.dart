import 'package:flutter/cupertino.dart';

class Event {
  //final DateTime date;
  final String title; // タイトル
  Event({required this.title});

  String toString() => this.title;
}