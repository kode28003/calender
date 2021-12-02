import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender/apps/count.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/widgets.dart';

CalendarDataSource? _dataSource;
Appointment? app;

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = '/home';
  @override
  Widget build(BuildContext context,WidgetRef ref){

    _dataSource = _getDataSource();

    return Scaffold(
      appBar: AppBar(
        title:  const Text('SDGs App')
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const FittedBox(
            //   child:Text(
            //     'You have pushed the button this many times:',style: TextStyle(fontSize: 20),
            //   ),
            // ),

            SfCalendar(
              view: CalendarView.month,
              dataSource: _dataSource,
              monthViewSettings: const MonthViewSettings(showAgenda: true),
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
        ),
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

/*
List<Event> _getDataSource() {
  final List<Event> event = <Event>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day , 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    event.add(Event('イベント', startTime, endTime, const Color(0xFF0F8644), false));
  return event;
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> event) {
    appointments = event;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Event {
  Event(this.eventName, this.from, this.to, this.background, this.isAllDay);
  Color background;
  String eventName;
  DateTime from;
  bool isAllDay;
  DateTime to;
}
*/
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
