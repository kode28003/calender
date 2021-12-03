import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({Key? key}) : super(key: key);
  static const String route = '/home';

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
          title:  const Text('SDGs App')
      ),
      body: Center(

      ),
    );
  }
}