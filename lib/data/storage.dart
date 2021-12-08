import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:calender/page/home.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

List <String> todoAddDate=[];
List <String> allEventList=[];

Future<String?> setDate() async {
  SharedPreferences prefs = await _prefs;
  prefs.setStringList('todoDate', todoAddDate);
  print('保存しました');
}

Future<String?> getDate() async {
  SharedPreferences prefs = await _prefs;
  todoAddDate.removeRange(0,todoAddDate.length);
  todoAddDate = prefs.getStringList('todoDate')!;
  print('取得しました');
  print(todoAddDate);
}

Future<String?> removeDate() async {
  SharedPreferences prefs = await _prefs;
  prefs.remove('todoDate');
}

Future<String?> setAllEvent() async {
  SharedPreferences prefs = await _prefs;
  prefs.setStringList('AllEvent', allEventList);
  print('イベントを保存しました');
}

Future<String?> getAllEvent() async {
  SharedPreferences prefs = await _prefs;
  allEventList.clear();
  final storageAllEvent =jsonEncode(prefs.getStringList('AllEvent')!);
  print('イベントを取得しました');
  print(storageAllEvent);
}

Future<String?> removeAllEvent() async {
  SharedPreferences prefs = await _prefs;
  prefs.remove('todoDate');
}