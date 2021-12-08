import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider=StateProvider((ref){
  return 0;
});


final countUpNotifierProvider=
    ChangeNotifierProvider((ref)=>CountUpNotifier());

class CountUpNotifier extends ChangeNotifier{
  int count =0;
  static const sec = Duration(seconds: 1);
  Timer? _timer;

  void init(){
    count=0;
  }
  void startTimer(){
    if(_timer!=null){
      _timer!.cancel();
    }
    _timer=Timer.periodic(sec, (timer) {
      updateCounter();
    });
  }

  void updateCounter(){
    if(count>0){
      count++;
      print(count.toString());
    if(count>5){
        count=1;
        notifyListeners();
      }
    }
  }


  void cancel(){
    _timer!.cancel();
  }

}