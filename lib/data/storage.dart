import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


List <String> todoAddDate=[];


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