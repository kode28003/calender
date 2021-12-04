import 'package:calender/apps/count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

class ToDoPage extends ConsumerWidget {
  const ToDoPage({Key? key}) : super(key: key);
  static const String route = '/todo';

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return CupertinoPageScaffold(
      backgroundColor: Colors.brown.shade50,
      navigationBar: new CupertinoNavigationBar(
        backgroundColor: Colors.brown.shade50,
        leading: CupertinoNavigationBarBackButton(
          color: Colors.black,
          previousPageTitle: 'Calendar',
          onPressed: (){
            Navigator.pop(context);
            //ref.read(countUpNotifierProvider).startTimer();
            ref.read(countProvider.state).state+=1;
          },
        ),
      ),
      child: Text('aaa')
    );
  }
}