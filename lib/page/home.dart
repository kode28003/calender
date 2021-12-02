import 'package:calender/apps/random.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender/apps/count.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/widgets.dart';

CalendarDataSource? _dataSource;
Appointment? app;
dynamic context1;
int number=1;
final explanation=[
  '2030年までに、現在１日1.25ドル未満で生活する人々と定義されている極度の貧困をあらゆる場所で終わらせる。',
  '2030年までに、飢餓を撲滅し、全ての人々、特に貧困層及び幼児を含む脆弱な立場にある人々が一年中安全かつ栄養のある食料を十分得られるようにする。',
  '2030年までに、世界の妊産婦の死亡率を出生10万人当たり70人未満に削減する。',
  '2030年までに、全ての子供が男女の区別なく、適切かつ効果的な学習成果をもたらす、無償かつ公正で質の高い初等教育及び中等教育を修了できるようにする。',
  'あらゆる場所における全ての女性及び女児に対するあらゆる形態の差別を撤廃する。',
  '2030年までに、全ての人々の、安全で安価な飲料水の普遍的かつ衡平なアクセスを達成する。',
];

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = '/home';

  @override
  Widget build(BuildContext context,WidgetRef ref){
    _dataSource = _getDataSource();
    context1=context;
    final random=ref.watch(randomProvider);
    number=random.nextInt(6);
        
    return Scaffold(
      appBar: AppBar(
        title:  const Text('SDGs App')
      ),
      body: ListView(
          children: [
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _children,
              ),
            ),
            SfCalendar(
              view: CalendarView.month,
              dataSource: _dataSource,
              monthViewSettings: const MonthViewSettings(showAgenda: true),
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
          ],
       // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countProvider.state).state+=1;
          addEvent(app!);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> get _children => List<Widget>.generate(1, (index) => Padding(
    padding: const EdgeInsets.all(4),
    child: SizedBox(
      height: 100,
      width: 120,
      child: GestureDetector(
        onTap: () {
          print('aaa');
          showDialog(
            context: context1,
            barrierDismissible: false,
            builder: (_) {
              return AlertDialog(
                title: const Text("詳細"),
                content: Text(explanation[number]),
                actions: [
                  FlatButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context1),
                  ),
                ],
              );
            },
          );
        },
        child:Image.asset('image/'+(number+1).toString()+'.jpg',width: 150,height: 100,),
      ),
    ),
  ));
}

class Count extends ConsumerWidget{
  const Count({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref){
    final count=ref.watch(countProvider);
    return Center(
      child:FittedBox(
        child:Text('count is $count',style: const TextStyle(fontSize:25),),
      ),
      );
  }
}

void calendarTapped(CalendarTapDetails calendarTapDetails) {
     app = Appointment(
      startTime: calendarTapDetails.date!,
      endTime: calendarTapDetails.date!.add(const Duration(hours: 1)),
      subject: '約束',
      color: Colors.greenAccent);

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
    color: Colors.teal,
  ));
  return _DataSource(appointments);
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
