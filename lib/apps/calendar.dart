import 'package:calender/page/home.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/cupertino.dart';

DateTime? startValue;
DateTime? endValue;
final now = new DateTime.now();

Future endDay(BuildContext context) async{
  final selectDay=await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2021),
    lastDate: DateTime(2022),
    helpText: '予定の終了日時を教えて下さい',
  );
  if(selectDay!=null){
    endDays=selectDay.day;
  }
}

Future startTimes(BuildContext context) async{
  TimeOfDay? selected = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    helpText: '開始時刻を入力してください',
  );
  if(selected !=null){
    startValue = DateTime(now.year,now.month,startDay!,selected.hour,selected.minute);
  }
}

Future endTimes(BuildContext context) async{
  TimeOfDay? select = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    helpText: '終了時刻を入力してください',
  );
  if(select !=null){
    endValue = DateTime(now.year,now.month,endDays!,select.hour,select.minute);
  }
}

