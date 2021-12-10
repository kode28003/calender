import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:calender/page/home.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

List <String> todoAddDate=[];
List <EventModel> allEventList=[];

Future<String?> setDate() async {
  SharedPreferences prefs = await _prefs;
  prefs.setStringList('todoDate', todoAddDate);
  print('保存しました');
}

Future<String?> getDate() async {
  SharedPreferences prefs = await _prefs;
  todoAddDate.clear();
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

  List<String> eventString =
  allEventList.map((f) => json.encode(f.toJson())).toList();
  prefs.setStringList('AllEvent', eventString);
  print('イベントを保存しました');
}

Future<Appointment?> getAllEvent() async {
  SharedPreferences prefs = await _prefs;
  allEventList.clear();
  result = prefs.getStringList('AllEvent');

  // 読み出し確認
  if (result != null) {
    allEventList =
        result.map((f) => EventModel.fromJson(json.decode(f))).toList();
    print(allEventList);
  } else {
  }
}

Future<String?> removeAllEvent() async {
  SharedPreferences prefs = await _prefs;
  prefs.remove('todoDate');
}

class EventModel {
  String startTime;
  String endTime;
  String subject;

  EventModel({
        required  this.startTime,
        required  this.endTime,
        required  this.subject,
      });

  /// Map型に変換
  Map toJson() => {
    'startTime': startTime,
    'endTime': endTime,
    'subject': subject,
  };

  /// JSONオブジェクトを代入
  EventModel.fromJson(Map json)
      : startTime = json['startTime'],
        endTime = json['endTime'],
        subject = json['subject'];
}
