import 'dart:convert';

import 'package:calender/apps/message.dart';
import 'package:calender/apps/random.dart';
import 'package:calender/data/storage.dart';
import 'package:calender/page/sns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender/apps/count.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:calender/page/todo.dart';
import 'package:calender/apps/calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calender/data/storage.dart';
import 'package:calender/apps/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

CalendarDataSource? _dataSource;
Appointment? app;
Appointment? event;
int number = 1;
String? appointment;
DateTime tapDay = DateTime.now();
int eventCounter = 0;
var result;

final explanation = [
  '2030年までに、現在１日1.25ドル未満で生活する人々と定義されている極度の貧困をあらゆる場所で終わらせる。',
  '2030年までに、飢餓を撲滅し、全ての人々が一年中安全かつ栄養のある食料を十分得られるようにする。',
  '2030年までに、世界の妊産婦の死亡率を出生10万人当たり70人未満に削減する。',
  '2030年までに、全ての若者及び成人が、読み書き能力及び基本的計算能力を身に付けられるようにする。',
  'あらゆる場所における全ての女性及び女児に対するあらゆる形態の差別を撤廃する。',
  '2030年までに、全ての人々の、安全で安価な飲料水の普遍的かつ衡平なアクセスを達成する。',
  '2030年までに、安価かつ信頼できる現代的エネルギーサービスへの普遍的アクセスを確保する。',
  '2020年までに、就労、就学及び職業訓練のいずれも行っていない若者の割合を大幅に減らす。',
  '2020年までに、開発途上国にも普遍的かつ安価なインターネットアクセスを提供する。',
  '2030年までに、各国の所得下位40%の所得成長率について、国内平均を上回る数値を漸進的に達成し、持続させる。',
];

final status = [
  ' 世界では、6人に1人（3億5600万人）の子どもたちが、「極度にまずしい」暮らしをしています。',
  ' 明日以降も食べ物を得られるか分からない状態の人が世界人口の10%もいます。',
  ' サハラ以南のアフリカ地域では、2人に1人の　　子どもが風邪で肺炎になっても治療を受けられません。',
  ' アフリカ地域、南アジア地域では、6〜11歳の.子どものうち5人に1人が小学校に通えません。',
  ' 6歳から11歳の子どものうち、一生学校に通うことができない女の子は男の子の約2倍います。',
  ' 水道の設備がない暮らしをしている人は22億人です。屋外で用を足す人は6億7300万人です。',
  ' 世界で電力を使えない人は7億8900万人です。',
  ' 世界のもっと貧しい国では、5歳から17歳までの子どもの4人に1人が、労働を強いられています。',
  ' 世界では、約37億人の人々がインターネットにアクセスできません。',
  ' 2017年には、世界の最も豊かな1%の人が世界全体の富の約33%を持っていました。',
];

