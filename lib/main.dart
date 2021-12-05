import 'package:calender/page/todo.dart';
import 'package:flutter/material.dart';
import 'package:calender/page/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender/page/top.dart';
import 'package:flutter/cupertino.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'SDGs App',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.brown.shade200,
        )
      ),
        home: const HomePage(),
    onGenerateRoute: (routeSettings) {
    switch (routeSettings.name) {
    case HomePage.route:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case TopPage.route:
      return MaterialPageRoute(builder: (_) => const TopPage());
    case ToDoPage.route:
      return MaterialPageRoute(builder: (_) => const ToDoPage());
    }
    });
  }
}
