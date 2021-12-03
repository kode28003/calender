import 'package:calender/apps/random.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender/apps/count.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:calender/page/todo.dart';

CalendarDataSource? _dataSource;
Appointment? app;
int number=1;
final explanation=[
  '2030年までに、現在１日1.25ドル未満で生活する人々と定義されている極度の貧困をあらゆる場所で終わらせる。',
  '2030年までに、飢餓を撲滅し、全ての人々、特に貧困層及び幼児を含む脆弱な立場にある人々が一年中安全かつ栄養のある食料を十分得られるようにする。',
  '2030年までに、世界の妊産婦の死亡率を出生10万人当たり70人未満に削減する。',
  '2030年までに、全ての子供が男女の区別なく、適切かつ効果的な学習成果をもたらす、無償かつ公正で質の高い初等教育及び中等教育を修了できるようにする。',
  'あらゆる場所における全ての女性及び女児に対するあらゆる形態の差別を撤廃する。',
  '2030年までに、全ての人々の、安全で安価な飲料水の普遍的かつ衡平なアクセスを達成する。',
];

final status=[

];

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = '/home';

  @override
  Widget build(BuildContext context,WidgetRef ref){
    _dataSource = _getDataSource();
    final random=ref.watch(randomProvider);
    ref.watch(countProvider);
    number=random.nextInt(6);//0~5までのrandomをもとめる
    return CupertinoPageScaffold(
      backgroundColor: Colors.brown.shade50,
      navigationBar: new CupertinoNavigationBar(
        backgroundColor: Colors.brown.shade50,
        trailing: Icon(CupertinoIcons.forward),
      ),
        child: Stack(
            children: [
                Positioned(
                  //alignment: Alignment.topLeft,
                  top: -8,
                  right: 200,
                  child:SizedBox(
                  height: 85,
                  child: CupertinoButton(
                  onPressed: () {
                    showCupertinoDialog<void>(
                        //barrierColor: background(number)!.withOpacity(0.3),
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                        title:  Text("目標 "+(number+1).toString()+" の具体例"),
                        content: Text(explanation[number]),
                        actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                            child: const Text("Cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                  );
                },
                  child:Image.asset(
                    'image/'+(number+1).toString()+'.jpg',
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
                child:Container(
                  width: 53,
                  padding: EdgeInsets.all(3),
                child:FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    ref.read(countProvider.state).state+=1;
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
                child:FloatingActionButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black54,
                  onPressed: () {
                    addEvent(app!);
                  },
                  child: const Icon(Icons.add),
                ),
              ),
          ],
      ),
    );
  }
  Color? background(int number){
    switch(number){
      case 0:
        return  Colors.red;
      case 1:
        return  Colors.yellow;
      case 2:
        return  Colors.green;
      case 3:
        return  Colors.red;
      case 4:
        return  Colors.orange;
      case 5:
        return  Colors.blue;
    }
  }
}

class Event extends ConsumerWidget {
  Widget build(BuildContext context,WidgetRef ref){
    return Align(
      alignment: Alignment.center,
      child:Container(
        height: 370,
        child:SfCalendar(
          todayHighlightColor: Colors.black54,
          cellBorderColor: Colors.black38,
          backgroundColor: Colors.brown.shade50,
          view: CalendarView.month,
          dataSource: _dataSource,
          monthViewSettings: const MonthViewSettings(showAgenda: true,),
          scheduleViewSettings: const ScheduleViewSettings(),
          onTap: calendarTapped,
          allowedViews: const [
            CalendarView.day,
            CalendarView.week,
            CalendarView.workWeek,
            CalendarView.month,
            CalendarView.timelineDay,
            CalendarView.timelineWeek,
            CalendarView.timelineWorkWeek,
            CalendarView.timelineMonth,
            CalendarView.schedule
          ],
        ),
      ),
    );
  }
}


void calendarTapped(CalendarTapDetails calendarTapDetails) {
     app = Appointment(
      startTime: calendarTapDetails.date!,
      endTime: calendarTapDetails.date!.add(const Duration(hours: 1)),
      subject: '約束',
      color: Colors.grey);

}
void addEvent(Appointment app){
  _dataSource!.appointments!.add(app);
  _dataSource!.notifyListeners(
      CalendarDataSourceAction.add, <Appointment>[app]);
}

_DataSource _getDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1)),
    subject: 'Meeting',
    color: Colors.grey,
  ));
  return _DataSource(appointments);
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
