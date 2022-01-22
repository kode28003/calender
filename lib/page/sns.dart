import 'package:calender/data/storage.dart';
import 'package:calender/apps/firestore.dart';
import 'package:calender/page/home.dart';
import 'package:calender/page/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SnsPage extends ConsumerWidget {
  const SnsPage({Key? key}) : super(key: key);
  static const String route = '/sns';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.brown.shade50,
      navigationBar: new CupertinoNavigationBar(
        backgroundColor: Colors.brown.shade50,
        middle: const Text('SDGs Calendar'),
        leading: CupertinoButton(
          padding: EdgeInsets.fromLTRB(0, 6, 10, 5),
          child: Icon(
            CupertinoIcons.back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, ToDoPage.route);
          },
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Icon(
            CupertinoIcons.forward,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, HomePage.route);
          },
        ),
      ),
      child: Text("aa"),
    );
  }
}
