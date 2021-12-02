import 'package:flutter/material.dart';
import 'package:calender/page/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'SDGs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    onGenerateRoute: (routeSettings) {
    switch (routeSettings.name) {
    case HomePage.route:
    return MaterialPageRoute(builder: (_) => const HomePage());
    }
    });
  }
}
