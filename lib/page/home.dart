import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender/apps/count.dart';

/*

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = '/home';
  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FittedBox(
              child:Text(
                'You have pushed the button this many times:',style: TextStyle(fontSize: 20),
              ),
            ),

            Count(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countProvider.state).state+=1;
        },
        child: Icon(Icons.add),
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