final num = [
  '１',
  '２',
  '３',
  '４',
  '５',
  '６',
  '７',
  '８',
  '９',
  '１０',
];

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _dataSource = _getDataSource();
    final random = ref.watch(randomProvider);
    ref.watch(countProvider);
    number = random.nextInt(6); //0~6までのrandom
    addStorageEvent();

    return CupertinoPageScaffold(
      backgroundColor: Colors.brown.shade50,
      navigationBar: new CupertinoNavigationBar(
        backgroundColor: Colors.brown.shade50,
        middle: Text(myName+' さんの SDGs Calendar'),
        trailing: CupertinoButton(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Icon(
            CupertinoIcons.forward,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, ToDoPage.route);
            getDate();
          },
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.fromLTRB(0, 6, 10, 5),
          onPressed: () {
            Navigator.pushNamed(context, SnsPage.route);
            ref.read(countProvider.state).state += 1;
          },
          child: Icon(
            CupertinoIcons.back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            //alignment: Alignment.topLeft,
            top: -8,
            right: 200,
            child: SizedBox(
              height: 85,
              child: CupertinoButton(
                onPressed: () {
                  showCupertinoDialog<void>(
                      //barrierColor: background(number)!.withOpacity(0.3),
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) => Theme(
                            data: ThemeData(
                                dialogBackgroundColor: Colors.brown.shade50,
                                dialogTheme: DialogTheme(
                                    backgroundColor: Colors.brown.shade50)),
                            child: CupertinoAlertDialog(
                              title: Text(
                                  "目標 " + (number + 1).toString() + " の具体例"),
                              content: Text("\n" + explanation[number]),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                CupertinoDialogAction(
                                  child: Text(
                                    '詳しく ↗',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    launchURL();
                                  },
                                ),
                              ],
                            ),
                          ));
                },
                child: Image.asset(
                  'image/' + (number + 1).toString() + '.jpg',
                  width: 150,
                  height: 100,
                  colorBlendMode: BlendMode.srcOver,
                  color: Colors.brown.shade50.withOpacity(0.2),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 300,
            child: Container(
              width: 53,
              padding: EdgeInsets.all(3),
              child: FloatingActionButton(
                backgroundColor: Colors.brown.shade50,
                onPressed: () async {
                  ref.read(countProvider.state).state += 1;
                  //Firestore.add();
                },
                child: const Icon(
                  Icons.refresh,
                  size: 36,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Event(),
          Positioned(
            bottom: 7,
            right: 8,
            child: Container(
              width: 50,
              child: FloatingActionButton(
                backgroundColor: Colors.brown.shade50,
                foregroundColor: Colors.black54,
                onPressed: () async {
                  await InputText(context);
                  if (appointment != null) {
                    //await endDay(context);
                    await startTimes(context);
                    await endTimes(context);
                    await addEvent();
                  }
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, 383, 2, 2),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              text: TextSpan(
                text: '目標' + (num[number]) + 'の現状',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  decorationThickness: 3,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(4, 415, 2, 2),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              text: TextSpan(
                text: status[number],
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ),
          Positioned(
            bottom: 110,
            left: 260,
            child: Image.asset(
              'image/' +
                  (number + 1).toString() +
                  (number + 1).toString() +
                  '.png',
              width: 120,
              height: 70,
              colorBlendMode: BlendMode.srcOver,
              color: Colors.brown.shade50.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Color? background(int number) {
    switch (number) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.blue;
    }
  }
}

class Event extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 350,
        child: SfCalendar(
          todayHighlightColor: Colors.black54,
          cellBorderColor: Colors.black38,
          backgroundColor: Colors.brown.shade50,
          view: CalendarView.month,
          dataSource: _dataSource,
          monthViewSettings: const MonthViewSettings(
            showAgenda: true,
          ),
          scheduleViewSettings: const ScheduleViewSettings(),
          onTap: calendarTapped,
          allowedViews: const [
            CalendarView.day,
            CalendarView.week,
            CalendarView.workWeek,
            CalendarView.month,
            // CalendarView.timelineDay,
            // CalendarView.timelineWeek,
            // CalendarView.timelineWorkWeek,
            //CalendarView.timelineMonth,
            //CalendarView.schedule
          ],
        ),
      ),
    );
  }
}

void calendarTapped(CalendarTapDetails calendarTapDetails) {
  tapDay = calendarTapDetails.date!;
  startDay = calendarTapDetails.date!.day;
}

Future<void> addEvent() async {
  event = Appointment(
      startTime: startValue!,
      endTime: endValue!,
      subject: appointment!,
      color: Colors.black54);

  allEventList = [
    EventModel(
      startTime: startValue!.toString(),
      endTime: endValue!.toString(),
      subject: appointment!,
    )
  ];
  await setAllEvent();

  _dataSource!.appointments!.add(event);
  _dataSource!
      .notifyListeners(CalendarDataSourceAction.add, <Appointment>[event!]);
  appointment = null;
}

Future<void> addStorageEvent() async {
  getAllEvent();
  startValue = DateTime.parse(allEventList[0].startTime);
  endValue = DateTime.parse(allEventList[0].endTime);
  appointment = allEventList[0].subject;
  event = Appointment(
      startTime: startValue!,
      endTime: endValue!,
      subject: appointment!,
      color: Colors.black54);
  _dataSource!.appointments!.add(event);
  _dataSource!
      .notifyListeners(CalendarDataSourceAction.add, <Appointment>[event!]);
  //appointment=null;
}

_DataSource _getDataSource() {
  List<Appointment> appointments = <Appointment>[];
  final now=DateTime.now();
  appointments.add(Appointment(
    startTime: DateTime(now.year,2,11,10,00),
    endTime: DateTime(now.year,2,11,12,00).add(const Duration(hours: 1)),
    subject: 'SHISHI KOTSUKOTSU',
    color: Colors.black54,
  ));
  appointments.add(Appointment(
    startTime: DateTime(now.year,2,10,now.hour,now.minute),
    endTime: DateTime(now.year,2,10,now.hour,now.minute).add(const Duration(hours: 1)),
    subject: '世界豆の日',
    color: Colors.black54,
  ));
  appointments.add(Appointment(
    startTime: DateTime(now.year,2,21,now.hour,now.minute),
    endTime: DateTime(now.year,2,21,now.hour,now.minute).add(const Duration(hours: 1)),
    subject: '国際母語の日',
    color: Colors.black54,
  ));
  appointments.add(Appointment(
    startTime: DateTime(now.year,3,3,now.hour,now.minute),
    endTime: DateTime(now.year,3,3,now.hour,now.minute).add(const Duration(hours: 1)),
    subject: '世界野生生物の日',
    color: Colors.black54,
  ));
  appointments.add(Appointment(
    startTime: DateTime(now.year,3,8,now.hour,now.minute),
    endTime: DateTime(now.year,3,8,now.hour,now.minute).add(const Duration(hours: 1)),
    subject: '国際女性デー',
    color: Colors.black54,
  ));
  appointments.add(Appointment(
    startTime: DateTime(now.year,3,21,now.hour,now.minute),
    endTime: DateTime(now.year,3,21,now.hour,now.minute).add(const Duration(hours: 1)),
    subject: '国際人種差別撤廃デー',
    color: Colors.black54,
  ));

  return _DataSource(appointments);
}

launchURL() async {
  const url = "https://www.unicef.or.jp/kodomo/sdgs/";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not Launch $url';
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
