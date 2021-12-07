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
    initialDate: tapDay,
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

Future InputText(BuildContext context) async{
  await showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Theme(
        data: ThemeData(
        dialogBackgroundColor: Colors.brown.shade50,
        dialogTheme: DialogTheme(backgroundColor: Colors.brown.shade50)),
        child: CupertinoAlertDialog(
        title: Text('予定を入力してください'+'\n',),
        content: CupertinoTextField(
          cursorColor: Colors.brown.shade50,
          onChanged: (value){
            appointment=value;
          },
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancel',style: TextStyle(color:Colors.black),),
            onPressed: () {
              Navigator.pop(context);
              appointment=null;
            },
          ),
          CupertinoDialogAction(
            child: Text('OK',style: TextStyle(color:Colors.black),),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      );
    },
  );
}
