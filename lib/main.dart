import 'package:calender/page/sns.dart';
import 'package:calender/page/todo.dart';
import 'package:flutter/material.dart';
import 'package:calender/page/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender/page/top.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();//Firebaseを初期化する前に必須なコード
  await Firebase.initializeApp();
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
          primary: Colors.brown.shade300,
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
    case SnsPage.route:
      return MaterialPageRoute(builder: (_) => const SnsPage());
    }
    });
  }
}
