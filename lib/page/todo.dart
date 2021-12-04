import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

class ToDoPage extends ConsumerWidget {
  const ToDoPage({Key? key}) : super(key: key);
  static const String route = '/todo';

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
          title:  const Text('SDGs App')
      ),
      body: Center(
        child:const Text('toDo'),
      ),
    );
  }
}